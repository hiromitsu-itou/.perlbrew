# Makefile.SH
# This file is derived from Makefile.SH.  Any changes made here will
# be lost the next time you run Configure.
#  Makefile is used to generate makefile.  The only difference
#  is that makefile has the dependencies filled in at the end.
#
#
# I now supply perly.c with the kits, so don't remake perly.c without byacc
BYACC = byacc
CC = cc
LD = cc

LDFLAGS =  -L/usr/local/lib
CLDFLAGS =  -L/usr/local/lib

mallocsrc = 
mallocobj = 
LNS = /bin/ln -s
# NOTE: some systems don't grok "cp -f". XXX Configure test needed?
CPS = cp
RMS = rm -f
ranlib = :

# The following are mentioned only to make metaconfig include the
# appropriate questions in Configure.  If you want to change these,
# edit config.sh instead, or specify --man1dir=/wherever on
# installman commandline.
bin = /home/ito/.perlbrew/perl5/perls/perl-5.8.9/bin
scriptdir = /home/ito/.perlbrew/perl5/perls/perl-5.8.9/bin
shrpdir = /home/ito/.perlbrew/perl5/perls/perl-5.8.9/lib/5.8.9/x86_64-linux/CORE
privlib = /home/ito/.perlbrew/perl5/perls/perl-5.8.9/lib/5.8.9
man1dir = /home/ito/.perlbrew/perl5/perls/perl-5.8.9/man/man1
man1ext = 1
man3dir = /home/ito/.perlbrew/perl5/perls/perl-5.8.9/man/man3
man3ext = 3

# The following are used to build and install shared libraries for
# dynamic loading.
LDDLFLAGS = -shared -O2 -L/usr/local/lib
SHRPLDFLAGS = $(LDDLFLAGS)
CCDLFLAGS = -Wl,-E
DLSUFFIX = .so
PLDLFLAGS = 
LIBPERL = libperl.a
LLIBPERL= $(LIBPERL)
LLIBPERL_NONSHR= 
SHRPENV = 

# Static targets are ordinarily built without CCCDLFLAGS.  However,
# if building a shared libperl.so that might later be linked into
# another application, then it might be appropriate to also build static
# extensions (usually just DynaLoader) with relocatable code (e.g. -fPIC
# for GNU cc).  This is handled by ext/util/make_ext.
STATIC = static

# The following is used to include the current directory in
# the dynamic loader path you are building a shared libperl.
LDLIBPTH = 

# Sometimes running an executable is an adventure.
RUN = 

dynamic_ext =   lib/auto/B/B.so lib/auto/ByteLoader/ByteLoader.so lib/auto/Cwd/Cwd.so lib/auto/DB_File/DB_File.so lib/auto/Data/Dumper/Dumper.so lib/auto/Devel/DProf/DProf.so lib/auto/Devel/PPPort/PPPort.so lib/auto/Devel/Peek/Peek.so lib/auto/Digest/MD5/MD5.so lib/auto/Encode/Encode.so lib/auto/Fcntl/Fcntl.so lib/auto/File/Glob/Glob.so lib/auto/Filter/Util/Call/Call.so lib/auto/GDBM_File/GDBM_File.so lib/auto/Hash/Util/Util.so lib/auto/I18N/Langinfo/Langinfo.so lib/auto/IO/IO.so lib/auto/IPC/SysV/SysV.so lib/auto/List/Util/Util.so lib/auto/MIME/Base64/Base64.so lib/auto/Opcode/Opcode.so lib/auto/POSIX/POSIX.so lib/auto/PerlIO/encoding/encoding.so lib/auto/PerlIO/scalar/scalar.so lib/auto/PerlIO/via/via.so lib/auto/SDBM_File/SDBM_File.so lib/auto/Socket/Socket.so lib/auto/Storable/Storable.so lib/auto/Sys/Hostname/Hostname.so lib/auto/Sys/Syslog/Syslog.so lib/auto/Text/Soundex/Soundex.so lib/auto/Time/HiRes/HiRes.so lib/auto/Unicode/Normalize/Normalize.so lib/auto/XS/APItest/APItest.so lib/auto/XS/Typemap/Typemap.so lib/auto/attrs/attrs.so lib/auto/re/re.so lib/auto/threads/threads.so lib/auto/threads/shared/shared.so
static_ext =  
nonxs_ext =   ext/Errno/pm_to_blib ext/Module/Pluggable/pm_to_blib
ext = $(dynamic_ext) $(static_ext) $(nonxs_ext)
DYNALOADER = DynaLoader$(OBJ_EXT)

libs = -lnsl -ldl -lm -lcrypt -lutil -lc 

public = perl$(EXE_EXT)  utilities translators

shellflags = 

# This is set to  MAKE=make if your make command doesn't
# do it for you.
#

# Mention gmake here so it gets probed for by Configure.

# These variables may need to be manually set for non-Unix systems.
AR = /usr/bin/ar
EXE_EXT = 
LIB_EXT = .a
OBJ_EXT = .o
PATH_SEP = :

# If you're going to use valgrind and it can't be invoked as plain valgrind
# then you'll need to change this, or override it on the make command line.
VALGRIND=valgrind

FIRSTMAKEFILE = makefile

# Any special object files needed by this architecture, e.g. os2/os2.obj
ARCHOBJS = 

.SUFFIXES: .c $(OBJ_EXT) .i .s

# grrr
SHELL = /bin/sh

# how to tr(anslate) newlines
TRNL = '\n'

OPTIMIZE = -O2

EXTRAS = 

INSTALLPREFIXEXP = /home/ito/.perlbrew/perl5/perls/perl-5.8.9


CCCMD    = `sh $(shellflags) cflags "optimize='$(OPTIMIZE)'" $@`

CCCMDSRC = `sh $(shellflags) cflags "optimize='$(OPTIMIZE)'" $<`

CONFIGPM = lib/Config.pm lib/Config_heavy.pl
private = preplibrary $(CONFIGPM) lib/Config.pod lib/ExtUtils/Miniperl.pm

# Files to be built with variable substitution before miniperl
# is available.
sh = Makefile.SH cflags.SH config_h.SH makeaperl.SH makedepend.SH \
	makedir.SH myconfig.SH writemain.SH pod/Makefile.SH

shextract = Makefile cflags config.h makeaperl makedepend \
	makedir myconfig writemain pod/Makefile

# Files to be built with variable substitution after miniperl is
# available.  Dependencies handled manually below (for now).

