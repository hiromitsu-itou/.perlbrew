/*
 * This file was generated automatically by ExtUtils::ParseXS version 2.19 from the
 * contents of Syslog.xs. Do not edit this file, edit Syslog.xs instead.
 *
 *	ANY CHANGES MADE HERE WILL BE LOST! 
 *
 */

#line 1 "Syslog.xs"
#if defined(_WIN32)
#  include <windows.h>
#endif

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#ifdef USE_PPPORT_H
#  include "ppport.h"
#endif

#ifndef HAVE_SYSLOG
#define HAVE_SYSLOG 1
#endif

#if defined(_WIN32) && !defined(__CYGWIN__)
#  undef HAVE_SYSLOG
#  include "fallback/syslog.h"
#else
#  if defined(I_SYSLOG) || PATCHLEVEL < 6
#    include <syslog.h>
#  endif
#endif

static SV *ident_svptr;

#include "const-c.inc"

#ifndef PERL_UNUSED_VAR
#  define PERL_UNUSED_VAR(var) if (0) var = var
#endif

#line 43 "Syslog.c"

/* INCLUDE:  Including 'const-xs.inc' from 'Syslog.xs' */


XS(XS_Sys__Syslog_constant); /* prototype to pass -Wmissing-prototypes */
XS(XS_Sys__Syslog_constant)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Sys::Syslog::constant", "sv");
    PERL_UNUSED_VAR(cv); /* -W */
    PERL_UNUSED_VAR(ax); /* -Wall */
    SP -= items;
    {
#line 4 "const-xs.inc"
#ifdef dXSTARG
	dXSTARG; /* Faster if we have it.  */
#else
	dTARGET;
#endif
	STRLEN		len;
        int		type;
	IV		iv;
	/* NV		nv;	Uncomment this if you need to return NVs */
	const char	*pv;
#line 73 "Syslog.c"
	SV *	sv = ST(0);
	const char *	s = SvPV(sv, len);
#line 18 "const-xs.inc"
        /* Change this to constant(aTHX_ s, len, &iv, &nv);
           if you need to return both NVs and IVs */
	type = constant(aTHX_ s, len, &iv, &pv);
      /* Return 1 or 2 items. First is error message, or undef if no error.
           Second, if present, is found value */
        switch (type) {
        case PERL_constant_NOTFOUND:
          sv =
	    sv_2mortal(newSVpvf("%s is not a valid Sys::Syslog macro", s));
          PUSHs(sv);
          break;
        case PERL_constant_NOTDEF:
          sv = sv_2mortal(newSVpvf(
	    "Your vendor has not defined Sys::Syslog macro %s, used",
				   s));
          PUSHs(sv);
          break;
        case PERL_constant_ISIV:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHi(iv);
          break;
	/* Uncomment this if you need to return NOs
        case PERL_constant_ISNO:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHs(&PL_sv_no);
          break; */
	/* Uncomment this if you need to return NVs
        case PERL_constant_ISNV:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHn(nv);
          break; */
        case PERL_constant_ISPV:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHp(pv, strlen(pv));
          break;
	/* Uncomment this if you need to return PVNs
        case PERL_constant_ISPVN:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHp(pv, iv);
          break; */
	/* Uncomment this if you need to return SVs
        case PERL_constant_ISSV:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHs(sv);
          break; */
	/* Uncomment this if you need to return UNDEFs
        case PERL_constant_ISUNDEF:
          break; */
	/* Uncomment this if you need to return UVs
        case PERL_constant_ISUV:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHu((UV)iv);
          break; */
	/* Uncomment this if you need to return YESs
        case PERL_constant_ISYES:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHs(&PL_sv_yes);
          break; */
        default:
          sv = sv_2mortal(newSVpvf(
	    "Unexpected return type %d while processing Sys::Syslog macro %s, used",
               type, s));
          PUSHs(sv);
        }
#line 149 "Syslog.c"
	PUTBACK;
	return;
    }
}


/* INCLUDE: Returning to 'Syslog.xs' from 'const-xs.inc' */


XS(XS_Sys__Syslog_LOG_FAC); /* prototype to pass -Wmissing-prototypes */
XS(XS_Sys__Syslog_LOG_FAC)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Sys::Syslog::LOG_FAC", "p");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	p = (int)SvIV(ST(0));
	int	RETVAL;
	dXSTARG;
#line 38 "Syslog.xs"
#ifdef LOG_FAC
	RETVAL = LOG_FAC(p);
#else
	croak("Your vendor has not defined the Sys::Syslog macro LOG_FAC");
	RETVAL = -1;
