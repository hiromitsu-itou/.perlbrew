/*
 * This file was generated automatically by ExtUtils::ParseXS version 2.19 from the
 * contents of Encode.xs. Do not edit this file, edit Encode.xs instead.
 *
 *	ANY CHANGES MADE HERE WILL BE LOST! 
 *
 */

#line 1 "Encode.xs"
/*
 $Id: Encode.xs,v 2.14 2007/05/29 18:15:32 dankogai Exp $
 */

#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#define U8 U8
#include "encode.h"

# define PERLIO_MODNAME  "PerlIO::encoding"
# define PERLIO_FILENAME "PerlIO/encoding.pm"

/* set 1 or more to profile.  t/encoding.t dumps core because of
   Perl_warner and PerlIO don't work well */
#define ENCODE_XS_PROFILE 0

/* set 0 to disable floating point to calculate buffer size for
   encode_method().  1 is recommended. 2 restores NI-S original */
#define ENCODE_XS_USEFP   1

#define UNIMPLEMENTED(x,y) y x (SV *sv, char *encoding) {dTHX;   \
                         Perl_croak(aTHX_ "panic_unimplemented"); \
             return (y)0; /* fool picky compilers */ \
                         }
/**/

UNIMPLEMENTED(_encoded_utf8_to_bytes, I32)
UNIMPLEMENTED(_encoded_bytes_to_utf8, I32)

#define UTF8_ALLOW_STRICT 0
#define UTF8_ALLOW_NONSTRICT (UTF8_ALLOW_ANY &                    \
                              ~(UTF8_ALLOW_CONTINUATION |         \
                                UTF8_ALLOW_NON_CONTINUATION |     \
                                UTF8_ALLOW_LONG))

void
Encode_XSEncoding(pTHX_ encode_t * enc)
{
    dSP;
    HV *stash = gv_stashpv("Encode::XS", TRUE);
    SV *sv = sv_bless(newRV_noinc(newSViv(PTR2IV(enc))), stash);
    int i = 0;
    PUSHMARK(sp);
    XPUSHs(sv);
    while (enc->name[i]) {
    const char *name = enc->name[i++];
    XPUSHs(sv_2mortal(newSVpvn(name, strlen(name))));
    }
    PUTBACK;
    call_pv("Encode::define_encoding", G_DISCARD);
    SvREFCNT_dec(sv);
}

void
call_failure(SV * routine, U8 * done, U8 * dest, U8 * orig)
{
    /* Exists for breakpointing */
}


#define ERR_ENCODE_NOMAP "\"\\x{%04" UVxf "}\" does not map to %s"
#define ERR_DECODE_NOMAP "%s \"\\x%02" UVXf "\" does not map to Unicode"

static SV *
do_fallback_cb(pTHX_ UV ch, SV *fallback_cb)
{
    dSP;
    int argc;
    SV *temp, *retval;
    ENTER;
    SAVETMPS;
    PUSHMARK(sp);
    XPUSHs(sv_2mortal(newSVnv((UV)ch)));
    PUTBACK;
    argc = call_sv(fallback_cb, G_SCALAR);
    SPAGAIN;
    if (argc != 1){
	croak("fallback sub must return scalar!");
    }
    temp = newSVsv(POPs);
    PUTBACK;
    FREETMPS;
    LEAVE;
    retval = newSVpv("",0);
    sv_catsv(retval, temp);
    SvREFCNT_dec(temp);
    return retval;
}

