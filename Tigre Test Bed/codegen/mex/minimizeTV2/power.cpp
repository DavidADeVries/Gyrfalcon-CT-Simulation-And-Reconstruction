/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * power.cpp
 *
 * Code generation for function 'power'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "minimizeTV2.h"
#include "power.h"
#include "minimizeTV2_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "scalexpAlloc.h"
#include "minimizeTV2_data.h"

/* Variable Definitions */
static emlrtRSInfo h_emlrtRSI = { 49,  /* lineNo */
  "power",                             /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\ops\\power.m"/* pathName */
};

static emlrtRSInfo i_emlrtRSI = { 58,  /* lineNo */
  "power",                             /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\ops\\power.m"/* pathName */
};

static emlrtRSInfo j_emlrtRSI = { 73,  /* lineNo */
  "applyScalarFunction",               /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\applyScalarFunction.m"/* pathName */
};

static emlrtRSInfo k_emlrtRSI = { 146, /* lineNo */
  "applyScalarFunction",               /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\applyScalarFunction.m"/* pathName */
};

static emlrtRTEInfo f_emlrtRTEI = { 16,/* lineNo */
  9,                                   /* colNo */
  "scalexpAlloc",                      /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\scalexpAlloc.m"/* pName */
};

static emlrtRTEInfo k_emlrtRTEI = { 17,/* lineNo */
  19,                                  /* colNo */
  "scalexpAlloc",                      /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\scalexpAlloc.m"/* pName */
};

/* Function Definitions */
void b_power(const emlrtStack *sp, const emxArray_real_T *a, emxArray_real_T *y)
{
  int32_T n;
  uint32_T uv1[3];
  int32_T k;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &h_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  b_st.site = &i_emlrtRSI;
  c_st.site = &j_emlrtRSI;
  for (n = 0; n < 3; n++) {
    uv1[n] = (uint32_T)a->size[n];
  }

  n = y->size[0] * y->size[1] * y->size[2];
  y->size[0] = (int32_T)uv1[0];
  y->size[1] = (int32_T)uv1[1];
  y->size[2] = (int32_T)uv1[2];
  emxEnsureCapacity(&c_st, (emxArray__common *)y, n, sizeof(real_T),
                    &f_emlrtRTEI);
  if (!b_dimagree(y, a)) {
    emlrtErrorWithMessageIdR2012b(&c_st, &k_emlrtRTEI, "MATLAB:dimagree", 0);
  }

  n = a->size[0] * a->size[1] * a->size[2];
  c_st.site = &k_emlrtRSI;
  if ((!(1 > n)) && (n > 2147483646)) {
    d_st.site = &l_emlrtRSI;
    check_forloop_overflow_error(&d_st);
  }

  for (k = 0; k + 1 <= n; k++) {
    y->data[k] = a->data[k] * a->data[k];
  }
}

void power(const emlrtStack *sp, const emxArray_real32_T *a, emxArray_real32_T
           *y)
{
  int32_T n;
  uint32_T uv0[3];
  int32_T k;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &h_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  b_st.site = &i_emlrtRSI;
  c_st.site = &j_emlrtRSI;
  for (n = 0; n < 3; n++) {
    uv0[n] = (uint32_T)a->size[n];
  }

  n = y->size[0] * y->size[1] * y->size[2];
  y->size[0] = (int32_T)uv0[0];
  y->size[1] = (int32_T)uv0[1];
  y->size[2] = (int32_T)uv0[2];
  emxEnsureCapacity(&c_st, (emxArray__common *)y, n, sizeof(real32_T),
                    &f_emlrtRTEI);
  if (!dimagree(y, a)) {
    emlrtErrorWithMessageIdR2012b(&c_st, &k_emlrtRTEI, "MATLAB:dimagree", 0);
  }

  n = a->size[0] * a->size[1] * a->size[2];
  c_st.site = &k_emlrtRSI;
  if ((!(1 > n)) && (n > 2147483646)) {
    d_st.site = &l_emlrtRSI;
    check_forloop_overflow_error(&d_st);
  }

  for (k = 0; k + 1 <= n; k++) {
    y->data[k] = a->data[k] * a->data[k];
  }
}

/* End of code generation (power.cpp) */
