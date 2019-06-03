/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interpolateFrameForIndex.h
 *
 * Code generation for function 'interpolateFrameForIndex'
 *
 */

#ifndef INTERPOLATEFRAMEFORINDEX_H
#define INTERPOLATEFRAMEFORINDEX_H

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
#include "interpolateFrameForIndex_types.h"

/* Function Declarations */
extern void interpolateFrameForIndex(const emlrtStack *sp, real_T x, real_T y,
  const emxArray_real_T *targetLocationInM, const emxArray_real_T
  *targetPixelDimsInM, const emxArray_real_T *frame, const emxArray_boolean_T
  *rayRejectionMap, const emxArray_real_T *detectorPixelDimsInM, real_T *value,
  boolean_T *isRejected);

#endif

/* End of code generation (interpolateFrameForIndex.h) */
