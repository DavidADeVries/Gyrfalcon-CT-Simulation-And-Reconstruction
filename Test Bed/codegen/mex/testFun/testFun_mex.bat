@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2017a
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2017a\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=testFun_mex
set MEX_NAME=testFun_mex
set MEX_EXT=.mexw64
call "C:\PROGRA~1\MATLAB\R2017a\sys\lcc64\lcc64\mex\lcc64opts.bat"
echo # Make settings for testFun > testFun_mex.mki
echo COMPILER=%COMPILER%>> testFun_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> testFun_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> testFun_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> testFun_mex.mki
echo LINKER=%LINKER%>> testFun_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> testFun_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> testFun_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> testFun_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> testFun_mex.mki
echo BORLAND=%BORLAND%>> testFun_mex.mki
echo OMPFLAGS= >> testFun_mex.mki
echo OMPLINKFLAGS= >> testFun_mex.mki
echo EMC_COMPILER=lcc64>> testFun_mex.mki
echo EMC_CONFIG=optim>> testFun_mex.mki
"C:\Program Files\MATLAB\R2017a\bin\win64\gmake" -B -f testFun_mex.mk
