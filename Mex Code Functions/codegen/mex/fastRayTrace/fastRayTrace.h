/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * fastRayTrace.h
 *
 * Code generation for function 'fastRayTrace'
 *
 */

#ifndef FASTRAYTRACE_H
#define FASTRAYTRACE_H

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mwmathutil.h"
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "rtwtypes.h"
#include "fastRayTrace_types.h"

/* Function Declarations */
extern real_T fastRayTrace(const emlrtStack *sp, const real_T pointSourceCoords
  [3], const real_T pointDetectorCoords[3], const real_T phantomLocationInM[3],
  const real_T phantomDims[3], const real_T voxelDimsInM[3], const
  emxArray_real_T *phantomData, real_T startingIntensity);

#ifdef __WATCOMC__

#pragma aux fastRayTrace value [8087];

#endif
#endif

/* End of code generation (fastRayTrace.h) */
