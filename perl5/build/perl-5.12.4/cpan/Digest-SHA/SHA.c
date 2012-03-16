/*
 * This file was generated automatically by ExtUtils::ParseXS version 2.21 from the
 * contents of SHA.xs. Do not edit this file, edit SHA.xs instead.
 *
 *	ANY CHANGES MADE HERE WILL BE LOST! 
 *
 */

#line 1 "SHA.xs"
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "src/sha.c"
#include "src/hmac.c"

static int ix2alg[] =
	{1,1,1,224,224,224,256,256,256,384,384,384,512,512,512};

#line 21 "SHA.c"
#ifndef PERL_UNUSED_VAR
#  define PERL_UNUSED_VAR(var) if (0) var = var
#endif

#ifndef PERL_ARGS_ASSERT_CROAK_XS_USAGE
#define PERL_ARGS_ASSERT_CROAK_XS_USAGE assert(cv); assert(params)

/* prototype to pass -Wmissing-prototypes */
STATIC void
S_croak_xs_usage(pTHX_ const CV *const cv, const char *const params);

STATIC void
S_croak_xs_usage(pTHX_ const CV *const cv, const char *const params)
{
    const GV *const gv = CvGV(cv);

    PERL_ARGS_ASSERT_CROAK_XS_USAGE;

    if (gv) {
        const char *const gvname = GvNAME(gv);
        const HV *const stash = GvSTASH(gv);
        const char *const hvname = stash ? HvNAME(stash) : NULL;

        if (hvname)
            Perl_croak(aTHX_ "Usage: %s::%s(%s)", hvname, gvname, params);
        else
            Perl_croak(aTHX_ "Usage: %s(%s)", gvname, params);
    } else {
        /* Pants. I don't think that it should be possible to get here. */
        Perl_croak(aTHX_ "Usage: CODE(0x%"UVxf")(%s)", PTR2UV(cv), params);
    }
}
#undef  PERL_ARGS_ASSERT_CROAK_XS_USAGE

#ifdef PERL_IMPLICIT_CONTEXT
#define croak_xs_usage(a,b)	S_croak_xs_usage(aTHX_ a,b)
#else
#define croak_xs_usage		S_croak_xs_usage
#endif

#endif

/* NOTE: the prototype of newXSproto() is different in versions of perls,
 * so we define a portable version of newXSproto()
 */
#ifdef newXS_flags
#define newXSproto_portable(name, c_impl, file, proto) newXS_flags(name, c_impl, file, proto, 0)
#else
#define newXSproto_portable(name, c_impl, file, proto) (PL_Sv=(SV*)newXS(name, c_impl, file), sv_setpv(PL_Sv, proto), (CV*)PL_Sv)
#endif /* !defined(newXS_flags) */

#line 73 "SHA.c"
#include "src/sha.h"
#include "src/hmac.h"
#ifndef INT2PTR
#define INT2PTR(p, i) (p) (i)
#endif