pl = pod/pod2html.PL pod/pod2latex.PL pod/pod2man.PL pod/pod2text.PL \
	pod/pod2usage.PL pod/podchecker.PL pod/podselect.PL

# lib/lib.pm is not listed here because it has a rule of its own.
plextract = pod/pod2html pod/pod2latex pod/pod2man pod/pod2text \
	pod/pod2usage pod/podchecker pod/podselect

addedbyconf = UU $(shextract) $(plextract) lib/lib.pm pstruct

# Unicode data files generated by mktables
unidatafiles = lib/unicore/Canonical.pl lib/unicore/Exact.pl \
	lib/unicore/Properties lib/unicore/Decomposition.pl \
	lib/unicore/CombiningClass.pl lib/unicore/Name.pl lib/unicore/PVA.pl

# Directories of Unicode data files generated by mktables
unidatadirs = lib/unicore/To lib/unicore/lib

h1 = EXTERN.h INTERN.h XSUB.h av.h config.h cop.h cv.h dosish.h
h2 = embed.h form.h gv.h handy.h hv.h keywords.h mg.h op.h opcode.h
h3 = pad.h patchlevel.h perl.h perlapi.h perly.h pp.h proto.h regcomp.h
h4 = regexp.h scope.h sv.h unixish.h util.h iperlsys.h thread.h
h5 = utf8.h warnings.h
h = $(h1) $(h2) $(h3) $(h4) $(h5)

c1 = $(mallocsrc) av.c scope.c op.c doop.c doio.c dump.c hv.c mg.c reentr.c
c2 = perl.c perly.c pp.c pp_hot.c pp_ctl.c pp_sys.c regcomp.c regexec.c utf8.c
c3 = gv.c sv.c taint.c toke.c util.c deb.c run.c universal.c xsutils.c pad.c
c4 = globals.c perlio.c perlapi.c numeric.c mathoms.c locale.c pp_pack.c pp_sort.c

c = $(c1) $(c2) $(c3) $(c4) miniperlmain.c perlmain.c opmini.c

obj1 = $(mallocobj) gv$(OBJ_EXT) toke$(OBJ_EXT) perly$(OBJ_EXT) op$(OBJ_EXT) pad$(OBJ_EXT) regcomp$(OBJ_EXT) dump$(OBJ_EXT) util$(OBJ_EXT) mg$(OBJ_EXT) reentr$(OBJ_EXT)
obj2 = hv$(OBJ_EXT) av$(OBJ_EXT) perl$(OBJ_EXT) run$(OBJ_EXT) pp_hot$(OBJ_EXT) sv$(OBJ_EXT) pp$(OBJ_EXT) scope$(OBJ_EXT) pp_ctl$(OBJ_EXT) pp_sys$(OBJ_EXT)
obj3 = doop$(OBJ_EXT) doio$(OBJ_EXT) regexec$(OBJ_EXT) utf8$(OBJ_EXT) taint$(OBJ_EXT) deb$(OBJ_EXT) universal$(OBJ_EXT) xsutils$(OBJ_EXT) globals$(OBJ_EXT) perlio$(OBJ_EXT) perlapi$(OBJ_EXT) numeric$(OBJ_EXT) mathoms$(OBJ_EXT) locale$(OBJ_EXT) pp_pack$(OBJ_EXT) pp_sort$(OBJ_EXT)

obj = $(obj1) $(obj2) $(obj3) $(ARCHOBJS)

lintflags = \
    -b \
    -n \
    -p \
    -Ncheck=%all \
    -Nlevel=4 \
    -errchk=parentheses \
    -errhdr=%all \
    -errfmt=src \
    -errtags \
    -erroff=E_ASSIGN_NARROW_CONV \
    -erroff=E_BAD_PTR_CAST \
    -erroff=E_BAD_PTR_CAST_ALIGN \
    -erroff=E_BAD_PTR_INT_COMBINATION \
    -erroff=E_BAD_SIGN_EXTEND \
    -erroff=E_BLOCK_DECL_UNUSED \
    -erroff=E_CASE_FALLTHRU \
    -erroff=E_CONST_EXPR \
    -erroff=E_CONSTANT_CONDITION \
    -erroff=E_END_OF_LOOP_CODE_NOT_REACHED \
    -erroff=E_EQUALITY_NOT_ASSIGNMENT \
    -erroff=E_EXPR_NULL_EFFECT \
    -erroff=E_FALSE_LOGICAL_EXPR \
    -erroff=E_INCL_NUSD \
    -erroff=E_LOOP_EMPTY \
    -erroff=E_MAIN_PARAM \
    -erroff=E_POINTER_TO_OBJECT \
    -erroff=E_PTRDIFF_OVERFLOW \
    -erroff=E_SHIFT_CNT_NEG_TOO_BIG_L \
    -erroff=E_STATIC_UNUSED \
    -erroff=E_TRUE_LOGICAL_EXPR

splintflags = \
    -I/usr/lib/gcc/i486-linux-gnu/4.0.2/include/ \
    -D__builtin_va_list=va_list \
    -Dsigjmp_buf=jmp_buf \
    -warnposix \
    \
    +boolint \
    +charintliteral \
    -fixedformalarray \
    -mustfreefresh \
    -nestedextern \
    -predboolint \
    -predboolothers \
    -preproc \
    -boolops \
    -shadow \
    -nullstate \
    +longintegral \
    +matchanyintegral \
    -type \
    \
    +line-len 999 \
    +weak

splintfiles = $(c1)

.c$(OBJ_EXT):
	$(CCCMD) $(PLDLFLAGS) $*.c

.c.i:
	$(CCCMDSRC) -E $*.c > $*.i

.c.s:
	$(CCCMDSRC) -S $*.c

all: $(FIRSTMAKEFILE) miniperl$(EXE_EXT) extra.pods $(private) $(unidatafiles) $(public) $(dynamic_ext) $(nonxs_ext) extras.make
	@echo " ";
	@echo "	Everything is up to date. Type '$(MAKE) test' to run test suite."

sperl$(OBJ_EXT): perl.c $(h)
	$(RMS) sperl.c
	$(LNS) perl.c sperl.c
	$(CCCMD) -DIAMSUID sperl.c
	$(RMS) sperl.c

sperl.i: perl.c $(h)
	$(CCCMDSRC) -DIAMSUID -E perl.c > sperl.i

.PHONY: all compile translators utilities

compile: all
	echo "testing compilation" > testcompile;
	cd utils;  $(MAKE) compile;
	cd x2p; $(MAKE) compile;
	cd pod; $(MAKE) compile;

