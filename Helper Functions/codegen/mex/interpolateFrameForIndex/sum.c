/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sum.c
 *
 * Code generation for function 'sum'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interpolateFrameForIndex.h"
#include "sum.h"
#include "eml_int_forloop_overflow_check.h"
#include "interpolateFrameForIndex_emxutil.h"
#include "interpolateFrameForIndex_data.h"

/* Variable Definitions */
static emlrtRSInfo eb_emlrtRSI = { 9,  /* lineNo */
  "sum",                               /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\sum.m"/* pathName */
};

static emlrtRSInfo fb_emlrtRSI = { 58, /* lineNo */
  "sumprod",                           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\private\\sumprod.m"/* pathName */
};

static emlrtRSInfo gb_emlrtRSI = { 107,/* lineNo */
  "combine_vector_elements",           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\private\\combine_vector_elements.m"/* pathName */
};

static emlrtRSInfo hb_emlrtRSI = { 121,/* lineNo */
  "combine_vector_elements",           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\private\\combine_vector_elements.m"/* pathName */
};

static emlrtRSInfo ib_emlrtRSI = { 77, /* lineNo */
  "combine_vector_elements",           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\private\\combine_vector_elements.m"/* pathName */
};

static emlrtRTEInfo k_emlrtRTEI = { 1, /* lineNo */
  14,                                  /* colNo */
  "sum",                               /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\sum.m"/* pName */
};

static emlrtRTEInfo w_emlrtRTEI = { 48,/* lineNo */
  9,                                   /* colNo */
  "sumprod",                           /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\private\\sumprod.m"/* pName */
};

static emlrtRTEInfo x_emlrtRTEI = { 20,/* lineNo */
  15,                                  /* colNo */
  "sumprod",                           /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\private\\sumprod.m"/* pName */
};

/* Function Definitions */
real_T b_sum(const emlrtStack *sp, const emxArray_real_T *x)
{
  real_T y;
  boolean_T overflow;
  int32_T k;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &eb_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  if ((x->size[1] == 1) || (x->size[1] != 1)) {
    overflow = true;
  } else {
    overflow = false;
  }

  if (!overflow) {
    emlrtErrorWithMessageIdR2012b(&st, &x_emlrtRTEI,
      "Coder:toolbox:autoDimIncompatibility", 0);
  }

  b_st.site = &fb_emlrtRSI;
  if (x->size[1] == 0) {
    y = 0.0;
  } else {
    y = x->data[0];
    c_st.site = &ib_emlrtRSI;
    overflow = ((!(2 > x->size[1])) && (x->size[1] > 2147483646));
    if (overflow) {
      d_st.site = &n_emlrtRSI;
      check_forloop_overflow_error(&d_st);
    }

    for (k = 2; k <= x->size[1]; k++) {
      y += x->data[k - 1];
    }
  }

  return y;
}

void sum(const emlrtStack *sp, const emxArray_real_T *x, emxArray_real_T *y)
{
  boolean_T overflow;
  boolean_T p;
  int32_T vlen;
  int32_T i;
  int32_T xoffset;
  real_T s;
  int32_T k;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &eb_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  if (((x->size[0] == 1) && (x->size[1] == 1)) || (x->size[0] != 1)) {
    overflow = true;
  } else {
    overflow = false;
  }

  if (!overflow) {
    emlrtErrorWithMessageIdR2012b(&st, &x_emlrtRTEI,
      "Coder:toolbox:autoDimIncompatibility", 0);
  }

  overflow = false;
  p = false;
  if ((x->size[0] != 0) || (x->size[1] != 0)) {
  } else {
    p = true;
  }

  if (p) {
    overflow = true;
  }

  if (overflow) {
    emlrtErrorWithMessageIdR2012b(&st, &w_emlrtRTEI,
      "Coder:toolbox:UnsupportedSpecialEmpty", 0);
  }

  b_st.site = &fb_emlrtRSI;
  vlen = y->size[0] * y->size[1];
  y->size[0] = 1;
  y->size[1] = x->size[1];
  emxEnsureCapacity(&b_st, (emxArray__common *)y, vlen, sizeof(real_T),
                    &k_emlrtRTEI);
  if ((x->size[0] == 0) || (x->size[1] == 0)) {
    vlen = y->size[0] * y->size[1];
    y->size[0] = 1;
    emxEnsureCapacity(&b_st, (emxArray__common *)y, vlen, sizeof(real_T),
                      &k_emlrtRTEI);
    i = y->size[1];
    for (vlen = 0; vlen < i; vlen++) {
      y->data[y->size[0] * vlen] = 0.0;
    }
  } else {
    vlen = x->size[0];
    c_st.site = &gb_emlrtRSI;
    overflow = (x->size[1] > 2147483646);
    if (overflow) {
      d_st.site = &n_emlrtRSI;
      check_forloop_overflow_error(&d_st);
    }

    for (i = 0; i + 1 <= x->size[1]; i++) {
      xoffset = i * vlen;
      s = x->data[xoffset];
      c_st.site = &hb_emlrtRSI;
      if ((!(2 > vlen)) && (vlen > 2147483646)) {
        d_st.site = &n_emlrtRSI;
        check_forloop_overflow_error(&d_st);
      }

      for (k = 2; k <= vlen; k++) {
        s += x->data[(xoffset + k) - 1];
      }

      y->data[i] = s;
    }
  }
}

/* End of code generation (sum.c) */