#endif
#line 181 "Syslog.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Sys__Syslog_LOG_PRI); /* prototype to pass -Wmissing-prototypes */
XS(XS_Sys__Syslog_LOG_PRI)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Sys::Syslog::LOG_PRI", "p");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	p = (int)SvIV(ST(0));
	int	RETVAL;
	dXSTARG;
#line 52 "Syslog.xs"
#ifdef LOG_PRI
	RETVAL = LOG_PRI(p);
#else
	croak("Your vendor has not defined the Sys::Syslog macro LOG_PRI");
	RETVAL = -1;
#endif
#line 210 "Syslog.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Sys__Syslog_LOG_MAKEPRI); /* prototype to pass -Wmissing-prototypes */
XS(XS_Sys__Syslog_LOG_MAKEPRI)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 2)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Sys::Syslog::LOG_MAKEPRI", "fac, pri");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	fac = (int)SvIV(ST(0));
	int	pri = (int)SvIV(ST(1));
	int	RETVAL;
	dXSTARG;
#line 67 "Syslog.xs"
#ifdef LOG_MAKEPRI
	RETVAL = LOG_MAKEPRI(fac,pri);
#else
	croak("Your vendor has not defined the Sys::Syslog macro LOG_MAKEPRI");
	RETVAL = -1;
#endif
#line 240 "Syslog.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Sys__Syslog_LOG_MASK); /* prototype to pass -Wmissing-prototypes */
XS(XS_Sys__Syslog_LOG_MASK)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Sys::Syslog::LOG_MASK", "pri");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	pri = (int)SvIV(ST(0));
	int	RETVAL;
	dXSTARG;
#line 81 "Syslog.xs"
#ifdef LOG_MASK
	RETVAL = LOG_MASK(pri);
#else
	croak("Your vendor has not defined the Sys::Syslog macro LOG_MASK");
	RETVAL = -1;
#endif
#line 269 "Syslog.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Sys__Syslog_LOG_UPTO); /* prototype to pass -Wmissing-prototypes */
XS(XS_Sys__Syslog_LOG_UPTO)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Sys::Syslog::LOG_UPTO", "pri");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	pri = (int)SvIV(ST(0));
	int	RETVAL;
	dXSTARG;
#line 95 "Syslog.xs"
#ifdef LOG_UPTO
	RETVAL = LOG_UPTO(pri);
#else
	croak("Your vendor has not defined the Sys::Syslog macro LOG_UPTO");
	RETVAL = -1;
#endif
#line 298 "Syslog.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}

#ifdef HAVE_SYSLOG
#define XSubPPtmpAAAA 1


XS(XS_Sys__Syslog_openlog_xs); /* prototype to pass -Wmissing-prototypes */
XS(XS_Sys__Syslog_openlog_xs)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 3)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Sys::Syslog::openlog_xs", "ident, option, facility");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	SV*	ident = ST(0);
	int	option = (int)SvIV(ST(1));
	int	facility = (int)SvIV(ST(2));
#line 113 "Syslog.xs"
        STRLEN len;
        char*  ident_pv;
#line 326 "Syslog.c"
#line 116 "Syslog.xs"
        ident_svptr = newSVsv(ident);
        ident_pv    = SvPV(ident_svptr, len);
        openlog(ident_pv, option, facility);
#line 331 "Syslog.c"
    }
    XSRETURN_EMPTY;
}


XS(XS_Sys__Syslog_syslog_xs); /* prototype to pass -Wmissing-prototypes */
XS(XS_Sys__Syslog_syslog_xs)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 2)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Sys::Syslog::syslog_xs", "priority, message");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	priority = (int)SvIV(ST(0));
	const char *	message = (const char *)SvPV_nolen(ST(1));
#line 126 "Syslog.xs"
        syslog(priority, "%s", message);
#line 353 "Syslog.c"
    }
    XSRETURN_EMPTY;
}


XS(XS_Sys__Syslog_setlogmask_xs); /* prototype to pass -Wmissing-prototypes */
XS(XS_Sys__Syslog_setlogmask_xs)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Sys::Syslog::setlogmask_xs", "mask");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	mask = (int)SvIV(ST(0));
	int	RETVAL;
	dXSTARG;
#line 133 "Syslog.xs"
        RETVAL = setlogmask(mask);
