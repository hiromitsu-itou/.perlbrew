/*
 * This file was generated automatically by ExtUtils::ParseXS version 2.21 from the
 * contents of ODBM_File.xs. Do not edit this file, edit ODBM_File.xs instead.
 *
 *	ANY CHANGES MADE HERE WILL BE LOST! 
 *
 */

#line 1 "ODBM_File.xs"
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#ifdef I_DBM
#  include <dbm.h>
#else
#  ifdef I_RPCSVC_DBM
#    include <rpcsvc/dbm.h>
#  endif
#endif

#ifndef HAS_DBMINIT_PROTO
int	dbminit(char* filename);
int	dbmclose(void);
datum	fetch(datum key);
int	store(datum key, datum dat);
int	delete(datum key); 
datum	firstkey(void);
datum	nextkey(datum key);
#endif

#ifdef DBM_BUG_DUPLICATE_FREE 
/*
 * DBM on at least Ultrix and HPUX call dbmclose() from dbminit(),
 * resulting in duplicate free() because dbmclose() does *not*
 * check if it has already been called for this DBM.
 * If some malloc/free calls have been done between dbmclose() and
 * the next dbminit(), the memory might be used for something else when
 * it is freed.
 * Verified to work on ultrix4.3.  Probably will work on HP/UX.
 * Set DBM_BUG_DUPLICATE_FREE in the extension hint file.
 */
/* Close the previous dbm, and fail to open a new dbm */
#define dbmclose()	((void) dbminit("/non/exist/ent"))
#endif

#include <fcntl.h>

typedef struct {
	void * 	dbp ;
	SV *    filter_fetch_key ;
	SV *    filter_store_key ;
	SV *    filter_fetch_value ;
	SV *    filter_store_value ;
	int     filtering ;
	} ODBM_File_type;

typedef ODBM_File_type * ODBM_File ;
typedef datum datum_key ;
typedef datum datum_key_copy ;
typedef datum datum_value ;

#define odbm_FETCH(db,key)			fetch(key)
#define odbm_STORE(db,key,value,flags)		store(key,value)
#define odbm_DELETE(db,key)			delete(key)
#define odbm_FIRSTKEY(db)			firstkey()
#define odbm_NEXTKEY(db,key)			nextkey(key)

#define MY_CXT_KEY "ODBM_File::_guts" XS_VERSION

typedef struct {
    int		x_dbmrefcnt;
} my_cxt_t;

START_MY_CXT

#define dbmrefcnt	(MY_CXT.x_dbmrefcnt)

#ifndef DBM_REPLACE
#define DBM_REPLACE 0
#endif

#line 84 "ODBM_File.c"
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

#line 136 "ODBM_File.c"

XS(XS_ODBM_File_TIEHASH); /* prototype to pass -Wmissing-prototypes */
XS(XS_ODBM_File_TIEHASH)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 4)
       croak_xs_usage(cv,  "dbtype, filename, flags, mode");
    {
	char *	dbtype = (char *)SvPV_nolen(ST(0));
	char *	filename = (char *)SvPV_nolen(ST(1));
	int	flags = (int)SvIV(ST(2));
	int	mode = (int)SvIV(ST(3));
	ODBM_File	RETVAL;
#line 88 "ODBM_File.xs"
	{
	    char *tmpbuf;
	    void * dbp ;
	    dMY_CXT;

	    if (dbmrefcnt++)
		croak("Old dbm can only open one database");
	    Newx(tmpbuf, strlen(filename) + 5, char);
	    SAVEFREEPV(tmpbuf);
	    sprintf(tmpbuf,"%s.dir",filename);
	    if (stat(tmpbuf, &PL_statbuf) < 0) {
		if (flags & O_CREAT) {
		    if (mode < 0 || close(creat(tmpbuf,mode)) < 0)
			croak("ODBM_File: Can't create %s", filename);
		    sprintf(tmpbuf,"%s.pag",filename);
		    if (close(creat(tmpbuf,mode)) < 0)
			croak("ODBM_File: Can't create %s", filename);
		}
		else
		    croak("ODBM_FILE: Can't open %s", filename);
	    }
	    dbp = (void*)(dbminit(filename) >= 0 ? &dbmrefcnt : 0);
	    RETVAL = (ODBM_File)safemalloc(sizeof(ODBM_File_type)) ;
    	    Zero(RETVAL, 1, ODBM_File_type) ;
	    RETVAL->dbp = dbp ;
	    ST(0) = sv_mortalcopy(&PL_sv_undef);
	    sv_setptrobj(ST(0), RETVAL, dbtype);
	}
#line 183 "ODBM_File.c"
    }
    XSRETURN(1);
}


