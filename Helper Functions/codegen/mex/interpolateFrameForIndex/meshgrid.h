/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * meshgrid.h
 *
 * Code generation for function 'meshgrid'
 *
 */

#ifndef MESHGRID_H
#define MESHGRID_H

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
extern void meshgrid(const emlrtStack *sp, const emxArray_real_T *x, const
                     emxArray_real_T *y, emxArray_real_T *xx, emxArray_real_T
                     *yy);

#endif

/* End of code generation (meshgrid.h) */
