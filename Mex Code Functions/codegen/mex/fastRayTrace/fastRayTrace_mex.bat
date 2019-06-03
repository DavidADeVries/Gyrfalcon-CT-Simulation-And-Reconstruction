@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2017a
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2017a\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=fastRayTrace_mex
set MEX_NAME=fastRayTrace_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for fastRayTrace > fastRayTrace_mex.mki
echo COMPILER=%COMPILER%>> fastRayTrace_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> fastRayTrace_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> fastRayTrace_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> fastRayTrace_mex.mki
echo LINKER=%LINKER%>> fastRayTrace_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> fastRayTrace_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> fastRayTrace_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> fastRayTrace_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> fastRayTrace_mex.mki
echo BORLAND=%BORLAND%>> fastRayTrace_mex.mki
echo OMPFLAGS= >> fastRayTrace_mex.mki
echo OMPLINKFLAGS= >> fastRayTrace_mex.mki
echo EMC_COMPILER=mingw64>> fastRayTrace_mex.mki
echo EMC_CONFIG=optim>> fastRayTrace_mex.mki
"C:\Program Files\MATLAB\R2017a\bin\win64\gmake" -B -f fastRayTrace_mex.mk