XS(XS_ODBM_File_DESTROY); /* prototype to pass -Wmissing-prototypes */
XS(XS_ODBM_File_DESTROY)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       croak_xs_usage(cv,  "db");
    {
	ODBM_File	db;
#line 121 "ODBM_File.xs"
	dMY_CXT;
#line 203 "ODBM_File.c"

	if (SvROK(ST(0))) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    db = INT2PTR(ODBM_File,tmp);
	}
	else
	    Perl_croak(aTHX_ "%s: %s is not a reference",
			"ODBM_File::DESTROY",
			"db");
#line 123 "ODBM_File.xs"
	dbmrefcnt--;
	dbmclose();
	safefree(db);
#line 217 "ODBM_File.c"
    }
    XSRETURN_EMPTY;
}


XS(XS_ODBM_File_FETCH); /* prototype to pass -Wmissing-prototypes */
XS(XS_ODBM_File_FETCH)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 2)
       croak_xs_usage(cv,  "db, key");
    {
	ODBM_File	db;
	datum_key_copy	key;
	datum_value	RETVAL;

	if (SvROK(ST(0)) && sv_derived_from(ST(0), "ODBM_File")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    db = INT2PTR(ODBM_File,tmp);
	}
	else
	    Perl_croak(aTHX_ "%s: %s is not of type %s",
			"ODBM_File::FETCH",
			"db", "ODBM_File");

	{
	    SV * tmpSV ;
	    STRLEN len;
	    if (db->filter_store_key){
	        tmpSV = sv_2mortal(newSVsv(ST(1)));
	        DBM_ckFilter(tmpSV, filter_store_key, "filter_store_key");
	    }
	    else
		tmpSV = ST(1);
	    key.dptr = SvPVbyte(tmpSV, len);
	    key.dsize = (int)len;
	};

	RETVAL = odbm_FETCH(db, key);
	ST(0) = sv_newmortal();
	sv_setpvn(ST(0), RETVAL.dptr, RETVAL.dsize);
	DBM_ckFilter(ST(0), filter_fetch_value,"filter_fetch_value");
    }
    XSRETURN(1);
}


XS(XS_ODBM_File_STORE); /* prototype to pass -Wmissing-prototypes */
XS(XS_ODBM_File_STORE)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items < 3 || items > 4)
       croak_xs_usage(cv,  "db, key, value, flags = DBM_REPLACE");
    {
	ODBM_File	db;
	datum_key	key;
	datum_value	value;
	int	flags;
	int	RETVAL;
	dXSTARG;

	if (SvROK(ST(0)) && sv_derived_from(ST(0), "ODBM_File")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    db = INT2PTR(ODBM_File,tmp);
	}
	else
	    Perl_croak(aTHX_ "%s: %s is not of type %s",
			"ODBM_File::STORE",
			"db", "ODBM_File");

	{
	    STRLEN len;
	    DBM_ckFilter(ST(1), filter_store_key, "filter_store_key");
	    key.dptr = SvPVbyte(ST(1), len);
	    key.dsize = (int)len;
	};

        DBM_ckFilter(ST(2), filter_store_value, "filter_store_value");
	if (SvOK(ST(2))) {
	    STRLEN len;
	    value.dptr = SvPVbyte(ST(2), len);
	    value.dsize = (int)len;
	}
	else {
	    value.dptr = "";
	    value.dsize = 0;
	};

	if (items < 4)
	    flags = DBM_REPLACE;
	else {
	    flags = (int)SvIV(ST(3));
	}

	RETVAL = odbm_STORE(db, key, value, flags);
	XSprePUSH; PUSHi((IV)RETVAL);
#line 139 "ODBM_File.xs"
	if (RETVAL) {
	    if (RETVAL < 0 && errno == EPERM)
		croak("No write permission to odbm file");
	    croak("odbm store returned %d, errno %d, key \"%s\"",
			RETVAL,errno,key.dptr);
	}
#line 329 "ODBM_File.c"
    }
    XSRETURN(1);
}


