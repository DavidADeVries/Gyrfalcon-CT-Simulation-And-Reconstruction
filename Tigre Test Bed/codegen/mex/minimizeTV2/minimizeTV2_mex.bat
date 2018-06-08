@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2017a
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2017a\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=minimizeTV2_mex
set MEX_NAME=minimizeTV2_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for minimizeTV2 > minimizeTV2_mex.mki
echo COMPILER=%COMPILER%>> minimizeTV2_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> minimizeTV2_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> minimizeTV2_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> minimizeTV2_mex.mki
echo LINKER=%LINKER%>> minimizeTV2_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> minimizeTV2_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> minimizeTV2_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> minimizeTV2_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> minimizeTV2_mex.mki
echo BORLAND=%BORLAND%>> minimizeTV2_mex.mki
echo OMPFLAGS= >> minimizeTV2_mex.mki
echo OMPLINKFLAGS= >> minimizeTV2_mex.mki
echo EMC_COMPILER=msvcpp120>> minimizeTV2_mex.mki
echo EMC_CONFIG=optim>> minimizeTV2_mex.mki
"C:\Program Files\MATLAB\R2017a\bin\win64\gmake" -B -f minimizeTV2_mex.mk