XS(XS_Digest__SHA_shaclose); /* prototype to pass -Wmissing-prototypes */
XS(XS_Digest__SHA_shaclose)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       croak_xs_usage(cv,  "s");
    {
	SHA *	s;
	int	RETVAL;
	dXSTARG;

	if (SvROK(ST(0)) && sv_derived_from(ST(0), "SHAPtr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    s = INT2PTR(SHA *,tmp);
	}
	else
	    Perl_croak(aTHX_ "%s: %s is not of type %s",
			"Digest::SHA::shaclose",
			"s", "SHAPtr");

	RETVAL = shaclose(s);
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Digest__SHA_shadump); /* prototype to pass -Wmissing-prototypes */
XS(XS_Digest__SHA_shadump)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 2)
       croak_xs_usage(cv,  "file, s");
    {
	char *	file = (char *)SvPV_nolen(ST(0));
	SHA *	s;
	int	RETVAL;
	dXSTARG;

	if (SvROK(ST(1)) && sv_derived_from(ST(1), "SHAPtr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(1)));
	    s = INT2PTR(SHA *,tmp);
	}
	else
	    Perl_croak(aTHX_ "%s: %s is not of type %s",
			"Digest::SHA::shadump",
			"s", "SHAPtr");

	RETVAL = shadump(file, s);
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Digest__SHA_shadup); /* prototype to pass -Wmissing-prototypes */
XS(XS_Digest__SHA_shadup)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       croak_xs_usage(cv,  "s");
    {
	SHA *	s;
	SHA *	RETVAL;

	if (SvROK(ST(0)) && sv_derived_from(ST(0), "SHAPtr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    s = INT2PTR(SHA *,tmp);
	}
	else
	    Perl_croak(aTHX_ "%s: %s is not of type %s",
			"Digest::SHA::shadup",
			"s", "SHAPtr");

	RETVAL = shadup(s);
	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "SHAPtr", (void*)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Digest__SHA_shaload); /* prototype to pass -Wmissing-prototypes */
XS(XS_Digest__SHA_shaload)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       croak_xs_usage(cv,  "file");
    {
	char *	file = (char *)SvPV_nolen(ST(0));
	SHA *	RETVAL;

	RETVAL = shaload(file);
	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "SHAPtr", (void*)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Digest__SHA_shaopen); /* prototype to pass -Wmissing-prototypes */
XS(XS_Digest__SHA_shaopen)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       croak_xs_usage(cv,  "alg");
    {
	int	alg = (int)SvIV(ST(0));
	SHA *	RETVAL;

	RETVAL = shaopen(alg);
	ST(0) = sv_newmortal();
	sv_setref_pv(ST(0), "SHAPtr", (void*)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Digest__SHA_sharewind); /* prototype to pass -Wmissing-prototypes */
XS(XS_Digest__SHA_sharewind)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       croak_xs_usage(cv,  "s");
    {
	SHA *	s;

	if (SvROK(ST(0)) && sv_derived_from(ST(0), "SHAPtr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    s = INT2PTR(SHA *,tmp);
	}
	else
	    Perl_croak(aTHX_ "%s: %s is not of type %s",
			"Digest::SHA::sharewind",
			"s", "SHAPtr");

	sharewind(s);
    }
    XSRETURN_EMPTY;
}


XS(XS_Digest__SHA_shawrite); /* prototype to pass -Wmissing-prototypes */
XS(XS_Digest__SHA_shawrite)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 3)
       croak_xs_usage(cv,  "bitstr, bitcnt, s");
    {
	unsigned char *	bitstr = (unsigned char *)SvPV_nolen(ST(0));
	unsigned long	bitcnt = (unsigned long)SvUV(ST(1));
	SHA *	s;
	unsigned long	RETVAL;
	dXSTARG;

	if (SvROK(ST(2)) && sv_derived_from(ST(2), "SHAPtr")) {
	    IV tmp = SvIV((SV*)SvRV(ST(2)));
	    s = INT2PTR(SHA *,tmp);
	}
	else
	    Perl_croak(aTHX_ "%s: %s is not of type %s",
			"Digest::SHA::shawrite",
			"s", "SHAPtr");

	RETVAL = shawrite(bitstr, bitcnt, s);
	XSprePUSH; PUSHu((UV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Digest__SHA_sha1); /* prototype to pass -Wmissing-prototypes */
XS(XS_Digest__SHA_sha1)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    dXSI32;
    PERL_UNUSED_VAR(cv); /* -W */
    PERL_UNUSED_VAR(ax); /* -Wall */
    SP -= items;
    {
#line 72 "SHA.xs"
	int i;
	unsigned char *data;
	STRLEN len;
	SHA *state;
	char *result;
#line 298 "SHA.c"
#line 78 "SHA.xs"
	if ((state = shaopen(ix2alg[ix])) == NULL)
		XSRETURN_UNDEF;
	for (i = 0; i < items; i++) {
		data = (unsigned char *) (SvPV(ST(i), len));
		shawrite(data, len << 3, state);
	}
	shafinish(state);
	len = 0;
	if (ix % 3 == 0) {
		result = (char *) shadigest(state);
		len = shadsize(state);
	}
	else if (ix % 3 == 1)
		result = shahex(state);
	else
		result = shabase64(state);
	ST(0) = sv_2mortal(newSVpv(result, len));
	shaclose(state);
	XSRETURN(1);
#line 319 "SHA.c"
	PUTBACK;
	return;
    }
}


XS(XS_Digest__SHA_hmac_sha1); /* prototype to pass -Wmissing-prototypes */
XS(XS_Digest__SHA_hmac_sha1)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    dXSI32;
    PERL_UNUSED_VAR(cv); /* -W */
    PERL_UNUSED_VAR(ax); /* -Wall */
    SP -= items;
    {
#line 117 "SHA.xs"
	int i;
	unsigned char *key;
	unsigned char *data;
	STRLEN len;
	HMAC *state;
	char *result;
#line 346 "SHA.c"
#line 124 "SHA.xs"
	key = (unsigned char *) (SvPV(ST(items-1), len));
	if ((state = hmacopen(ix2alg[ix], key, len)) == NULL)
		XSRETURN_UNDEF;
	for (i = 0; i < items - 1; i++) {
		data = (unsigned char *) (SvPV(ST(i), len));
		hmacwrite(data, len << 3, state);
	}
	hmacfinish(state);
	len = 0;
	if (ix % 3 == 0) {
		result = (char *) hmacdigest(state);
		len = shadsize(state->osha);
	}
	else if (ix % 3 == 1)
		result = hmachex(state);
	else
		result = hmacbase64(state);
	ST(0) = sv_2mortal(newSVpv(result, len));
	hmacclose(state);
	XSRETURN(1);
#line 368 "SHA.c"
	PUTBACK;
	return;
    }
}


XS(XS_Digest__SHA_hashsize); /* prototype to pass -Wmissing-prototypes */
XS(XS_Digest__SHA_hashsize)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    dXSI32;
    if (items != 1)
       croak_xs_usage(cv,  "self");
    PERL_UNUSED_VAR(ax); /* -Wall */
    SP -= items;
    {
	SV *	self = ST(0);
#line 152 "SHA.xs"
	SHA *state;
	int result;
#line 393 "SHA.c"
#line 155 "SHA.xs"
	state = INT2PTR(SHA *, SvIV(SvRV(SvRV(self))));
	result = shadsize(state) << 3;
	if (ix == 1 && result == 160)
		result = 1;
	ST(0) = sv_2mortal(newSViv(result));
	XSRETURN(1);
#line 401 "SHA.c"
	PUTBACK;
	return;
    }
}


XS(XS_Digest__SHA_add); /* prototype to pass -Wmissing-prototypes */
XS(XS_Digest__SHA_add)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items < 1)
       croak_xs_usage(cv,  "self, ...");
    PERL_UNUSED_VAR(ax); /* -Wall */
    SP -= items;
    {
	SV *	self = ST(0);
#line 166 "SHA.xs"
	int i;
	unsigned char *data;
	STRLEN len;
	SHA *state;
#line 427 "SHA.c"
#line 171 "SHA.xs"
	state = INT2PTR(SHA *, SvIV(SvRV(SvRV(self))));
	for (i = 1; i < items; i++) {
		data = (unsigned char *) (SvPV(ST(i), len));
		shawrite(data, len << 3, state);
	}
	XSRETURN(1);
#line 435 "SHA.c"
	PUTBACK;
	return;
    }
}