XS(XS_ODBM_File_DELETE); /* prototype to pass -Wmissing-prototypes */
XS(XS_ODBM_File_DELETE)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 2)
       croak_xs_usage(cv,  "db, key");
    {
	ODBM_File	db;
	datum_key	key;
	int	RETVAL;
	dXSTARG;

	if (SvROK(ST(0)) && sv_derived_from(ST(0), "ODBM_File")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    db = INT2PTR(ODBM_File,tmp);
	}
	else
	    Perl_croak(aTHX_ "%s: %s is not of type %s",
			"ODBM_File::DELETE",
			"db", "ODBM_File");

	{
	    STRLEN len;
	    DBM_ckFilter(ST(1), filter_store_key, "filter_store_key");
	    key.dptr = SvPVbyte(ST(1), len);
	    key.dsize = (int)len;
	};

	RETVAL = odbm_DELETE(db, key);
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_ODBM_File_FIRSTKEY); /* prototype to pass -Wmissing-prototypes */
XS(XS_ODBM_File_FIRSTKEY)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       croak_xs_usage(cv,  "db");
    {
	ODBM_File	db;
	datum_key	RETVAL;

	if (SvROK(ST(0)) && sv_derived_from(ST(0), "ODBM_File")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    db = INT2PTR(ODBM_File,tmp);
	}
	else
	    Perl_croak(aTHX_ "%s: %s is not of type %s",
			"ODBM_File::FIRSTKEY",
			"db", "ODBM_File");

	RETVAL = odbm_FIRSTKEY(db);
	ST(0) = sv_newmortal();
	sv_setpvn(ST(0), RETVAL.dptr, RETVAL.dsize);
	DBM_ckFilter(ST(0), filter_fetch_key,"filter_fetch_key");
    }
    XSRETURN(1);
}


XS(XS_ODBM_File_NEXTKEY); /* prototype to pass -Wmissing-prototypes */
XS(XS_ODBM_File_NEXTKEY)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 2)
       croak_xs_usage(cv,  "db, key");
    {
	ODBM_File	db;
	datum_key	key;
	datum_key	RETVAL;

	if (SvROK(ST(0)) && sv_derived_from(ST(0), "ODBM_File")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    db = INT2PTR(ODBM_File,tmp);
	}
	else
	    Perl_croak(aTHX_ "%s: %s is not of type %s",
			"ODBM_File::NEXTKEY",
			"db", "ODBM_File");

	{
	    STRLEN len;
	    DBM_ckFilter(ST(1), filter_store_key, "filter_store_key");
	    key.dptr = SvPVbyte(ST(1), len);
	    key.dsize = (int)len;
	};

	RETVAL = odbm_NEXTKEY(db, key);
	ST(0) = sv_newmortal();
	sv_setpvn(ST(0), RETVAL.dptr, RETVAL.dsize);
	DBM_ckFilter(ST(0), filter_fetch_key,"filter_fetch_key");
    }
    XSRETURN(1);
}

#define setFilter(type)					\
	{						\
	    if (db->type)				\
	        RETVAL = sv_mortalcopy(db->type) ; 	\
	    ST(0) = RETVAL ;				\
	    if (db->type && (code == &PL_sv_undef)) {	\
                SvREFCNT_dec(db->type) ;		\
	        db->type = Nullsv ;			\
	    }						\
	    else if (code) {				\
	        if (db->type)				\
	            sv_setsv(db->type, code) ;		\
	        else					\
	            db->type = newSVsv(code) ;		\
	    }	    					\
	}

XS(XS_ODBM_File_filter_fetch_key); /* prototype to pass -Wmissing-prototypes */
XS(XS_ODBM_File_filter_fetch_key)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 2)
       croak_xs_usage(cv,  "db, code");
    {
	ODBM_File	db;
	SV *	code = ST(1);
	SV *	RETVAL = &PL_sv_undef ;

	if (SvROK(ST(0)) && sv_derived_from(ST(0), "ODBM_File")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    db = INT2PTR(ODBM_File,tmp);
	}
	else
	    Perl_croak(aTHX_ "%s: %s is not of type %s",
			"ODBM_File::filter_fetch_key",
			"db", "ODBM_File");
#line 186 "ODBM_File.xs"
	    DBM_setFilter(db->filter_fetch_key, code) ;
#line 487 "ODBM_File.c"
    }
    XSRETURN(1);
}


