/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sqrt.cpp
 *
 * Code generation for function 'sqrt'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "minimizeTV2.h"
#include "sqrt.h"
#include "error.h"
#include "eml_int_forloop_overflow_check.h"
#include "minimizeTV2_data.h"

/* Variable Definitions */
static emlrtRSInfo n_emlrtRSI = { 15,  /* lineNo */
  "sqrt",                              /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\elfun\\sqrt.m"/* pathName */
};

static emlrtRSInfo o_emlrtRSI = { 26,  /* lineNo */
  "applyScalarFunctionInPlace",        /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\applyScalarFunctionInPlace.m"/* pathName */
};

/* Function Definitions */
void b_sqrt(const emlrtStack *sp, emxArray_real32_T *x)
{
  boolean_T p;
  int32_T nx;
  int32_T k;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  p = false;
  nx = x->size[0] * x->size[1] * x->size[2];
  for (k = 0; k < nx; k++) {
    if (p || (x->data[k] < 0.0F)) {
      p = true;
    } else {
      p = false;
    }
  }

  if (p) {
    st.site = &m_emlrtRSI;
    error(&st);
  }

  st.site = &n_emlrtRSI;
  nx = x->size[0] * x->size[1] * x->size[2];
  b_st.site = &o_emlrtRSI;
  if ((!(1 > nx)) && (nx > 2147483646)) {
    c_st.site = &l_emlrtRSI;
    check_forloop_overflow_error(&c_st);
  }

  for (k = 0; k + 1 <= nx; k++) {
    x->data[k] = muSingleScalarSqrt(x->data[k]);
  }
}

/* End of code generation (sqrt.cpp) */