XS(XS_Digest__SHA_digest); /* prototype to pass -Wmissing-prototypes */
XS(XS_Digest__SHA_digest)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    dXSI32;
    if (items != 1)
       croak_xs_usage(cv,  "self");
    PERL_UNUSED_VAR(ax); /* -Wall */
    SP -= items;
    {
	SV *	self = ST(0);
#line 186 "SHA.xs"
	STRLEN len;
	SHA *state;
	char *result;
#line 461 "SHA.c"
#line 190 "SHA.xs"
	state = INT2PTR(SHA *, SvIV(SvRV(SvRV(self))));
	shafinish(state);
	len = 0;
	if (ix == 0) {
		result = (char *) shadigest(state);
		len = shadsize(state);
	}
	else if (ix == 1)
		result = shahex(state);
	else
		result = shabase64(state);
	ST(0) = sv_2mortal(newSVpv(result, len));
	sharewind(state);
	XSRETURN(1);
#line 477 "SHA.c"
	PUTBACK;
	return;
    }
}

#ifdef __cplusplus
extern "C"
#endif
XS(boot_Digest__SHA); /* prototype to pass -Wmissing-prototypes */
XS(boot_Digest__SHA)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
#if (PERL_REVISION == 5 && PERL_VERSION < 9)
    char* file = __FILE__;