translators:	miniperl$(EXE_EXT) $(CONFIGPM) FORCE
	@echo " "; echo "	Making x2p stuff"; cd x2p; $(LDLIBPTH) $(MAKE) all

utilities:	miniperl$(EXE_EXT) $(CONFIGPM) $(plextract) lib/lib.pm FORCE
	@echo " "; echo "	Making utilities"; cd utils; $(LDLIBPTH) $(MAKE) all


# This is now done by installman only if you actually want the man pages.
#	@echo " "; echo "	Making docs"; cd pod; $(MAKE) all;

# Phony target to force checking subdirectories.
# Apparently some makes require an action for the FORCE target.
.PHONY: FORCE
FORCE:
	@sh -c true

# We do a copy of the op.c instead of a symlink because gcc gets huffy
# if we have a symlink forest to another disk (it complains about too many
# levels of symbolic links, even if we have only two)

opmini.c: op.c
	$(RMS) opmini.c
	$(CPS) op.c opmini.c

opmini$(OBJ_EXT): opmini.c
	$(CCCMD) $(PLDLFLAGS) -DPERL_EXTERNAL_GLOB opmini.c

miniperlmain$(OBJ_EXT): miniperlmain.c patchlevel.h
	$(CCCMD) $(PLDLFLAGS) $*.c

perlmain.c: miniperlmain.c config.sh $(FIRSTMAKEFILE)
	sh writemain $(DYNALOADER) $(static_ext) > perlmain.c

perlmain$(OBJ_EXT): perlmain.c
	$(CCCMD) $(PLDLFLAGS) $*.c

# The file ext.libs is a list of libraries that must be linked in
# for static extensions, e.g. -lm -lgdbm, etc.  The individual
# static extension Makefile's add to it.
ext.libs: $(static_ext)
	-@test -f ext.libs || touch ext.libs

$(LIBPERL): $& $(obj) $(DYNALOADER) $(LIBPERLEXPORT)
	rm -f $(LIBPERL)
	$(AR) rcu $(LIBPERL) $(obj) $(DYNALOADER)
	@$(ranlib) $(LIBPERL)

# How to build executables.

# The $& notation tells Sequent machines that it can do a parallel make,
# and is harmless otherwise.
# The miniperl -w -MExporter line is a basic cheap test to catch errors
# before make goes on to run preplibrary and then MakeMaker on extensions.
# This is very handy because later errors are often caused by miniperl
# build problems but that's not obvious to the novice.
# The Module used here must not depend on Config or any extensions.

miniperl$(EXE_EXT): $& miniperlmain$(OBJ_EXT) $(obj) opmini$(OBJ_EXT)
	-@rm -f miniperl.xok
	$(LDLIBPTH) $(CC) $(CLDFLAGS) -o miniperl \
	    `echo $(obj) | sed 's/ op$(OBJ_EXT) / /'` \
	    miniperlmain$(OBJ_EXT) opmini$(OBJ_EXT) $(libs)
	$(LDLIBPTH) $(RUN) ./miniperl -w -Ilib -MExporter -e '<?>' || $(MAKE) minitest

perl$(EXE_EXT): $& perlmain$(OBJ_EXT) $(LIBPERL) $(static_ext) ext.libs $(PERLEXPORT)
	-@rm -f miniperl.xok
	$(SHRPENV) $(LDLIBPTH) $(CC) -o perl$(PERL_SUFFIX) $(PERL_PROFILE_LDFLAGS) $(CLDFLAGS) $(CCDLFLAGS) perlmain$(OBJ_EXT) $(static_ext) $(LLIBPERL) `cat ext.libs` $(libs)

# Purify/Quantify Perls.

pureperl$(EXE_EXT): $& perlmain$(OBJ_EXT) $(LIBPERL) $(static_ext) ext.libs $(PERLEXPORT)
	$(SHRPENV) $(LDLIBPTH) purify $(CC) -o pureperl $(CLDFLAGS) $(CCDLFLAGS) perlmain$(OBJ_EXT) $(static_ext) $(LLIBPERL) `cat ext.libs` $(libs)

purecovperl$(EXE_EXT): $& perlmain$(OBJ_EXT) $(LIBPERL) $(static_ext) ext.libs $(PERLEXPORT)
	$(SHRPENV) $(LDLIBPTH) purecov $(CC) -o purecovperl $(CLDFLAGS) $(CCDLFLAGS) perlmain$(OBJ_EXT) $(static_ext) $(LLIBPERL) `cat ext.libs` $(libs)

quantperl$(EXE_EXT): $& perlmain$(OBJ_EXT) $(LIBPERL) $(static_ext) ext.libs $(PERLEXPORT)
	$(SHRPENV) $(LDLIBPTH) quantify $(CC) -o quantperl $(CLDFLAGS) $(CCDLFLAGS) perlmain$(OBJ_EXT) $(static_ext) $(LLIBPERL) `cat ext.libs` $(libs)

# Valgrind perl (currently Linux only)

perl.valgrind.config: config.sh
	@echo "To build perl.valgrind you must Configure -Doptimize=-g -Uusemymalloc, checking..."
	@$(MAKE) perl.config.dashg
	@echo "Checking usemymalloc='n' in config.sh..."
	@grep "^usemymalloc="    config.sh
	@grep "^usemymalloc='n'" config.sh >/dev/null || exit 1
	@echo "And of course you have to have valgrind..."
	$(VALGRIND) ./perl -e 1 2>/dev/null || exit 1

# Third Degree Perl (Tru64 only)

perl.config.dashg:
	@echo "Checking optimize='-g' in config.sh..."
	@grep "^optimize=" config.sh
	@egrep "^optimize='(.*-g.*)'" config.sh >/dev/null || exit 1

perl.third.config: config.sh
	@echo "To build perl.third you must Configure -Doptimize=-g -Uusemymalloc, checking..."
	@$(MAKE) perl.config.dashg
	@echo "Checking usemymalloc='n' in config.sh..."
	@grep "^usemymalloc="    config.sh
	@grep "^usemymalloc='n'" config.sh >/dev/null || exit 1

perl.third: /usr/bin/atom perl.third.config perl
	atom -tool third -L. -all -gp -toolargs="-invalid -uninit heap+stack+copy -min 0" perl
	@echo "Now you may run perl.third and then study perl.3log."

# Pixie Perls (Tru64 and IRIX only)

perl.pixie.config: config.sh
	@echo "To build perl.pixie you must Configure -Doptimize=-g, checking..."
	@$(MAKE) perl.config.dashg

perl.pixie.atom: /usr/bin/atom perl
	atom -tool pixie -L. -all -toolargs="-quiet" perl

