/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * testFun_emxutil.h
 *
 * Code generation for function 'testFun_emxutil'
 *
 */

#ifndef TESTFUN_EMXUTIL_H
#define TESTFUN_EMXUTIL_H

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "rtwtypes.h"
#include "testFun_types.h"

/* Function Declarations */
extern void emxEnsureCapacity(const emlrtStack *sp, emxArray__common *emxArray,
  int32_T oldNumel, uint32_T elementSize, const emlrtRTEInfo *srcLocation);
extern void emxEnsureCapacity_cell_wrap_0(const emlrtStack *sp,
  emxArray_cell_wrap_0 *emxArray, int32_T oldNumel, const emlrtRTEInfo
  *srcLocation);
extern void emxFree_cell_wrap_0(emxArray_cell_wrap_0 **pEmxArray);
extern void emxFree_real_T(emxArray_real_T **pEmxArray);
extern void emxInit_cell_wrap_0(const emlrtStack *sp, emxArray_cell_wrap_0
  **pEmxArray, int32_T numDimensions, const emlrtRTEInfo *srcLocation, boolean_T
  doPush);
extern void emxInit_real_T(const emlrtStack *sp, emxArray_real_T **pEmxArray,
  int32_T numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);

#endif

/* End of code generation (testFun_emxutil.h) */