static SV *
encode_method(pTHX_ const encode_t * enc, const encpage_t * dir, SV * src,
	      int check, STRLEN * offset, SV * term, int * retcode, 
	      SV *fallback_cb)
{
    STRLEN slen;
    U8 *s = (U8 *) SvPV(src, slen);
    STRLEN tlen  = slen;
    STRLEN ddone = 0;
    STRLEN sdone = 0;

    /* We allocate slen+1.
       PerlIO dumps core if this value is smaller than this. */
    SV *dst = sv_2mortal(newSV(slen+1));
    U8 *d = (U8 *)SvPVX(dst);
    STRLEN dlen = SvLEN(dst)-1;
    int code = 0;
    STRLEN trmlen = 0;
    U8 *trm = term ? (U8*) SvPV(term, trmlen) : NULL;

    if (offset) {
      s += *offset;
      if (slen > *offset){ /* safeguard against slen overflow */
      slen -= *offset;
      }else{
      slen = 0;
      }
      tlen = slen;
    }

    if (slen == 0){
    SvCUR_set(dst, 0);
    SvPOK_only(dst);
    goto ENCODE_END;
    }

    while( (code = do_encode(dir, s, &slen, d, dlen, &dlen, !check,
                 trm, trmlen)) ) 
    {
    SvCUR_set(dst, dlen+ddone);
    SvPOK_only(dst);
    
    if (code == ENCODE_FALLBACK || code == ENCODE_PARTIAL ||
        code == ENCODE_FOUND_TERM) {
        break;
    }
    switch (code) {
    case ENCODE_NOSPACE:
    {	
        STRLEN more = 0; /* make sure you initialize! */
        STRLEN sleft;
        sdone += slen;
        ddone += dlen;
        sleft = tlen - sdone;
#if ENCODE_XS_PROFILE >= 2
        Perl_warn(aTHX_
              "more=%d, sdone=%d, sleft=%d, SvLEN(dst)=%d\n",
              more, sdone, sleft, SvLEN(dst));
#endif
        if (sdone != 0) { /* has src ever been processed ? */
#if   ENCODE_XS_USEFP == 2
        more = (1.0*tlen*SvLEN(dst)+sdone-1)/sdone
            - SvLEN(dst);
#elif ENCODE_XS_USEFP
        more = (STRLEN)((1.0*SvLEN(dst)+1)/sdone * sleft);
#else
        /* safe until SvLEN(dst) == MAX_INT/16 */
        more = (16*SvLEN(dst)+1)/sdone/16 * sleft;
#endif
        }
        more += UTF8_MAXLEN; /* insurance policy */
        d = (U8 *) SvGROW(dst, SvLEN(dst) + more);
        /* dst need to grow need MORE bytes! */
        if (ddone >= SvLEN(dst)) {
        Perl_croak(aTHX_ "Destination couldn't be grown.");
        }
        dlen = SvLEN(dst)-ddone-1;
        d   += ddone;
        s   += slen;
        slen = tlen-sdone;
        continue;
    }
    case ENCODE_NOREP:
        /* encoding */	
        if (dir == enc->f_utf8) {
        STRLEN clen;
        UV ch =
            utf8n_to_uvuni(s+slen, (SvCUR(src)-slen),
                   &clen, UTF8_ALLOW_ANY|UTF8_CHECK_ONLY);
        /* if non-representable multibyte prefix at end of current buffer - break*/
        if (clen > tlen - sdone) break;
        if (check & ENCODE_DIE_ON_ERR) {
            Perl_croak(aTHX_ ERR_ENCODE_NOMAP,
                   (UV)ch, enc->name[0]);
            return &PL_sv_undef; /* never reaches but be safe */
        }
        if (check & ENCODE_WARN_ON_ERR){
            Perl_warner(aTHX_ packWARN(WARN_UTF8),
                ERR_ENCODE_NOMAP, (UV)ch, enc->name[0]);
        }
        if (check & ENCODE_RETURN_ON_ERR){
            goto ENCODE_SET_SRC;
        }
        if (check & (ENCODE_PERLQQ|ENCODE_HTMLCREF|ENCODE_XMLCREF)){
            SV* subchar = 
            (fallback_cb != &PL_sv_undef)
		? do_fallback_cb(aTHX_ ch, fallback_cb)
		: newSVpvf(check & ENCODE_PERLQQ ? "\\x{%04"UVxf"}" :
                 check & ENCODE_HTMLCREF ? "&#%" UVuf ";" :
                 "&#x%" UVxf ";", (UV)ch);
            sdone += slen + clen;
            ddone += dlen + SvCUR(subchar);
            sv_catsv(dst, subchar);
            SvREFCNT_dec(subchar);
        } else {
            /* fallback char */
            sdone += slen + clen;
            ddone += dlen + enc->replen;
            sv_catpvn(dst, (char*)enc->rep, enc->replen);
        }
        }
        /* decoding */
        else {
        if (check & ENCODE_DIE_ON_ERR){
            Perl_croak(aTHX_ ERR_DECODE_NOMAP,
                              enc->name[0], (UV)s[slen]);
            return &PL_sv_undef; /* never reaches but be safe */
        }
        if (check & ENCODE_WARN_ON_ERR){
            Perl_warner(
            aTHX_ packWARN(WARN_UTF8),
            ERR_DECODE_NOMAP,
               	        enc->name[0], (UV)s[slen]);
        }
        if (check & ENCODE_RETURN_ON_ERR){
            goto ENCODE_SET_SRC;
        }
        if (check &
            (ENCODE_PERLQQ|ENCODE_HTMLCREF|ENCODE_XMLCREF)){
            SV* subchar = 
            (fallback_cb != &PL_sv_undef)
		? do_fallback_cb(aTHX_ (UV)s[slen], fallback_cb) 
		: newSVpvf("\\x%02" UVXf, (UV)s[slen]);
            sdone += slen + 1;
            ddone += dlen + SvCUR(subchar);
            sv_catsv(dst, subchar);
            SvREFCNT_dec(subchar);
        } else {
            sdone += slen + 1;
            ddone += dlen + strlen(FBCHAR_UTF8);
            sv_catpv(dst, FBCHAR_UTF8);
        }
        }
        /* settle variables when fallback */
        d    = (U8 *)SvEND(dst);
            dlen = SvLEN(dst) - ddone - 1;
        s    = (U8*)SvPVX(src) + sdone;
        slen = tlen - sdone;
        break;

    default:
        Perl_croak(aTHX_ "Unexpected code %d converting %s %s",
               code, (dir == enc->f_utf8) ? "to" : "from",
               enc->name[0]);
        return &PL_sv_undef;
    }
    }
 ENCODE_SET_SRC:
    if (check && !(check & ENCODE_LEAVE_SRC)){
    sdone = SvCUR(src) - (slen+sdone);
    if (sdone) {
        sv_setpvn(src, (char*)s+slen, sdone);
    }
    SvCUR_set(src, sdone);
    }
    /* warn("check = 0x%X, code = 0x%d\n", check, code); */

    SvCUR_set(dst, dlen+ddone);
    SvPOK_only(dst);

#if ENCODE_XS_PROFILE
    if (SvCUR(dst) > SvCUR(src)){
    Perl_warn(aTHX_
          "SvLEN(dst)=%d, SvCUR(dst)=%d. %d bytes unused(%f %%)\n",
          SvLEN(dst), SvCUR(dst), SvLEN(dst) - SvCUR(dst),
          (SvLEN(dst) - SvCUR(dst))*1.0/SvLEN(dst)*100.0);
    }
#endif

    if (offset) 
      *offset += sdone + slen;

 ENCODE_END:
    *SvEND(dst) = '\0';
    if (retcode) *retcode = code;
    return dst;
}