perl.pixie.irix: perl
	pixie perl

perl.pixie: /usr/bin/pixie perl.pixie.config perl
	if test -x /usr/bin/atom; then \
	  $(MAKE) perl.pixie.atom; \
	else \
	  $(MAKE) perl.pixie.irix; \
	fi
	@echo "Now you may run perl.pixie and then run pixie."

# Gprof Perl

perl.config.dashpg:
	@echo "Checking optimize='-pg' in config.sh..."
	@grep "^optimize="      config.sh
	@grep "^optimize='.*-pg.*'" config.sh >/dev/null || exit 1

perl.gprof.config: config.sh
	@echo "To build perl.gprof you must Configure -Doptimize=-pg, checking..."
	@$(MAKE) perl.config.dashpg

perl.gprof: /usr/bin/gprof perl.gprof.config
	@-rm -f perl
	$(MAKE) PERL_SUFFIX=.gprof PERL_PROFILE_LDFLAGS=-pg perl
	@echo "Now you may run perl.gprof and then run gprof perl.gprof."

# Gcov Perl

perl.config.gcov:
	@echo "To build perl.gcov you must use gcc 3.0 or newer, checking..."
	@echo "Checking gccversion in config.sh..."
	@grep "^gccversion="      config.sh
	@grep "^gccversion='[3-9]\." config.sh >/dev/null || exit 1
	@echo "To build perl.gcov you must Configure -Dccflags=-fprofile-arcs -ftest-coverage, checking..."
	@echo "Checking ccflags='-fprofile-arcs -ftest-coverage' in config.sh..."
	@grep "^ccflags="      config.sh
	@grep "^ccflags='.*-fprofile-arcs -ftest-coverage.*'" config.sh >/dev/null || exit 1

perl.gcov: perl.config.gcov
	@-rm -f perl
	$(MAKE) PERL_SUFFIX=.gcov PERL_PROFILE_LDFLAGS='' perl
	@echo "Now you may run perl.gcov and then run gcov some.c."

# Microperl.  This is just a convenience thing if one happens to
# build also the full Perl and therefore the real big Makefile:
# usually one should manually explicitly issue the below command.

.PHONY: microperl
microperl:
	$(MAKE) -f Makefile.micro

# This version, if specified in Configure, does ONLY those scripts which need
# set-id emulation.  Suidperl must be setuid root.  It contains the "taint"
# checks as well as the special code to validate that the script in question
# has been invoked correctly.

suidperl$(EXE_EXT): $& sperl$(OBJ_EXT) perlmain$(OBJ_EXT) $(LIBPERL) $(static_ext) ext.libs $(PERLEXPORT)
	$(SHRPENV) $(LDLIBPTH) $(CC) -o suidperl $(CLDFLAGS) $(CCDLFLAGS) perlmain$(OBJ_EXT) sperl$(OBJ_EXT) $(static_ext) $(LLIBPERL) `cat ext.libs` $(libs)

.PHONY: makeppport
makeppport: miniperl$(EXE_EXT) $(CONFIGPM)
	$(LDLIBPTH) $(RUN) ./miniperl$(EXE_EXT) -Ilib mkppport


# We have to call our ./makedir because Ultrix 4.3 make can't handle the line
#	test -d lib/auto || mkdir lib/auto
# We need to autosplit in two steps because VOS can't handle so many args
#
.PHONY: preplibrary
preplibrary: miniperl$(EXE_EXT) $(CONFIGPM) lib/lib.pm $(PREPLIBRARY_LIBPERL)
	@sh ./makedir lib/auto
	@echo "	AutoSplitting perl library"
	$(LDLIBPTH) $(RUN) ./miniperl -Ilib -e 'use AutoSplit; \
		autosplit_lib_modules(@ARGV)' lib/*.pm
	$(LDLIBPTH) $(RUN) ./miniperl -Ilib -e 'use AutoSplit; \
		autosplit_lib_modules(@ARGV)' lib/*/*.pm
	$(MAKE) lib/re.pm

lib/Config.pod: config.sh miniperl$(EXE_EXT) configpm Porting/Glossary
	$(LDLIBPTH) $(RUN) ./miniperl -Ilib configpm

$(CONFIGPM): lib/Config.pod

lib/ExtUtils/Miniperl.pm: miniperlmain.c miniperl$(EXE_EXT) minimod.pl $(CONFIGPM)
	$(LDLIBPTH) $(RUN) ./miniperl minimod.pl > lib/ExtUtils/Miniperl.pm

lib/re.pm: ext/re/re.pm
	@-rm -f $@
	cp ext/re/re.pm lib/re.pm

$(plextract):	miniperl$(EXE_EXT) $(CONFIGPM) x2p/s2p
	@-rm -f $@
	$(LDLIBPTH) $(RUN) ./miniperl -I`pwd`/lib $@.PL

x2p/s2p: miniperl$(EXE_EXT) $(CONFIGPM) x2p/s2p.PL
	cd x2p; $(LDLIBPTH) $(MAKE) s2p

lib/lib.pm:	miniperl$(EXE_EXT) $(CONFIGPM)
	@-rm -f $@
	$(LDLIBPTH) $(RUN) ./miniperl -Ilib lib/lib_pm.PL

unidatafiles $(unidatafiles): uni.data

uni.data: miniperl$(EXE_EXT) $(CONFIGPM) lib/unicore/mktables
	cd lib/unicore && $(LDLIBPTH) $(RUN) ../../miniperl -I../../lib mktables -w
	touch uni.data

extra.pods: miniperl$(EXE_EXT)
	-@test ! -f extra.pods || rm -f `cat extra.pods`
	-@rm -f extra.pods
	-@for x in `grep -l '^=[a-z]' README.* | grep -v README.vms` ; do \
	    nx=`echo $$x | sed -e "s/README\.//"`; \
	    cd pod ; $(LNS) ../$$x "perl"$$nx".pod" ; cd .. ; \
	    echo "pod/perl"$$nx".pod" >> extra.pods ; \
	done
	-@rm -f pod/perlvms.pod
	-@test -f vms/perlvms.pod && cd pod && $(LNS) ../vms/perlvms.pod perlvms.pod && cd .. && echo "pod/perlvms.pod" >> extra.pods
	-@rm -f pod/perldelta.pod
	-@test -f pod/perl589delta.pod && cd pod && $(LNS) perl589delta.pod perldelta.pod && cd .. && echo "pod/perldelta.pod" >> extra.pods # See buildtoc