#line 376 "Syslog.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS(XS_Sys__Syslog_closelog_xs); /* prototype to pass -Wmissing-prototypes */
XS(XS_Sys__Syslog_closelog_xs)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 0)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Sys::Syslog::closelog_xs", "");
    PERL_UNUSED_VAR(cv); /* -W */
    {
#line 140 "Syslog.xs"
        closelog();
        if (SvREFCNT(ident_svptr))
            SvREFCNT_dec(ident_svptr);
#line 399 "Syslog.c"
    }
    XSRETURN_EMPTY;
}

#else  /* HAVE_SYSLOG */
#define XSubPPtmpAAAB 1


XS(XS_Sys__Syslog_openlog_xs); /* prototype to pass -Wmissing-prototypes */
XS(XS_Sys__Syslog_openlog_xs)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 3)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Sys::Syslog::openlog_xs", "ident, option, facility");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	SV*	ident = ST(0);
	int	option = (int)SvIV(ST(1));
	int	facility = (int)SvIV(ST(2));
#line 152 "Syslog.xs"
#line 424 "Syslog.c"
    }
    XSRETURN_EMPTY;
}


XS(XS_Sys__Syslog_syslog_xs); /* prototype to pass -Wmissing-prototypes */
XS(XS_Sys__Syslog_syslog_xs)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 2)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Sys::Syslog::syslog_xs", "priority, message");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	priority = (int)SvIV(ST(0));
	const char *	message = (const char *)SvPV_nolen(ST(1));
#line 159 "Syslog.xs"
#line 445 "Syslog.c"
    }
    XSRETURN_EMPTY;
}


XS(XS_Sys__Syslog_setlogmask_xs); /* prototype to pass -Wmissing-prototypes */
XS(XS_Sys__Syslog_setlogmask_xs)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 1)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Sys::Syslog::setlogmask_xs", "mask");
    PERL_UNUSED_VAR(cv); /* -W */
    {
	int	mask = (int)SvIV(ST(0));
	int	RETVAL;
	dXSTARG;
#line 165 "Syslog.xs"
#line 467 "Syslog.c"
    }
    XSRETURN(1);
}


XS(XS_Sys__Syslog_closelog_xs); /* prototype to pass -Wmissing-prototypes */
XS(XS_Sys__Syslog_closelog_xs)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif
    if (items != 0)
       Perl_croak(aTHX_ "Usage: %s(%s)", "Sys::Syslog::closelog_xs", "");
    PERL_UNUSED_VAR(cv); /* -W */
    {
#line 169 "Syslog.xs"
#line 486 "Syslog.c"
    }
    XSRETURN_EMPTY;
}

#endif /* HAVE_SYSLOG */
#ifdef __cplusplus
extern "C"
#endif
XS(boot_Sys__Syslog); /* prototype to pass -Wmissing-prototypes */
XS(boot_Sys__Syslog)
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

        newXS("Sys::Syslog::constant", XS_Sys__Syslog_constant, file);
        newXS("Sys::Syslog::LOG_FAC", XS_Sys__Syslog_LOG_FAC, file);
        newXS("Sys::Syslog::LOG_PRI", XS_Sys__Syslog_LOG_PRI, file);
        newXS("Sys::Syslog::LOG_MAKEPRI", XS_Sys__Syslog_LOG_MAKEPRI, file);
        newXS("Sys::Syslog::LOG_MASK", XS_Sys__Syslog_LOG_MASK, file);
        newXS("Sys::Syslog::LOG_UPTO", XS_Sys__Syslog_LOG_UPTO, file);
#if XSubPPtmpAAAA
        newXS("Sys::Syslog::openlog_xs", XS_Sys__Syslog_openlog_xs, file);
        newXS("Sys::Syslog::syslog_xs", XS_Sys__Syslog_syslog_xs, file);
        newXS("Sys::Syslog::setlogmask_xs", XS_Sys__Syslog_setlogmask_xs, file);
        newXS("Sys::Syslog::closelog_xs", XS_Sys__Syslog_closelog_xs, file);
#endif
#if XSubPPtmpAAAB
        newXS("Sys::Syslog::openlog_xs", XS_Sys__Syslog_openlog_xs, file);
        newXS("Sys::Syslog::syslog_xs", XS_Sys__Syslog_syslog_xs, file);
        newXS("Sys::Syslog::setlogmask_xs", XS_Sys__Syslog_setlogmask_xs, file);
        newXS("Sys::Syslog::closelog_xs", XS_Sys__Syslog_closelog_xs, file);
#endif

    /* Initialisation Section */

#if XSubPPtmpAAAA
#endif
#if XSubPPtmpAAAB
#endif
#line 534 "Syslog.c"

    /* End of Initialisation Section */

    XSRETURN_YES;
}

