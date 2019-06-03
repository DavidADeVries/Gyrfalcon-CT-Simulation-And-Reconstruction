/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_testFun_api.c
 *
 * Code generation for function '_coder_testFun_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "testFun.h"
#include "_coder_testFun_api.h"
#include "testFun_emxutil.h"
#include "testFun_data.h"

/* Variable Definitions */
static emlrtRTEInfo b_emlrtRTEI = { 1, /* lineNo */
  1,                                   /* colNo */
  "_coder_testFun_api",                /* fName */
  ""                                   /* pName */
};

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_cell_wrap_0 *y);
static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y);
static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret);
static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *m, const
  char_T *identifier, emxArray_cell_wrap_0 *y);
static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);

/* Function Definitions */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_cell_wrap_0 *y)
{
  emlrtMsgIdentifier thisId;
  int32_T iv0[1];
  boolean_T bv0[1];
  int32_T sizes[1];
  int32_T i1;
  char_T str[11];
  thisId.fParent = parentId;
  thisId.bParentIsCell = true;
  iv0[0] = -1;
  bv0[0] = true;
  emlrtCheckVsCell(sp, parentId, u, 1U, iv0, bv0, sizes);
  i1 = y->size[0];
  y->size[0] = sizes[0];
  emxEnsureCapacity_cell_wrap_0(sp, y, i1, (emlrtRTEInfo *)NULL);
  for (i1 = 0; i1 < sizes[0]; i1++) {
    sprintf(&str[0], "%d", i1 + 1);
    thisId.fIdentifier = &str[0];
    c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell(sp, parentId, u, i1)),
                       &thisId, y->data[i1].f1);
  }

  emlrtDestroyArray(&u);
}

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
{
  d_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[2] = { 1, -1 };

  const boolean_T bv1[2] = { false, true };

  int32_T iv2[2];
  int32_T i2;
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims, &bv1[0],
    iv2);
  i2 = ret->size[0] * ret->size[1];
  ret->size[0] = iv2[0];
  ret->size[1] = iv2[1];
  emxEnsureCapacity(sp, (emxArray__common *)ret, i2, sizeof(real_T),
                    (emlrtRTEInfo *)NULL);
  emlrtImportArrayR2015b(sp, src, ret->data, 8, false);
  emlrtDestroyArray(&src);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *m, const
  char_T *identifier, emxArray_cell_wrap_0 *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(m), &thisId, y);
  emlrtDestroyArray(&m);
}

static const mxArray *emlrt_marshallOut(const emxArray_real_T *u)
{
  const mxArray *y;
  const mxArray *m0;
  static const int32_T iv1[1] = { 0 };

  y = NULL;
  m0 = emlrtCreateNumericArray(1, iv1, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m0, (void *)&u->data[0]);
  emlrtSetDimensions((mxArray *)m0, u->size, 1);
  emlrtAssign(&y, m0);
  return y;
}

void testFun_api(const mxArray * const prhs[1], const mxArray *plhs[1])
{
  emxArray_cell_wrap_0 *m;
  emxArray_real_T *a;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_cell_wrap_0(&st, &m, 1, &b_emlrtRTEI, true);
  emxInit_real_T(&st, &a, 1, &b_emlrtRTEI, true);

  /* Marshall function inputs */
  emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "m", m);

  /* Invoke the target function */
  testFun(&st, m, a);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(a);
  a->canFreeData = false;
  emxFree_real_T(&a);
  emxFree_cell_wrap_0(&m);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_testFun_api.c) */