extras.make: perl$(EXE_EXT)
	-@test ! -s extras.lst || PATH="`pwd`:${PATH}" PERL5LIB="`pwd`/lib" $(LDLIBPTH) $(RUN) ./perl -Ilib -MCPAN -e '@ARGV&&make(@ARGV)' `cat extras.lst`

extras.test: perl$(EXE_EXT)
	-@test ! -s extras.lst || PATH="`pwd`:${PATH}" PERL5LIB="`pwd`/lib" $(LDLIBPTH) $(RUN) ./perl -Ilib -MCPAN -e '@ARGV&&test(@ARGV)' `cat extras.lst`

extras.install: perl$(EXE_EXT)
	-@test ! -s extras.lst || PATH="`pwd`:${PATH}" PERL5LIB="`pwd`/lib" $(LDLIBPTH) $(RUN) ./perl -Ilib -MCPAN -e '@ARGV&&install(@ARGV)' `cat extras.lst`

.PHONY: install install-strip install-all install-verbose install-silent \
	no-install install.perl install.man install.html

META.yml:	Porting/makemeta Porting/Maintainers.pl Porting/Maintainers.pm
	$(LDLIBPTH) $(RUN) ./miniperl -Ilib Porting/makemeta

install-strip:
	$(MAKE) STRIPFLAGS=-s install DESTDIR="$(DESTDIR)"

install install-all:
	$(MAKE) install.perl install.man STRIPFLAGS=$(STRIPFLAGS) DESTDIR="$(DESTDIR)"

install-verbose:
	$(MAKE) install.perl install.man STRIPFLAGS=$(STRIPFLAGS) INSTALLFLAGS=-V DESTDIR="$(DESTDIR)"

install-silent:
	$(MAKE) install.perl install.man STRIPFLAGS=$(STRIPFLAGS) INSTALLFLAGS=-S DESTDIR="$(DESTDIR)"

no-install:
	$(MAKE) install.perl install.man STRIPFLAGS=$(STRIPFLAGS) INSTALLFLAGS=-n DESTDIR="$(DESTDIR)"

# Set this to an empty string to avoid an attempt of rebuild before install
INSTALL_DEPENDENCE = all

install.perl:	$(INSTALL_DEPENDENCE) installperl
	if [ -n "$(COMPILE)" ]; \
	then \
		cd utils; $(MAKE) compile; \
		cd ../x2p; $(MAKE) compile; \
		cd ../pod; $(MAKE) compile; \
	else :; \
	fi
	$(LDLIBPTH) $(RUN) ./perl installperl --destdir=$(DESTDIR) $(INSTALLFLAGS) $(STRIPFLAGS)
	-@test ! -s extras.lst || $(MAKE) extras.install

install.man:	all installman
	$(LDLIBPTH) $(RUN) ./perl installman --destdir=$(DESTDIR) $(INSTALLFLAGS)

# XXX Experimental. Hardwired values, but useful for testing.
# Eventually Configure could ask for some of these values.
install.html: all installhtml
	-@test -f README.vms && cd vms && $(LNS) ../README.vms README_vms.pod && cd ..
	$(LDLIBPTH) $(RUN) ./perl installhtml   \
      --podroot=. --podpath=. --recurse  \
      --htmldir=$(privlib)/html   \
      --htmlroot=$(privlib)/html  \
      --splithead=pod/perlipc     \
      --splititem=pod/perlfunc    \
      --libpods=perlfunc:perlguts:perlvar:perlrun:perlop \
      --ignore=Porting/Maintainers.pm,Porting/patching.pod,Porting/pumpkin.pod,Porting/repository.pod \
      --verbose


# I now supply perly.c with the kits, so the following section is
# used only if you force byacc to run by saying
# 	make run_byacc
# Since we patch up the byacc output, the perly.fixer script needs
# to run with precisely the same version of byacc as I use.  You
# normally shouldn't remake perly.[ch].

.PHONY: check_byacc run_byacc

check_byacc:
	@$(BYACC) -V 2>&1 | grep 'version 1\.8\.2'

run_byacc:	FORCE check_byacc
	$(BYACC) -d perly.y
	-chmod 664 perly.c perly.h
	sh $(shellflags) ./perly.fixer y.tab.c perly.c
	sed -e 's/fprintf *( *stderr *,/PerlIO_printf(Perl_debug_log,/g' \
	    -e 's/y\.tab/perly/g' perly.c >perly.tmp && mv perly.tmp perly.c
	sed -e '/^extern YYSTYPE yy/D' y.tab.h >yh.tmp && mv yh.tmp y.tab.h
	cmp -s y.tab.h perly.h && rm -f y.tab.h || mv y.tab.h perly.h
	perl -i.old perlyline.pl perly.c
	chmod 664 vms/perly_c.vms vms/perly_h.vms
	perl vms/vms_yfix.pl perly.c perly.h vms/perly_c.vms vms/perly_h.vms

# We don't want to regenerate perly.c and perly.h, but they might
# appear out-of-date after a patch is applied or a new distribution is
# made.
perly.c: perly.y
	-@sh -c true

perly.h: perly.y
	-@sh -c true

PERLYVMS = vms/perly_c.vms vms/perly_h.vms

$(PERLYVMS):	perly.c perly.h vms/vms_yfix.pl
	perl vms/vms_yfix.pl perly.c perly.h vms/perly_c.vms vms/perly_h.vms

# No compat3.sym here since and including the 5.004_50.
# No interp.sym since 5.005_03.
SYM  = global.sym globvar.sym perlio.sym pp.sym

SYMH = perlvars.h intrpvar.h thrdvar.h

CHMOD_W = chmod +w

# The following files are generated automatically
#	autodoc.pl:	pod/perlapi.pod pod/perlintern.pod
#	bytecode.pl:	ext/ByteLoader/byterun.h ext/ByteLoader/byterun.c
#			ext/B/B/Asmdata.pm
#	embed.pl:	proto.h embed.h embedvar.h global.sym
#			perlapi.h perlapi.c 
# [* embed.pl needs pp.sym generated by opcode.pl! *]
#	keywords.pl:	keywords.h
#	opcode.pl:	opcode.h opnames.h pp_proto.h pp.sym
#	regcomp.pl:	regnodes.h
#	warnings.pl:	warnings.h lib/warnings.pm
# The correct versions should be already supplied with the perl kit,
# in case you don't have perl available.
# To force them to be regenerated, run
#       perl regen.pl
# with your existing copy of perl
# (make regen_headers is kept for backwards compatibility)