static bool
strict_utf8(pTHX_ SV* sv)
{
    HV* hv;
    SV** svp;
    sv = SvRV(sv);
    if (!sv || SvTYPE(sv) != SVt_PVHV)
        return 0;
    hv = (HV*)sv;
    svp = hv_fetch(hv, "strict_utf8", 11, 0);
    if (!svp)
        return 0;
    return SvTRUE(*svp);
}

static U8*
process_utf8(pTHX_ SV* dst, U8* s, U8* e, int check,
             bool encode, bool strict, bool stop_at_partial)
{
    UV uv;
    STRLEN ulen;

    SvPOK_only(dst);
    SvCUR_set(dst,0);

    while (s < e) {
        if (UTF8_IS_INVARIANT(*s)) {
            sv_catpvn(dst, (char *)s, 1);
            s++;
            continue;
        }

        if (UTF8_IS_START(*s)) {
            U8 skip = UTF8SKIP(s);
            if ((s + skip) > e) {
                /* Partial character */
                /* XXX could check that rest of bytes are UTF8_IS_CONTINUATION(ch) */
                if (stop_at_partial || (check & ENCODE_STOP_AT_PARTIAL))
                    break;

                goto malformed_byte;
            }

            uv = utf8n_to_uvuni(s, e - s, &ulen,
                                UTF8_CHECK_ONLY | (strict ? UTF8_ALLOW_STRICT :
                                                            UTF8_ALLOW_NONSTRICT)
                               );
#if 1 /* perl-5.8.6 and older do not check UTF8_ALLOW_LONG */
        if (strict && uv > PERL_UNICODE_MAX)
        ulen = (STRLEN) -1;
#endif
            if (ulen == -1) {
                if (strict) {
                    uv = utf8n_to_uvuni(s, e - s, &ulen,
                                        UTF8_CHECK_ONLY | UTF8_ALLOW_NONSTRICT);
                    if (ulen == -1)
                        goto malformed_byte;
                    goto malformed;
                }
                goto malformed_byte;
            }


             /* Whole char is good */
             sv_catpvn(dst,(char *)s,skip);
             s += skip;
             continue;
        }

        /* If we get here there is something wrong with alleged UTF-8 */
    malformed_byte:
        uv = (UV)*s;
        ulen = 1;

    malformed:
        if (check & ENCODE_DIE_ON_ERR){
            if (encode)
                Perl_croak(aTHX_ ERR_ENCODE_NOMAP, uv, "utf8");
            else
                Perl_croak(aTHX_ ERR_DECODE_NOMAP, "utf8", uv);
        }
        if (check & ENCODE_WARN_ON_ERR){
            if (encode)
                Perl_warner(aTHX_ packWARN(WARN_UTF8),
                            ERR_ENCODE_NOMAP, uv, "utf8");
            else
                Perl_warner(aTHX_ packWARN(WARN_UTF8),
                            ERR_DECODE_NOMAP, "utf8", uv);
        }
        if (check & ENCODE_RETURN_ON_ERR) {
                break;
        }
        if (check & (ENCODE_PERLQQ|ENCODE_HTMLCREF|ENCODE_XMLCREF)){
            SV* subchar = newSVpvf(check & ENCODE_PERLQQ ? (ulen == 1 ? "\\x%02" UVXf : "\\x{%04" UVXf "}"):
                                   check & ENCODE_HTMLCREF ? "&#%" UVuf ";" :
                                   "&#x%" UVxf ";", uv);
            sv_catsv(dst, subchar);
            SvREFCNT_dec(subchar);
        } else {
            sv_catpv(dst, FBCHAR_UTF8);
        }
        s += ulen;
    }
    *SvEND(dst) = '\0';

    return s;
}


#ifndef PERL_UNUSED_VAR
#  define PERL_UNUSED_VAR(var) if (0) var = var
#endif

