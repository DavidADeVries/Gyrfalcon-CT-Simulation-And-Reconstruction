@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2017a
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2017a\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=interpolateFrameForIndex_mex
set MEX_NAME=interpolateFrameForIndex_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for interpolateFrameForIndex > interpolateFrameForIndex_mex.mki
echo COMPILER=%COMPILER%>> interpolateFrameForIndex_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> interpolateFrameForIndex_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> interpolateFrameForIndex_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> interpolateFrameForIndex_mex.mki
echo LINKER=%LINKER%>> interpolateFrameForIndex_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> interpolateFrameForIndex_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> interpolateFrameForIndex_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> interpolateFrameForIndex_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> interpolateFrameForIndex_mex.mki
echo BORLAND=%BORLAND%>> interpolateFrameForIndex_mex.mki
echo OMPFLAGS= >> interpolateFrameForIndex_mex.mki
echo OMPLINKFLAGS= >> interpolateFrameForIndex_mex.mki
echo EMC_COMPILER=msvc120>> interpolateFrameForIndex_mex.mki
echo EMC_CONFIG=optim>> interpolateFrameForIndex_mex.mki
"C:\Program Files\MATLAB\R2017a\bin\win64\gmake" -B -f interpolateFrameForIndex_mex.mk