AUTOGEN_FILES = keywords.h opcode.h opnames.h pp_proto.h pp.sym proto.h \
		embed.h embedvar.h global.sym \
		pod/perlintern.pod pod/perlapi.pod \
		perlapi.h perlapi.c ext/ByteLoader/byterun.h \
		ext/ByteLoader/byterun.c ext/B/B/Asmdata.pm regnodes.h \
		warnings.h lib/warnings.pm

.PHONY: regen_headers regen_pods regen_all

regen regen_headers:	FORCE
	-perl regen.pl

regen_pods:	FORCE
	-cd pod; $(LDLIBPTH) $(MAKE) regen_pods

regen_all: $(PERLYVMS) regen regen_pods

.PHONY:	manisort manicheck

manisort:	FORCE
	LC_ALL=C sort -fdc MANIFEST || (echo "WARNING: re-sorting MANIFEST"; \
		LC_ALL=C sort -fdo MANIFEST MANIFEST)

manicheck:	FORCE
	perl Porting/manicheck

# Extensions:
# Names added to $(dynamic_ext) or $(static_ext) or $(nonxs_ext) will
# automatically get built.  There should ordinarily be no need to change
# any of this part of makefile.
#
# The dummy dependency is a place holder in case $(dynamic_ext) or
# $(static_ext) is empty.
#
# DynaLoader may be needed for extensions that use Makefile.PL.

$(DYNALOADER):	miniperl$(EXE_EXT) preplibrary FORCE
	@$(LDLIBPTH) sh ext/util/make_ext $(STATIC) $@ MAKE=$(MAKE) LIBPERL_A=$(LIBPERL)

d_dummy $(dynamic_ext):	miniperl$(EXE_EXT) preplibrary makeppport $(DYNALOADER) FORCE
	@$(LDLIBPTH) sh ext/util/make_ext dynamic $@ MAKE=$(MAKE) LIBPERL_A=$(LIBPERL)

s_dummy $(static_ext):	miniperl$(EXE_EXT) preplibrary makeppport $(DYNALOADER) FORCE
	@$(LDLIBPTH) sh ext/util/make_ext $(STATIC) $@ MAKE=$(MAKE) LIBPERL_A=$(LIBPERL)

n_dummy $(nonxs_ext):	miniperl$(EXE_EXT) preplibrary FORCE
	@$(LDLIBPTH) sh ext/util/make_ext nonxs $@ MAKE=$(MAKE) LIBPERL_A=$(LIBPERL)

lib/auto/Unicode/Normalize/Normalize.so: uni.data

.PHONY: printconfig
printconfig:
	@eval `$(LDLIBPTH) $(RUN) ./perl -Ilib -V:$(CONFIGVAR)`; echo $$$(CONFIGVAR)

.PHONY: clean _tidy _mopup _cleaner1 _cleaner2 \
	realclean _realcleaner clobber _clobber \
	distclean veryclean _verycleaner \
	cleanup_unpacked_files unpack_files

clean:		cleanup_unpacked_files _tidy _mopup 

realclean:	cleanup_unpacked_files _realcleaner _mopup
	@echo "Note that '$(MAKE) realclean' does not delete config.sh or Policy.sh"

_clobber:
	-@rm -f Cross/run-* Cross/to-* Cross/from-*
	rm -f config.sh cppstdin Policy.sh extras.lst

clobber:	cleanup_unpacked_files _realcleaner _mopup _clobber

distclean:	clobber

# Like distclean but also removes emacs backups and *.orig.
veryclean:	cleanup_unpacked_files _verycleaner _mopup _clobber
	-@rm -f Obsolete Wanted

# Do not 'make _mopup' directly.
_mopup:
	rm -f *$(OBJ_EXT) *$(LIB_EXT) all perlmain.c opmini.c
	-rmdir .depending
	-@test -f extra.pods && rm -f `cat extra.pods`
	-@test -f vms/README_vms.pod && rm -f vms/README_vms.pod
	-rm -f perl.exp ext.libs extra.pods uni.data opmini.o
	-rm -f perl.export perl.dll perl.libexp perl.map perl.def
	-rm -f perl.loadmap miniperl.loadmap perl.prelmap miniperl.prelmap
	-rm -f perl.third lib*.so.perl.third perl.3log t/perl.third t/perl.3log
	-rm -f perl.pixie lib*.so.perl.pixie lib*.so.Addrs
	-rm -f perl.Addrs perl.Counts t/perl.Addrs t/perl.Counts *perl.xok
	-rm -f cygwin.c libperl*.def libperl*.dll cygperl*.dll *.exe.stackdump
	-rm -f perl$(EXE_EXT) suidperl$(EXE_EXT) miniperl$(EXE_EXT) $(LIBPERL) libperl.* microperl
	-rm -f opcode.h-old opnames.h-old pp.sym-old pp_proto.h-old
	-rm -f config.arch config.over

# Do not 'make _tidy' directly.
_tidy:
	-cd pod; $(LDLIBPTH) $(MAKE) clean
	-cd utils; $(LDLIBPTH) $(MAKE) clean
	-cd x2p; $(LDLIBPTH) $(MAKE) clean
	-@for x in $(DYNALOADER) $(dynamic_ext) $(static_ext) $(nonxs_ext) ; do \
	$(LDLIBPTH) sh ext/util/make_ext clean $$x MAKE=$(MAKE) ; \
	done
	rm -f testcompile compilelog

_cleaner1:
	-cd os2; rm -f Makefile
	-cd pod; $(LDLIBPTH) $(MAKE) $(CLEAN)
	-cd utils; $(LDLIBPTH) $(MAKE) $(CLEAN)
	-cd x2p; $(LDLIBPTH) $(MAKE) $(CLEAN)
	-@for x in $(DYNALOADER) $(dynamic_ext) $(static_ext) $(nonxs_ext) ; do \
	$(LDLIBPTH) sh ext/util/make_ext $(CLEAN) $$x MAKE=$(MAKE) ; \
	done
	-@test ! -f $(RUN) ./miniperl$(EXE_EXT) || $(LDLIBPTH) $(RUN) ./miniperl$(EXE_EXT) -Ilib mkppport --clean