#line 413 "Encode.c"

XS(XS_Encode__utf8_decode_xs); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode__utf8_decode_xs)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items < 2 || items > 3)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::utf8::decode_xs", "obj, src, check = 0");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	SV *	obj = ST(0);
	SV *	src = ST(1);
	int	check;

	if (items < 3)
	    check = 0;
	else {
	    check = (int)SvIV(ST(2));
	}
#line 409 "Encode.xs"
{
    STRLEN slen;
    U8 *s = (U8 *) SvPV(src, slen);
    U8 *e = (U8 *) SvEND(src);
    SV *dst = newSV(slen>0?slen:1); /* newSV() abhors 0 -- inaba */

    /* 
     * PerlIO check -- we assume the object is of PerlIO if renewed
     */
    bool renewed = 0;
    dSP; ENTER; SAVETMPS;
    PUSHMARK(sp);
    XPUSHs(obj);
    PUTBACK;
    if (call_method("renewed",G_SCALAR) == 1) {
    SPAGAIN;
    renewed = (bool)POPi;
    PUTBACK; 
#if 0
    fprintf(stderr, "renewed == %d\n", renewed);
#endif
    }
    FREETMPS; LEAVE;
    /* end PerlIO check */

    if (SvUTF8(src)) {
    s = utf8_to_bytes(s,&slen);
    if (s) {
        SvCUR_set(src,slen);
        SvUTF8_off(src);
        e = s+slen;
    }
    else {
        croak("Cannot decode string with wide characters");
    }
    }

    s = process_utf8(aTHX_ dst, s, e, check, 0, strict_utf8(aTHX_ obj), renewed);

    /* Clear out translated part of source unless asked not to */
    if (check && !(check & ENCODE_LEAVE_SRC)){
    slen = e-s;
    if (slen) {
        sv_setpvn(src, (char*)s, slen);
    }
    SvCUR_set(src, slen);
    }
    SvUTF8_on(dst);
    ST(0) = sv_2mortal(dst);
    XSRETURN(1);
}
#line 488 "Encode.c"
    }
    XSRETURN(1);
}


XS(XS_Encode__utf8_encode_xs); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode__utf8_encode_xs)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items < 2 || items > 3)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::utf8::encode_xs", "obj, src, check = 0");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	SV *	obj = ST(0);
	SV *	src = ST(1);
	int	check;

	if (items < 3)
	    check = 0;
	else {
	    check = (int)SvIV(ST(2));
	}
#line 467 "Encode.xs"
{
    STRLEN slen;
    U8 *s = (U8 *) SvPV(src, slen);
    U8 *e = (U8 *) SvEND(src);
    SV *dst = newSV(slen>0?slen:1); /* newSV() abhors 0 -- inaba */
    if (SvUTF8(src)) {
    /* Already encoded */
    if (strict_utf8(aTHX_ obj)) {
        s = process_utf8(aTHX_ dst, s, e, check, 1, 1, 0);
    }
        else {
            /* trust it and just copy the octets */
    	    sv_setpvn(dst,(char *)s,(e-s));
        s = e;
        }
    }
    else {
    	/* Native bytes - can always encode */
    U8 *d = (U8 *) SvGROW(dst, 2*slen+1); /* +1 or assertion will botch */
    	while (s < e) {
    	    UV uv = NATIVE_TO_UNI((UV) *s);
	    s++; /* Above expansion of NATIVE_TO_UNI() is safer this way. */
            if (UNI_IS_INVARIANT(uv))
            	*d++ = (U8)UTF_TO_NATIVE(uv);
            else {
    	        *d++ = (U8)UTF8_EIGHT_BIT_HI(uv);
                *d++ = (U8)UTF8_EIGHT_BIT_LO(uv);
            }
    }
        SvCUR_set(dst, d- (U8 *)SvPVX(dst));
    	*SvEND(dst) = '\0';
    }

    /* Clear out translated part of source unless asked not to */
    if (check && !(check & ENCODE_LEAVE_SRC)){
    slen = e-s;
    if (slen) {
        sv_setpvn(src, (char*)s, slen);
    }
    SvCUR_set(src, slen);
    }
    SvPOK_only(dst);
    SvUTF8_off(dst);
    ST(0) = sv_2mortal(dst);
    XSRETURN(1);
}
#line 562 "Encode.c"
    }
    XSRETURN(1);
}


XS(XS_Encode__XS_renew); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode__XS_renew)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::XS::renew", "obj");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	SV *	obj = ST(0);
#line 522 "Encode.xs"
{
    XSRETURN(1);
}
#line 585 "Encode.c"
    }
    XSRETURN_EMPTY;
}


XS(XS_Encode__XS_renewed); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode__XS_renewed)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::XS::renewed", "obj");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	SV *	obj = ST(0);
	int	RETVAL;
	dXSTARG;
#line 530 "Encode.xs"
    RETVAL = 0;