XS(XS_ODBM_File_filter_store_key); /* prototype to pass -Wmissing-prototypes */
XS(XS_ODBM_File_filter_store_key)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 2)
       croak_xs_usage(cv,  "db, code");
    {
	ODBM_File	db;
	SV *	code = ST(1);
	SV *	RETVAL =  &PL_sv_undef ;

	if (SvROK(ST(0)) && sv_derived_from(ST(0), "ODBM_File")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    db = INT2PTR(ODBM_File,tmp);
	}
	else
	    Perl_croak(aTHX_ "%s: %s is not of type %s",
			"ODBM_File::filter_store_key",
			"db", "ODBM_File");
#line 194 "ODBM_File.xs"
	    DBM_setFilter(db->filter_store_key, code) ;
#line 518 "ODBM_File.c"
    }
    XSRETURN(1);
}


XS(XS_ODBM_File_filter_fetch_value); /* prototype to pass -Wmissing-prototypes */
XS(XS_ODBM_File_filter_fetch_value)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 2)
       croak_xs_usage(cv,  "db, code");
    {
	ODBM_File	db;
	SV *	code = ST(1);
	SV *	RETVAL =  &PL_sv_undef ;

	if (SvROK(ST(0)) && sv_derived_from(ST(0), "ODBM_File")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    db = INT2PTR(ODBM_File,tmp);
	}
	else
	    Perl_croak(aTHX_ "%s: %s is not of type %s",
			"ODBM_File::filter_fetch_value",
			"db", "ODBM_File");
#line 202 "ODBM_File.xs"
	    DBM_setFilter(db->filter_fetch_value, code) ;
#line 549 "ODBM_File.c"
    }
    XSRETURN(1);
}


XS(XS_ODBM_File_filter_store_value); /* prototype to pass -Wmissing-prototypes */
XS(XS_ODBM_File_filter_store_value)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 2)
       croak_xs_usage(cv,  "db, code");
    {
	ODBM_File	db;
	SV *	code = ST(1);
	SV *	RETVAL =  &PL_sv_undef ;

	if (SvROK(ST(0)) && sv_derived_from(ST(0), "ODBM_File")) {
	    IV tmp = SvIV((SV*)SvRV(ST(0)));
	    db = INT2PTR(ODBM_File,tmp);
	}
	else
	    Perl_croak(aTHX_ "%s: %s is not of type %s",
			"ODBM_File::filter_store_value",
			"db", "ODBM_File");
#line 210 "ODBM_File.xs"
	    DBM_setFilter(db->filter_store_value, code) ;
#line 580 "ODBM_File.c"
    }
    XSRETURN(1);
}

#ifdef __cplusplus
extern "C"
#endif
XS(boot_ODBM_File); /* prototype to pass -Wmissing-prototypes */
XS(boot_ODBM_File)
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

        (void)newXS("ODBM_File::TIEHASH", XS_ODBM_File_TIEHASH, file);
        (void)newXS("ODBM_File::DESTROY", XS_ODBM_File_DESTROY, file);
        (void)newXS("ODBM_File::FETCH", XS_ODBM_File_FETCH, file);
        (void)newXS("ODBM_File::STORE", XS_ODBM_File_STORE, file);
        (void)newXS("ODBM_File::DELETE", XS_ODBM_File_DELETE, file);
        (void)newXS("ODBM_File::FIRSTKEY", XS_ODBM_File_FIRSTKEY, file);
        (void)newXS("ODBM_File::NEXTKEY", XS_ODBM_File_NEXTKEY, file);
        (void)newXS("ODBM_File::filter_fetch_key", XS_ODBM_File_filter_fetch_key, file);
        (void)newXS("ODBM_File::filter_store_key", XS_ODBM_File_filter_store_key, file);
        (void)newXS("ODBM_File::filter_fetch_value", XS_ODBM_File_filter_fetch_value, file);
        (void)newXS("ODBM_File::filter_store_value", XS_ODBM_File_filter_store_value, file);

    /* Initialisation Section */

#line 77 "ODBM_File.xs"
{
    MY_CXT_INIT;
}

#line 625 "ODBM_File.c"

    /* End of Initialisation Section */

#if (PERL_REVISION == 5 && PERL_VERSION >= 9)
  if (PL_unitcheckav)
       call_list(PL_scopestack_ix, PL_unitcheckav);
#endif
    XSRETURN_YES;
}

