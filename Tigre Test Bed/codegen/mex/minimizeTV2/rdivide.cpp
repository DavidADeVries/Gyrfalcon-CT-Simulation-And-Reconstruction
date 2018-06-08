/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * rdivide.cpp
 *
 * Code generation for function 'rdivide'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "minimizeTV2.h"
#include "rdivide.h"
#include "minimizeTV2_emxutil.h"

/* Variable Definitions */
static emlrtRTEInfo g_emlrtRTEI = { 1, /* lineNo */
  14,                                  /* colNo */
  "rdivide",                           /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\ops\\rdivide.m"/* pName */
};

static emlrtRTEInfo m_emlrtRTEI = { 13,/* lineNo */
  15,                                  /* colNo */
  "rdivide",                           /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\ops\\rdivide.m"/* pName */
};

/* Function Definitions */
void rdivide(const emlrtStack *sp, const emxArray_real32_T *x, const
             emxArray_real32_T *y, emxArray_real32_T *z)
{
  int32_T k;
  uint32_T varargin_1[3];
  boolean_T p;
  uint32_T varargin_2[3];
  boolean_T b_p;
  boolean_T exitg1;
  int32_T loop_ub;
  for (k = 0; k < 3; k++) {
    varargin_1[k] = (uint32_T)x->size[k];
  }

  for (k = 0; k < 3; k++) {
    varargin_2[k] = (uint32_T)y->size[k];
  }

  p = false;
  b_p = true;
  k = 0;
  exitg1 = false;
  while ((!exitg1) && (k < 3)) {
    if (!((int32_T)varargin_1[k] == (int32_T)varargin_2[k])) {
      b_p = false;
      exitg1 = true;
    } else {
      k++;
    }
  }

  if (b_p) {
    p = true;
  }

  if (!p) {
    emlrtErrorWithMessageIdR2012b(sp, &m_emlrtRTEI, "MATLAB:dimagree", 0);
  }

  k = z->size[0] * z->size[1] * z->size[2];
  z->size[0] = x->size[0];
  z->size[1] = x->size[1];
  z->size[2] = x->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)z, k, sizeof(real32_T), &g_emlrtRTEI);
  loop_ub = x->size[0] * x->size[1] * x->size[2];
  for (k = 0; k < loop_ub; k++) {
    z->data[k] = x->data[k] / y->data[k];
  }
}

/* End of code generation (rdivide.cpp) */