#else
    const char* file = __FILE__;
#endif

    PERL_UNUSED_VAR(cv); /* -W */
    PERL_UNUSED_VAR(items); /* -W */
    XS_VERSION_BOOTCHECK ;

    {
        CV * cv ;

        (void)newXSproto_portable("Digest::SHA::shaclose", XS_Digest__SHA_shaclose, file, "$");
        (void)newXSproto_portable("Digest::SHA::shadump", XS_Digest__SHA_shadump, file, "$$");
        (void)newXSproto_portable("Digest::SHA::shadup", XS_Digest__SHA_shadup, file, "$");
        (void)newXSproto_portable("Digest::SHA::shaload", XS_Digest__SHA_shaload, file, "$");
        (void)newXSproto_portable("Digest::SHA::shaopen", XS_Digest__SHA_shaopen, file, "$");
        (void)newXSproto_portable("Digest::SHA::sharewind", XS_Digest__SHA_sharewind, file, "$");
        (void)newXSproto_portable("Digest::SHA::shawrite", XS_Digest__SHA_shawrite, file, "$$$");
        cv = newXSproto_portable("Digest::SHA::sha512_hex", XS_Digest__SHA_sha1, file, ";@");
        XSANY.any_i32 = 13 ;
        cv = newXSproto_portable("Digest::SHA::sha1_base64", XS_Digest__SHA_sha1, file, ";@");
        XSANY.any_i32 = 2 ;
        cv = newXSproto_portable("Digest::SHA::sha512_base64", XS_Digest__SHA_sha1, file, ";@");
        XSANY.any_i32 = 14 ;
        cv = newXSproto_portable("Digest::SHA::sha224_hex", XS_Digest__SHA_sha1, file, ";@");
        XSANY.any_i32 = 4 ;
        cv = newXSproto_portable("Digest::SHA::sha224", XS_Digest__SHA_sha1, file, ";@");
        XSANY.any_i32 = 3 ;
        cv = newXSproto_portable("Digest::SHA::sha256_hex", XS_Digest__SHA_sha1, file, ";@");
        XSANY.any_i32 = 7 ;
        cv = newXSproto_portable("Digest::SHA::sha384", XS_Digest__SHA_sha1, file, ";@");
        XSANY.any_i32 = 9 ;
        cv = newXSproto_portable("Digest::SHA::sha384_hex", XS_Digest__SHA_sha1, file, ";@");
        XSANY.any_i32 = 10 ;
        cv = newXSproto_portable("Digest::SHA::sha224_base64", XS_Digest__SHA_sha1, file, ";@");
        XSANY.any_i32 = 5 ;
        cv = newXSproto_portable("Digest::SHA::sha256_base64", XS_Digest__SHA_sha1, file, ";@");
        XSANY.any_i32 = 8 ;
        cv = newXSproto_portable("Digest::SHA::sha1", XS_Digest__SHA_sha1, file, ";@");
        XSANY.any_i32 = 0 ;
        cv = newXSproto_portable("Digest::SHA::sha512", XS_Digest__SHA_sha1, file, ";@");
        XSANY.any_i32 = 12 ;
        cv = newXSproto_portable("Digest::SHA::sha1_hex", XS_Digest__SHA_sha1, file, ";@");
        XSANY.any_i32 = 1 ;
        cv = newXSproto_portable("Digest::SHA::sha256", XS_Digest__SHA_sha1, file, ";@");
        XSANY.any_i32 = 6 ;
        cv = newXSproto_portable("Digest::SHA::sha384_base64", XS_Digest__SHA_sha1, file, ";@");
        XSANY.any_i32 = 11 ;
        cv = newXSproto_portable("Digest::SHA::hmac_sha1_base64", XS_Digest__SHA_hmac_sha1, file, ";@");
        XSANY.any_i32 = 2 ;
        cv = newXSproto_portable("Digest::SHA::hmac_sha1", XS_Digest__SHA_hmac_sha1, file, ";@");
        XSANY.any_i32 = 0 ;
        cv = newXSproto_portable("Digest::SHA::hmac_sha512_base64", XS_Digest__SHA_hmac_sha1, file, ";@");
        XSANY.any_i32 = 14 ;
        cv = newXSproto_portable("Digest::SHA::hmac_sha256_hex", XS_Digest__SHA_hmac_sha1, file, ";@");
        XSANY.any_i32 = 7 ;
        cv = newXSproto_portable("Digest::SHA::hmac_sha512", XS_Digest__SHA_hmac_sha1, file, ";@");
        XSANY.any_i32 = 12 ;
        cv = newXSproto_portable("Digest::SHA::hmac_sha1_hex", XS_Digest__SHA_hmac_sha1, file, ";@");
        XSANY.any_i32 = 1 ;
        cv = newXSproto_portable("Digest::SHA::hmac_sha256", XS_Digest__SHA_hmac_sha1, file, ";@");
        XSANY.any_i32 = 6 ;
        cv = newXSproto_portable("Digest::SHA::hmac_sha224", XS_Digest__SHA_hmac_sha1, file, ";@");
        XSANY.any_i32 = 3 ;
        cv = newXSproto_portable("Digest::SHA::hmac_sha224_hex", XS_Digest__SHA_hmac_sha1, file, ";@");
        XSANY.any_i32 = 4 ;
        cv = newXSproto_portable("Digest::SHA::hmac_sha384", XS_Digest__SHA_hmac_sha1, file, ";@");
        XSANY.any_i32 = 9 ;
        cv = newXSproto_portable("Digest::SHA::hmac_sha256_base64", XS_Digest__SHA_hmac_sha1, file, ";@");
        XSANY.any_i32 = 8 ;
        cv = newXSproto_portable("Digest::SHA::hmac_sha384_base64", XS_Digest__SHA_hmac_sha1, file, ";@");
        XSANY.any_i32 = 11 ;
        cv = newXSproto_portable("Digest::SHA::hmac_sha384_hex", XS_Digest__SHA_hmac_sha1, file, ";@");
        XSANY.any_i32 = 10 ;
        cv = newXSproto_portable("Digest::SHA::hmac_sha224_base64", XS_Digest__SHA_hmac_sha1, file, ";@");
        XSANY.any_i32 = 5 ;
        cv = newXSproto_portable("Digest::SHA::hmac_sha512_hex", XS_Digest__SHA_hmac_sha1, file, ";@");
        XSANY.any_i32 = 13 ;
        cv = newXSproto_portable("Digest::SHA::algorithm", XS_Digest__SHA_hashsize, file, "$");
        XSANY.any_i32 = 1 ;
        cv = newXSproto_portable("Digest::SHA::hashsize", XS_Digest__SHA_hashsize, file, "$");
        XSANY.any_i32 = 0 ;
        (void)newXSproto_portable("Digest::SHA::add", XS_Digest__SHA_add, file, "$;@");
        cv = newXSproto_portable("Digest::SHA::digest", XS_Digest__SHA_digest, file, "$");
        XSANY.any_i32 = 0 ;
        cv = newXSproto_portable("Digest::SHA::Hexdigest", XS_Digest__SHA_digest, file, "$");
        XSANY.any_i32 = 1 ;
        cv = newXSproto_portable("Digest::SHA::B64digest", XS_Digest__SHA_digest, file, "$");
        XSANY.any_i32 = 2 ;
    }
#if (PERL_REVISION == 5 && PERL_VERSION >= 9)
  if (PL_unitcheckav)
       call_list(PL_scopestack_ix, PL_unitcheckav);
#endif
    XSRETURN_YES;
}