# Some systems do not support "?", so keep these files separate.
_cleaner2:
	-rm -f core.*perl.*.? t/core.perl.*.? .?*.c
	rm -f core *perl.core t/core t/*perl.core core.* t/core.*
	rm -f t/misctmp* t/forktmp* t/tmp* t/c t/perl$(EXE_EXT) t/rantests
	rm -f so_locations $(LIBPERL_NONSHR) $(MINIPERL_NONSHR)
	rm -rf $(addedbyconf)
	rm -f $(FIRSTMAKEFILE) $(FIRSTMAKEFILE).old makefile.old
	rm -f $(private)
	rm -rf $(unidatafiles) $(unidatadirs)
	rm -rf lib/auto
	rm -f lib/.exists lib/*/.exists lib/*/*/.exists
	rm -f h2ph.man pstruct
	rm -rf .config
	rm -f preload lib/re.pm
	rm -f testcompile compilelog
	rm -rf lib/Encode lib/Hash lib/re
	rm -rf lib/Module/Pluggable
	rm -f lib/ExtUtils/ParseXS/t/XSTest.c
	rm -f lib/ExtUtils/ParseXS/t/XSTest$(OBJ_EXT)
	rm -f lib/ExtUtils/ParseXS/t/XSTest$(DLSUFFIX)
	rm -fr lib/B
	-rmdir lib/Data
	-rmdir lib/Filter/Util lib/IO/Socket lib/IO
	-rmdir lib/List lib/MIME lib/Scalar lib/Sys
	-rmdir lib/threads lib/XS
	-rm -f cygcrypt-0.dll cygwin1.dll
	-rm -f lib/ExtUtils/ParseXS/t/libXSTest.dll.a

_realcleaner:
	@$(LDLIBPTH) $(MAKE) _cleaner1 CLEAN=realclean
	@$(LDLIBPTH) $(MAKE) _cleaner2

