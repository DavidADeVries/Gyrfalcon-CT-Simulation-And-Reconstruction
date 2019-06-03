/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * testFun.c
 *
 * Code generation for function 'testFun'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "testFun.h"
#include "testFun_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "testFun_data.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 10,    /* lineNo */
  "testFun",                           /* fcnName */
  "C:\\Users\\MPRadmin\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Test Bed\\testFun.m"/* pathName */
};

static emlrtRSInfo b_emlrtRSI = { 9,   /* lineNo */
  "sum",                               /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\sum.m"/* pathName */
};

static emlrtRSInfo c_emlrtRSI = { 58,  /* lineNo */
  "sumprod",                           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\private\\sumprod.m"/* pathName */
};

static emlrtRSInfo d_emlrtRSI = { 77,  /* lineNo */
  "combine_vector_elements",           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\private\\combine_vector_elements.m"/* pathName */
};

static emlrtRSInfo e_emlrtRSI = { 21,  /* lineNo */
  "eml_int_forloop_overflow_check",    /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\eml\\eml_int_forloop_overflow_check.m"/* pathName */
};

static emlrtRTEInfo emlrtRTEI = { 1,   /* lineNo */
  14,                                  /* colNo */
  "testFun",                           /* fName */
  "C:\\Users\\MPRadmin\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Test Bed\\testFun.m"/* pName */
};

static emlrtBCInfo emlrtBCI = { -1,    /* iFirst */
  -1,                                  /* iLast */
  10,                                  /* lineNo */
  18,                                  /* colNo */
  "m",                                 /* aName */
  "testFun",                           /* fName */
  "C:\\Users\\MPRadmin\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Test Bed\\testFun.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo c_emlrtRTEI = { 20,/* lineNo */
  15,                                  /* colNo */
  "sumprod",                           /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\private\\sumprod.m"/* pName */
};

static emlrtBCInfo b_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  10,                                  /* lineNo */
  7,                                   /* colNo */
  "a",                                 /* aName */
  "testFun",                           /* fName */
  "C:\\Users\\MPRadmin\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Test Bed\\testFun.m",/* pName */
  0                                    /* checkKind */
};

/* Function Definitions */
void testFun(const emlrtStack *sp, const emxArray_cell_wrap_0 *m,
             emxArray_real_T *a)
{
  int32_T k;
  int32_T i;
  boolean_T overflow;
  real_T y;
  int32_T i0;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;

  /* UNTITLED Summary of this function goes here */
  /*    Detailed explanation goes here */
  k = a->size[0];
  a->size[0] = m->size[0];
  emxEnsureCapacity(sp, (emxArray__common *)a, k, sizeof(real_T), &emlrtRTEI);
  i = 0;
  while (i <= m->size[0] - 1) {
    st.site = &emlrtRSI;
    k = m->size[0] - 1;
    if (!((i >= 0) && (i <= k))) {
      emlrtDynamicBoundsCheckR2012b(i, 0, k, &emlrtBCI, &st);
    }

    b_st.site = &b_emlrtRSI;
    if ((m->data[i].f1->size[1] == 1) || (m->data[i].f1->size[1] != 1)) {
      overflow = true;
    } else {
      overflow = false;
    }

    if (!overflow) {
      emlrtErrorWithMessageIdR2012b(&b_st, &c_emlrtRTEI,
        "Coder:toolbox:autoDimIncompatibility", 0);
    }

    c_st.site = &c_emlrtRSI;
    if (m->data[i].f1->size[1] == 0) {
      y = 0.0;
    } else {
      y = m->data[i].f1->data[0];
      d_st.site = &d_emlrtRSI;
      overflow = ((!(2 > m->data[i].f1->size[1])) && (m->data[i].f1->size[1] >
        2147483646));
      if (overflow) {
        e_st.site = &e_emlrtRSI;
        check_forloop_overflow_error(&e_st);
      }

      for (k = 2; k <= m->data[i].f1->size[1]; k++) {
        y += m->data[i].f1->data[k - 1];
      }
    }

    k = a->size[0];
    i0 = 1 + i;
    if (!((i0 >= 1) && (i0 <= k))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, k, &b_emlrtBCI, sp);
    }

    a->data[i0 - 1] = y;
    i++;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }
}

/* End of code generation (testFun.c) */
