/*
 * This file was generated automatically by ExtUtils::ParseXS version 2.21 from the
 * contents of KR.xs. Do not edit this file, edit KR.xs instead.
 *
 *	ANY CHANGES MADE HERE WILL BE LOST! 
 *
 */

#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>
#define U8 U8
#include "encode.h"
#include "ma_04_t.h"
#include "ks_03_t.h"
#include "jo_02_t.h"
#include "eu_01_t.h"
#include "cp_00_t.h"

static void
Encode_XSEncoding(pTHX_ encode_t *enc)
{
 dSP;
 HV *stash = gv_stashpv("Encode::XS", TRUE);
 SV *sv    = sv_bless(newRV_noinc(newSViv(PTR2IV(enc))),stash);
 int i = 0;
 PUSHMARK(sp);
 XPUSHs(sv);
 while (enc->name[i])
  {
   const char *name = enc->name[i++];
   XPUSHs(sv_2mortal(newSVpvn(name,strlen(name))));
  }
 PUTBACK;
 call_pv("Encode::define_encoding",G_DISCARD);
 SvREFCNT_dec(sv);
}

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

#ifdef __cplusplus
extern "C"
#endif
XS(boot_Encode__KR); /* prototype to pass -Wmissing-prototypes */
XS(boot_Encode__KR)
{
#ifdef dVAR
    dVAR; dXSARGS;
#else
    dXSARGS;
#endif

    PERL_UNUSED_VAR(cv); /* -W */
    PERL_UNUSED_VAR(items); /* -W */
    XS_VERSION_BOOTCHECK ;


    /* Initialisation Section */

{
#include "ma_04_t.exh"
#include "ks_03_t.exh"
#include "jo_02_t.exh"
#include "eu_01_t.exh"
#include "cp_00_t.exh"
}


    /* End of Initialisation Section */

#if (PERL_REVISION == 5 && PERL_VERSION >= 9)
  if (PL_unitcheckav)
       call_list(PL_scopestack_ix, PL_unitcheckav);
#endif
    XSRETURN_YES;
}