_verycleaner:
	@$(LDLIBPTH) $(MAKE) _cleaner1 CLEAN=veryclean
	@$(LDLIBPTH) $(MAKE) _cleaner2
	-rm -f *~ *.orig */*~ */*.orig */*/*~ */*/*.orig

.PHONY: lint
lint: $(c)
	rm -f *.ln
	lint $(lintflags) -DPERL_CORE -D_REENTRANT -DDEBUGGING -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 $(c)

.PHONY: splint
splint: $(c)
	splint $(splintflags) -DPERL_CORE -D_REENTRANT -DDEBUGGING -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 $(splintfiles)

# Need to unset during recursion to go out of loop.
# The README below ensures that the dependency list is never empty and
# that when MAKEDEPEND is empty $(FIRSTMAKEFILE) doesn't need rebuilding.

MAKEDEPEND = Makefile makedepend

$(FIRSTMAKEFILE):	README $(MAKEDEPEND)
	$(MAKE) depend MAKEDEPEND=

config.h: config_h.SH config.sh
	$(SHELL) config_h.SH

# When done, touch perlmain.c so that it doesn't get remade each time.
.PHONY: depend
depend: makedepend
	sh ./makedepend MAKE=$(MAKE)
	- test -s perlmain.c && touch perlmain.c
	cd x2p; $(MAKE) depend

# Cannot postpone this until $firstmakefile is ready ;-)
makedepend: makedepend.SH config.sh
	sh ./makedepend.SH

.PHONY: test check test_prep test_prep_nodll test_prep_pre _test_prep \
	test_tty test-tty _test_tty test_notty test-notty _test_notty \
	utest ucheck test.utf8 check.utf8 test.torture torturetest \
	test.utf16 check.utf16 utest.utf16 ucheck.utf16 \
	test.third check.third utest.third ucheck.third test_notty.third \
	test.deparse test_notty.deparse test_harness test_harness_notty \
	test.bytecompile minitest coretest test.taintwarn test-reonly

# Cannot delegate rebuilding of t/perl to make
# to allow interlaced test and minitest

TESTFILE=TEST

_test_prep: unpack_files
	cd t && (rm -f $(PERL)$(EXE_EXT); $(LNS) ../$(PERL)$(EXE_EXT) $(PERL)$(EXE_EXT))

# Architecture-neutral stuff:

test_prep_pre: preplibrary utilities $(nonxs_ext)

test_prep: test_prep_pre miniperl$(EXE_EXT) $(unidatafiles) perl$(EXE_EXT) $(dynamic_ext) $(TEST_PERL_DLL)
	PERL=./perl $(MAKE) _test_prep

_test_tty:
	cd t && $(PERL_DEBUG) $(LDLIBPTH) $(PERL) $(TESTFILE) $(TEST_ARGS) $(TEST_FILES) </dev/tty

_test_notty:
	cd t && $(PERL_DEBUG) PERL_SKIP_TTY_TEST=1 $(LDLIBPTH) $(PERL) $(TESTFILE) $(TEST_ARGS) $(TEST_FILES)

unpack_files:
	$(LDLIBPTH) $(RUN) ./miniperl$(EXE_EXT) -Ilib uupacktool.pl -u -m

cleanup_unpacked_files:
	-@test ! -f $(RUN) ./miniperl$(EXE_EXT) || $(LDLIBPTH) $(RUN) ./miniperl$(EXE_EXT) -Ilib uupacktool.pl -c

# The second branch is for testing without a tty or controlling terminal,
# see t/op/stat.t
_test:
	if (true </dev/tty) >/dev/null 2>&1; then \
	  $(MAKE) TEST_ARGS='$(TEST_ARGS)' TESTFILE=$(TESTFILE) _test_tty   ; \
	else \
	  $(MAKE) TEST_ARGS='$(TEST_ARGS)' TESTFILE=$(TESTFILE) _test_notty ; \
	fi
	@echo "Ran tests" > t/rantests

test check: test_prep
	PERL=./perl $(MAKE) _test

test_tty: test_prep
	PERL=./perl $(MAKE) _test_tty

test_notty: test_prep
	PERL=./perl $(MAKE) _test_notty

utest ucheck test.utf8 check.utf8: test_prep
	PERL=./perl TEST_ARGS=-utf8 $(MAKE) _test

coretest: test_prep
	PERL=./perl TEST_ARGS=-core $(MAKE) _test

test-prep:	test_prep

test-tty:	test_tty

test-notty:	test_notty

# Torture testing

test.torture torturetest:	test_prep
	PERL=./perl TEST_ARGS=-torture $(MAKE) _test

# Targets for UTF16 testing:

minitest.utf16: minitest.prep
	- cd t && (rm -f perl$(EXE_EXT); $(LNS) ../miniperl$(EXE_EXT) perl$(EXE_EXT)) \
		&& $(LDLIBPTH) $(RUN) ./perl TEST -minitest -utf16 base/*.t comp/*.t cmd/*.t run/*.t io/*.t op/*.t uni/*.t </dev/tty

test.utf16 check.utf16: test_prep
	PERL=./perl $(MAKE) TEST_ARGS=-utf16 _test

utest.utf16 ucheck.utf16: test_prep
	PERL=./perl $(MAKE) TEST_ARGS="-utf8 -utf16" _test

# Targets for valgrind testing:

test_prep.valgrind: test_prep perl.valgrind
	PERL=./perl $(MAKE) _test_prep

test.valgrind check.valgrind:	test_prep perl.valgrind.config
	PERL=./perl PERL_DEBUG=PERL_VALGRIND=1 VALGRIND='$(VALGRIND)' $(MAKE) _test

utest.valgrind ucheck.valgrind: test_prep.valgrind perl.valgrind.config
	PERL=./perl PERL_DEBUG=PERL_VALGRIND=1 TEST_ARGS=-utf8 $(MAKE) _test

test_notty.valgrind: test_prep.valgrind perl.valgrind.config
	PERL=./perl $(MAKE) PERL_DEBUG=PERL_VALGRIND=1 _test_notty

# Targets for Third Degree testing.

test_prep.third: test_prep perl.third
	PERL=./perl.third $(MAKE) _test_prep

test.third check.third:	test_prep.third perl.third
	PERL=./perl.third PERL_DEBUG=PERL_3LOG=1 $(MAKE) _test

utest.third ucheck.third: test_prep.third perl.third
	PERL=./perl.third PERL_DEBUG=PERL_3LOG=1 TEST_ARGS=-utf8 $(MAKE) _test

test_notty.third: test_prep.third perl.third
	PERL=./perl.third $(MAKE) PERL_DEBUG=PERL_3LOG=1 _test_notty

# Targets for Bytecode/ByteLoader testing.

test.bytecompile:	test_prep
	PERL=./perl TEST_ARGS=-bytecompile $(MAKE) _test

# Targets for Deparse testing.

test.deparse:	test_prep
	PERL=./perl TEST_ARGS=-deparse $(MAKE) _test

test_notty.deparse:	test_prep
	PERL=./perl TEST_ARGS=-deparse $(MAKE) _test_notty

# Targets to run the test suite with -t

test.taintwarn:	test_prep
	PERL=./perl TEST_ARGS=-taintwarn $(MAKE) _test

minitest.prep:
	-@test -f lib/lib.pm && test -f lib/Config.pm || \
	  $(MAKE) lib/Config.pm lib/lib.pm $(unidatafiles)
	@echo " "
	@echo "You may see some irrelevant test failures if you have been unable"
	@echo "to build lib/Config.pm, lib/lib.pm or the Unicode data files."
	@echo " "

# Can't depend on lib/Config.pm because that might be where miniperl
# is crashing.
minitest: miniperl$(EXE_EXT) lib/re.pm minitest.prep
	- cd t && (rm -f perl$(EXE_EXT); $(LNS) ../miniperl$(EXE_EXT) perl$(EXE_EXT)) \
		&& $(LDLIBPTH) $(RUN) ./perl TEST -minitest base/*.t comp/*.t cmd/*.t run/*.t io/*.t op/*.t uni/*.t </dev/tty

# Test via harness

test_harness: test_prep
	PERL=./perl $(MAKE) TESTFILE=harness _test

test_harness_notty: test_prep
	PERL=./perl HARNESS_NOTTY=1 $(MAKE) TESTFILE=harness _test

test-reonly: test_prep
	PERL=./perl TEST_ARGS='-re \\bpat\\b \\breg \\bre\b \\bsubst \\brxcode' $(MAKE) TESTFILE=harness _test

# Handy way to run perlbug -ok without having to install and run the
# installed perlbug. We don't re-run the tests here - we trust the user.
# Please *don't* use this unless all tests pass.
# If you want to report test failures, use "make nok" instead.

.PHONY: ok okfile oknack okfilenack nok nokfile noknack nokfilenack

ok:	utilities
	$(LDLIBPTH) $(RUN) ./perl -Ilib utils/perlbug -ok -s '(UNINSTALLED)'

okfile:	utilities
	$(LDLIBPTH) $(RUN) ./perl -Ilib utils/perlbug -ok -s '(UNINSTALLED)' -F perl.ok

oknack:	utilities
	$(LDLIBPTH) $(RUN) ./perl -Ilib utils/perlbug -ok -s '(UNINSTALLED)' -A

okfilenack:	utilities
	$(LDLIBPTH) $(RUN) ./perl -Ilib utils/perlbug -ok -s '(UNINSTALLED)' -F perl.ok -A

nok:	utilities
	$(LDLIBPTH) $(RUN) ./perl -Ilib utils/perlbug -nok -s '(UNINSTALLED)'

nokfile:	utilities
	$(LDLIBPTH) $(RUN) ./perl -Ilib utils/perlbug -nok -s '(UNINSTALLED)' -F perl.nok

noknack:	utilities
	$(LDLIBPTH) $(RUN) ./perl -Ilib utils/perlbug -nok -s '(UNINSTALLED)' -A

nokfilenack:	utilities
	$(LDLIBPTH) $(RUN) ./perl -Ilib utils/perlbug -nok -s '(UNINSTALLED)' -F perl.nok -A

.PHONY: clist hlist shlist pllist

clist:	$(c)
	echo $(c) | tr ' ' $(TRNL) >.clist

hlist:  $(h)
	echo $(h) | tr ' ' $(TRNL) >.hlist

shlist: $(sh)
	echo $(sh) | tr ' ' $(TRNL) >.shlist

pllist: $(pl)
	echo $(pl) | tr ' ' $(TRNL) >.pllist

Makefile: Makefile.SH ./config.sh
	$(SHELL) Makefile.SH

.PHONY: distcheck
distcheck: FORCE
	perl '-MExtUtils::Manifest=&fullcheck' -e 'fullcheck()'

.PHONY: elc
elc:	emacs/cperl-mode.elc

emacs/cperl-mode.elc: emacs/cperl-mode.el
	-cd emacs; emacs -batch -q -no-site-file -f batch-byte-compile cperl-mode.el

.PHONY: etags ctags tags

etags:	TAGS

TAGS: emacs/cperl-mode.elc
	sh emacs/ptags

# Let's hope make will not go into an infinite loop on case-unsensitive systems
# This may also fail if . is in the head of the path, since perl will
# require -Ilib
tags:	TAGS
	perl emacs/e2ctags.pl TAGS > tags

ctags:
	ctags -f Tags -N --totals --languages=c --langmap=c:+.h --exclude=opmini.c *.c *.h

# AUTOMATICALLY GENERATED MAKE DEPENDENCIES--PUT NOTHING BELOW THIS LINE
# If this runs make out of memory, delete /usr/include lines.