#line 608 "Encode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Encode__XS_name); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode__XS_name)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::XS::name", "obj");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	SV *	obj = ST(0);
#line 538 "Encode.xs"
{
    encode_t *enc = INT2PTR(encode_t *, SvIV(SvRV(obj)));
    ST(0) = sv_2mortal(newSVpvn(enc->name[0],strlen(enc->name[0])));
    XSRETURN(1);
}
#line 634 "Encode.c"
    }
    XSRETURN(1);
}


XS(XS_Encode__XS_cat_decode); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode__XS_cat_decode)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items < 5 || items > 6)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::XS::cat_decode", "obj, dst, src, off, term, check_sv = &PL_sv_no");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	SV *	obj = ST(0);
	SV *	dst = ST(1);
	SV *	src = ST(2);
	SV *	off = ST(3);
	SV *	term = ST(4);
	SV *	check_sv;

	if (items < 6)
	    check_sv = &PL_sv_no;
	else {
	    check_sv = ST(5);
	}
#line 553 "Encode.xs"
{
    int check;
    SV *fallback_cb = &PL_sv_undef;
    encode_t *enc = INT2PTR(encode_t *, SvIV(SvRV(obj)));
    STRLEN offset = (STRLEN)SvIV(off);
    int code = 0;
    if (SvUTF8(src)) {
    	sv_utf8_downgrade(src, FALSE);
    }
    if (SvROK(check_sv)){
	fallback_cb = check_sv;
	check = ENCODE_PERLQQ|ENCODE_LEAVE_SRC; /* same as FB_PERLQQ */
    }else{
	check = SvIV(check_sv);
    }
    sv_catsv(dst, encode_method(aTHX_ enc, enc->t_utf8, src, check,
                &offset, term, &code, fallback_cb));
    SvIV_set(off, (IV)offset);
    if (code == ENCODE_FOUND_TERM) {
    ST(0) = &PL_sv_yes;
    }else{
    ST(0) = &PL_sv_no;
    }
    XSRETURN(1);
}
#line 690 "Encode.c"
    }
    XSRETURN(1);
}


XS(XS_Encode__XS_decode); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode__XS_decode)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items < 2 || items > 3)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::XS::decode", "obj, src, check_sv = &PL_sv_no");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	SV *	obj = ST(0);
	SV *	src = ST(1);
	SV *	check_sv;

	if (items < 3)
	    check_sv = &PL_sv_no;
	else {
	    check_sv = ST(2);
	}
#line 585 "Encode.xs"
{
    int check;
    SV *fallback_cb = &PL_sv_undef;
    encode_t *enc = INT2PTR(encode_t *, SvIV(SvRV(obj)));
    if (SvUTF8(src)) {
    	sv_utf8_downgrade(src, FALSE);
    }
    if (SvROK(check_sv)){
	fallback_cb = check_sv;
	check = ENCODE_PERLQQ|ENCODE_LEAVE_SRC; /* same as FB_PERLQQ */
    }else{
	check = SvIV(check_sv);
    }
    ST(0) = encode_method(aTHX_ enc, enc->t_utf8, src, check,
              NULL, Nullsv, NULL, fallback_cb);
    SvUTF8_on(ST(0));
    XSRETURN(1);
}
#line 736 "Encode.c"
    }
    XSRETURN(1);
}


XS(XS_Encode__XS_encode); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode__XS_encode)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items < 2 || items > 3)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::XS::encode", "obj, src, check_sv = &PL_sv_no");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	SV *	obj = ST(0);
	SV *	src = ST(1);
	SV *	check_sv;

	if (items < 3)
	    check_sv = &PL_sv_no;
	else {
	    check_sv = ST(2);
	}
#line 610 "Encode.xs"
{
    int check;
    SV *fallback_cb = &PL_sv_undef;
    encode_t *enc = INT2PTR(encode_t *, SvIV(SvRV(obj)));
    sv_utf8_upgrade(src);
    if (SvROK(check_sv)){
	fallback_cb = check_sv;
	check = ENCODE_PERLQQ|ENCODE_LEAVE_SRC; /* same as FB_PERLQQ */
    }else{
	check = SvIV(check_sv);
    }
    ST(0) = encode_method(aTHX_ enc, enc->f_utf8, src, check,
              NULL, Nullsv, NULL, fallback_cb);
    XSRETURN(1);
}
#line 779 "Encode.c"
    }
    XSRETURN(1);
}


XS(XS_Encode__XS_needs_lines); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode__XS_needs_lines)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::XS::needs_lines", "obj");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	SV *	obj = ST(0);
#line 630 "Encode.xs"
{
    /* encode_t *enc = INT2PTR(encode_t *, SvIV(SvRV(obj))); */
    ST(0) = &PL_sv_no;
    XSRETURN(1);
}
#line 804 "Encode.c"
    }
    XSRETURN(1);
}


XS(XS_Encode__XS_perlio_ok); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode__XS_perlio_ok)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::XS::perlio_ok", "obj");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	SV *	obj = ST(0);
#line 640 "Encode.xs"
{
    /* encode_t *enc = INT2PTR(encode_t *, SvIV(SvRV(obj))); */
    /* require_pv(PERLIO_FILENAME); */

    eval_pv("require PerlIO::encoding", 0);

    if (SvTRUE(get_sv("@", 0))) {
    ST(0) = &PL_sv_no;
    }else{
    ST(0) = &PL_sv_yes;
    }
    XSRETURN(1);
}
#line 837 "Encode.c"
    }
    XSRETURN(1);
}


XS(XS_Encode__XS_mime_name); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode__XS_mime_name)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::XS::mime_name", "obj");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	SV *	obj = ST(0);
#line 658 "Encode.xs"
{
    encode_t *enc = INT2PTR(encode_t *, SvIV(SvRV(obj)));
    SV *retval;
    eval_pv("require Encode::MIME::Name", 0);

    if (SvTRUE(get_sv("@", 0))) {
	ST(0) = &PL_sv_undef;
    }else{
	ENTER;
	SAVETMPS;
	PUSHMARK(sp);
	XPUSHs(sv_2mortal(newSVpvn(enc->name[0], strlen(enc->name[0]))));
	PUTBACK;
	call_pv("Encode::MIME::Name::get_mime_name", G_SCALAR);
	SPAGAIN;
	retval = newSVsv(POPs);
	PUTBACK;
	FREETMPS;
	LEAVE;
	/* enc->name[0] */
	ST(0) = retval;
    }
    XSRETURN(1);
}
#line 881 "Encode.c"
    }
    XSRETURN(1);
}


XS(XS_Encode__bytes_to_utf8); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode__bytes_to_utf8)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items < 1)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::_bytes_to_utf8", "sv, ...");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	SV *	sv = ST(0);
	I32	RETVAL;
	dXSTARG;
#line 691 "Encode.xs"
{
    SV * encoding = items == 2 ? ST(1) : Nullsv;

    if (encoding)
    RETVAL = _encoded_bytes_to_utf8(sv, SvPV_nolen(encoding));
    else {
    STRLEN len;
    U8*    s = (U8*)SvPV(sv, len);
    U8*    converted;

    converted = bytes_to_utf8(s, &len); /* This allocs */
    sv_setpvn(sv, (char *)converted, len);
    SvUTF8_on(sv); /* XXX Should we? */
    Safefree(converted);                /* ... so free it */
    RETVAL = len;
    }
}
#line 920 "Encode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Encode__utf8_to_bytes); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode__utf8_to_bytes)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items < 1)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::_utf8_to_bytes", "sv, ...");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	SV *	sv = ST(0);
	I32	RETVAL;
	dXSTARG;
#line 715 "Encode.xs"
{
    SV * to    = items > 1 ? ST(1) : Nullsv;
    SV * check = items > 2 ? ST(2) : Nullsv;

    if (to) {
    RETVAL = _encoded_utf8_to_bytes(sv, SvPV_nolen(to));
    } else {
    STRLEN len;
    U8 *s = (U8*)SvPV(sv, len);

    RETVAL = 0;
    if (SvTRUE(check)) {
        /* Must do things the slow way */
        U8 *dest;
            /* We need a copy to pass to check() */
        U8 *src  = s;
        U8 *send = s + len;
        U8 *d0;

        New(83, dest, len, U8); /* I think */
        d0 = dest;

        while (s < send) {
                if (*s < 0x80){
            *dest++ = *s++;
                } else {
            STRLEN ulen;
            UV uv = *s++;

            /* Have to do it all ourselves because of error routine,
               aargh. */
            if (!(uv & 0x40)){ goto failure; }
            if      (!(uv & 0x20)) { ulen = 2;  uv &= 0x1f; }
            else if (!(uv & 0x10)) { ulen = 3;  uv &= 0x0f; }
            else if (!(uv & 0x08)) { ulen = 4;  uv &= 0x07; }
            else if (!(uv & 0x04)) { ulen = 5;  uv &= 0x03; }
            else if (!(uv & 0x02)) { ulen = 6;  uv &= 0x01; }
            else if (!(uv & 0x01)) { ulen = 7;  uv = 0; }
            else                   { ulen = 13; uv = 0; }

            /* Note change to utf8.c variable naming, for variety */
            while (ulen--) {
            if ((*s & 0xc0) != 0x80){
                goto failure;
            } else {
                uv = (uv << 6) | (*s++ & 0x3f);
            }
          }
          if (uv > 256) {
          failure:
              call_failure(check, s, dest, src);
              /* Now what happens? */
          }
          *dest++ = (U8)uv;
        }
        }
        RETVAL = dest - d0;
        sv_usepvn(sv, (char *)dest, RETVAL);
        SvUTF8_off(sv);
    } else {
        RETVAL = (utf8_to_bytes(s, &len) ? len : 0);
    }
    }
}
#line 1007 "Encode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Encode_is_utf8); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode_is_utf8)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items < 1 || items > 2)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::is_utf8", "sv, check = 0");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	SV *	sv = ST(0);
	int	check;
	bool	RETVAL;

	if (items < 2)
	    check = 0;
	else {
	    check = (int)SvIV(ST(1));
	}
#line 787 "Encode.xs"
{
    if (SvGMAGICAL(sv)) /* it could be $1, for example */
    sv = newSVsv(sv); /* GMAGIG will be done */
    RETVAL = SvUTF8(sv) ? TRUE : FALSE;
    if (RETVAL &&
        check  &&
        !is_utf8_string((U8*)SvPVX(sv), SvCUR(sv)))
        RETVAL = FALSE;
    if (sv != ST(0))
    SvREFCNT_dec(sv); /* it was a temp copy */
}
#line 1047 "Encode.c"
	ST(0) = boolSV(RETVAL);
	sv_2mortal(ST(0));
    }
    XSRETURN(1);
}


XS(XS_Encode__utf8_on); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode__utf8_on)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::_utf8_on", "sv");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	SV *	sv = ST(0);
	SV *	RETVAL;
#line 805 "Encode.xs"
{
    if (SvPOK(sv)) {
    SV *rsv = newSViv(SvUTF8(sv));
    RETVAL = rsv;
    SvUTF8_on(sv);
    } else {
    RETVAL = &PL_sv_undef;
    }
}
#line 1079 "Encode.c"
	ST(0) = RETVAL;
	sv_2mortal(ST(0));
    }
    XSRETURN(1);
}


XS(XS_Encode__utf8_off); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode__utf8_off)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::_utf8_off", "sv");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	SV *	sv = ST(0);
	SV *	RETVAL;
#line 821 "Encode.xs"
{
    if (SvPOK(sv)) {
    SV *rsv = newSViv(SvUTF8(sv));
    RETVAL = rsv;
    SvUTF8_off(sv);
    } else {
    RETVAL = &PL_sv_undef;
    }
}
#line 1111 "Encode.c"
	ST(0) = RETVAL;
	sv_2mortal(ST(0));
    }
    XSRETURN(1);
}


XS(XS_Encode_DIE_ON_ERR); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode_DIE_ON_ERR)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 0)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::DIE_ON_ERR", "");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	RETVAL;
	dXSTARG;
#line 836 "Encode.xs"
    RETVAL = ENCODE_DIE_ON_ERR;
#line 1135 "Encode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Encode_WARN_ON_ERR); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode_WARN_ON_ERR)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 0)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::WARN_ON_ERR", "");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	RETVAL;
	dXSTARG;
#line 843 "Encode.xs"
    RETVAL = ENCODE_WARN_ON_ERR;
#line 1158 "Encode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Encode_LEAVE_SRC); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode_LEAVE_SRC)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 0)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::LEAVE_SRC", "");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	RETVAL;
	dXSTARG;
#line 850 "Encode.xs"
    RETVAL = ENCODE_LEAVE_SRC;
#line 1181 "Encode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Encode_RETURN_ON_ERR); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode_RETURN_ON_ERR)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 0)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::RETURN_ON_ERR", "");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	RETVAL;
	dXSTARG;
#line 857 "Encode.xs"
    RETVAL = ENCODE_RETURN_ON_ERR;
#line 1204 "Encode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Encode_PERLQQ); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode_PERLQQ)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 0)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::PERLQQ", "");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	RETVAL;
	dXSTARG;
#line 864 "Encode.xs"
    RETVAL = ENCODE_PERLQQ;
#line 1227 "Encode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Encode_HTMLCREF); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode_HTMLCREF)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 0)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::HTMLCREF", "");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	RETVAL;
	dXSTARG;
#line 871 "Encode.xs"
    RETVAL = ENCODE_HTMLCREF;
#line 1250 "Encode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Encode_XMLCREF); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode_XMLCREF)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 0)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::XMLCREF", "");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	RETVAL;
	dXSTARG;
#line 878 "Encode.xs"
    RETVAL = ENCODE_XMLCREF;
#line 1273 "Encode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Encode_STOP_AT_PARTIAL); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode_STOP_AT_PARTIAL)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 0)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::STOP_AT_PARTIAL", "");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	RETVAL;
	dXSTARG;
#line 885 "Encode.xs"
    RETVAL = ENCODE_STOP_AT_PARTIAL;
#line 1296 "Encode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Encode_FB_DEFAULT); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode_FB_DEFAULT)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 0)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::FB_DEFAULT", "");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	RETVAL;
	dXSTARG;
#line 892 "Encode.xs"
    RETVAL = ENCODE_FB_DEFAULT;
#line 1319 "Encode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Encode_FB_CROAK); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode_FB_CROAK)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 0)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::FB_CROAK", "");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	RETVAL;
	dXSTARG;
#line 899 "Encode.xs"
    RETVAL = ENCODE_FB_CROAK;
#line 1342 "Encode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Encode_FB_QUIET); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode_FB_QUIET)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 0)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::FB_QUIET", "");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	RETVAL;
	dXSTARG;
#line 906 "Encode.xs"
    RETVAL = ENCODE_FB_QUIET;
#line 1365 "Encode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Encode_FB_WARN); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode_FB_WARN)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 0)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::FB_WARN", "");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	RETVAL;
	dXSTARG;
#line 913 "Encode.xs"
    RETVAL = ENCODE_FB_WARN;
#line 1388 "Encode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Encode_FB_PERLQQ); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode_FB_PERLQQ)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 0)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::FB_PERLQQ", "");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	RETVAL;
	dXSTARG;
#line 920 "Encode.xs"
    RETVAL = ENCODE_FB_PERLQQ;
#line 1411 "Encode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Encode_FB_HTMLCREF); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode_FB_HTMLCREF)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 0)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::FB_HTMLCREF", "");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	RETVAL;
	dXSTARG;
#line 927 "Encode.xs"
    RETVAL = ENCODE_FB_HTMLCREF;
#line 1434 "Encode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Encode_FB_XMLCREF); /* prototype to pass -Wmissing-prototypes */
XS(XS_Encode_FB_XMLCREF)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 0)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Encode::FB_XMLCREF", "");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	RETVAL;
	dXSTARG;
#line 934 "Encode.xs"
    RETVAL = ENCODE_FB_XMLCREF;
#line 1457 "Encode.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}

#ifdef __cplusplus
extern "C"
#endif
XS(boot_Encode); /* prototype to pass -Wmissing-prototypes */
XS(boot_Encode)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    char* file = __FILE__;

    PERL_UNUSED_VAR(cv); /* -W */
    PERL_UNUSED_VAR(items); /* -W */
    XS_VERSION_BOOTCHECK ;

        newXS("Encode::utf8::decode_xs", XS_Encode__utf8_decode_xs, file);
        newXS("Encode::utf8::encode_xs", XS_Encode__utf8_encode_xs, file);
        newXSproto("Encode::XS::renew", XS_Encode__XS_renew, file, "$");
        newXSproto("Encode::XS::renewed", XS_Encode__XS_renewed, file, "$");
        newXSproto("Encode::XS::name", XS_Encode__XS_name, file, "$");
        newXSproto("Encode::XS::cat_decode", XS_Encode__XS_cat_decode, file, "$$$$$;$");
        newXSproto("Encode::XS::decode", XS_Encode__XS_decode, file, "$$;$");
        newXSproto("Encode::XS::encode", XS_Encode__XS_encode, file, "$$;$");
        newXSproto("Encode::XS::needs_lines", XS_Encode__XS_needs_lines, file, "$");
        newXSproto("Encode::XS::perlio_ok", XS_Encode__XS_perlio_ok, file, "$");
        newXSproto("Encode::XS::mime_name", XS_Encode__XS_mime_name, file, "$");
        newXSproto("Encode::_bytes_to_utf8", XS_Encode__bytes_to_utf8, file, "$;@");
        newXSproto("Encode::_utf8_to_bytes", XS_Encode__utf8_to_bytes, file, "$;@");
        newXSproto("Encode::is_utf8", XS_Encode_is_utf8, file, "$;$");
        newXSproto("Encode::_utf8_on", XS_Encode__utf8_on, file, "$");
        newXSproto("Encode::_utf8_off", XS_Encode__utf8_off, file, "$");
        newXSproto("Encode::DIE_ON_ERR", XS_Encode_DIE_ON_ERR, file, "");
        newXSproto("Encode::WARN_ON_ERR", XS_Encode_WARN_ON_ERR, file, "");
        newXSproto("Encode::LEAVE_SRC", XS_Encode_LEAVE_SRC, file, "");
        newXSproto("Encode::RETURN_ON_ERR", XS_Encode_RETURN_ON_ERR, file, "");
        newXSproto("Encode::PERLQQ", XS_Encode_PERLQQ, file, "");
        newXSproto("Encode::HTMLCREF", XS_Encode_HTMLCREF, file, "");
        newXSproto("Encode::XMLCREF", XS_Encode_XMLCREF, file, "");
        newXSproto("Encode::STOP_AT_PARTIAL", XS_Encode_STOP_AT_PARTIAL, file, "");
        newXSproto("Encode::FB_DEFAULT", XS_Encode_FB_DEFAULT, file, "");
        newXSproto("Encode::FB_CROAK", XS_Encode_FB_CROAK, file, "");
        newXSproto("Encode::FB_QUIET", XS_Encode_FB_QUIET, file, "");
        newXSproto("Encode::FB_WARN", XS_Encode_FB_WARN, file, "");
        newXSproto("Encode::FB_PERLQQ", XS_Encode_FB_PERLQQ, file, "");
        newXSproto("Encode::FB_HTMLCREF", XS_Encode_FB_HTMLCREF, file, "");
        newXSproto("Encode::FB_XMLCREF", XS_Encode_FB_XMLCREF, file, "");

    /* Initialisation Section */

#line 939 "Encode.xs"
{
#include "def_t.h"
#include "def_t.exh"
}

#line 1520 "Encode.c"

    /* End of Initialisation Section */

    XSRETURN_YES;
}

