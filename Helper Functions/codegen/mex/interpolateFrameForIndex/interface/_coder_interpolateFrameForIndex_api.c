/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_interpolateFrameForIndex_api.c
 *
 * Code generation for function '_coder_interpolateFrameForIndex_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interpolateFrameForIndex.h"
#include "_coder_interpolateFrameForIndex_api.h"
#include "interpolateFrameForIndex_emxutil.h"
#include "interpolateFrameForIndex_data.h"

/* Variable Definitions */
static emlrtRTEInfo m_emlrtRTEI = { 1, /* lineNo */
  1,                                   /* colNo */
  "_coder_interpolateFrameForIndex_api",/* fName */
  ""                                   /* pName */
};

/* Function Declarations */
static real_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static const mxArray *b_emlrt_marshallOut(const boolean_T u);
static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *targetLocationInM, const char_T *identifier, emxArray_real_T *y);
static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y);
static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *frame, const
  char_T *identifier, emxArray_real_T *y);
static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *x, const
  char_T *identifier);
static const mxArray *emlrt_marshallOut(const real_T u);
static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y);
static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *rayRejectionMap, const char_T *identifier, emxArray_boolean_T *y);
static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_boolean_T *y);
static real_T i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);
static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret);
static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret);
static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_boolean_T *ret);

/* Function Definitions */
static real_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = i_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static const mxArray *b_emlrt_marshallOut(const boolean_T u)
{
  const mxArray *y;
  const mxArray *m2;
  y = NULL;
  m2 = emlrtCreateLogicalScalar(u);
  emlrtAssign(&y, m2);
  return y;
}

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *targetLocationInM, const char_T *identifier, emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  d_emlrt_marshallIn(sp, emlrtAlias(targetLocationInM), &thisId, y);
  emlrtDestroyArray(&targetLocationInM);
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
{
  j_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *frame, const
  char_T *identifier, emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  f_emlrt_marshallIn(sp, emlrtAlias(frame), &thisId, y);
  emlrtDestroyArray(&frame);
}

static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *x, const
  char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(x), &thisId);
  emlrtDestroyArray(&x);
  return y;
}

static const mxArray *emlrt_marshallOut(const real_T u)
{
  const mxArray *y;
  const mxArray *m1;
  y = NULL;
  m1 = emlrtCreateDoubleScalar(u);
  emlrtAssign(&y, m1);
  return y;
}

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
{
  k_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *rayRejectionMap, const char_T *identifier, emxArray_boolean_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  h_emlrt_marshallIn(sp, emlrtAlias(rayRejectionMap), &thisId, y);
  emlrtDestroyArray(&rayRejectionMap);
}

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_boolean_T *y)
{
  l_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[2] = { 1, -1 };

  const boolean_T bv0[2] = { false, true };

  int32_T iv4[2];
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims, &bv0[0],
    iv4);
  ret->size[0] = iv4[0];
  ret->size[1] = iv4[1];
  ret->allocatedSize = ret->size[0] * ret->size[1];
  ret->data = (real_T *)mxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[2] = { -1, -1 };

  const boolean_T bv1[2] = { true, true };

  int32_T iv5[2];
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims, &bv1[0],
    iv5);
  ret->size[0] = iv5[0];
  ret->size[1] = iv5[1];
  ret->allocatedSize = ret->size[0] * ret->size[1];
  ret->data = (real_T *)mxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_boolean_T *ret)
{
  static const int32_T dims[2] = { -1, -1 };

  const boolean_T bv2[2] = { true, true };

  int32_T iv6[2];
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "logical", false, 2U, dims, &bv2[0],
    iv6);
  ret->size[0] = iv6[0];
  ret->size[1] = iv6[1];
  ret->allocatedSize = ret->size[0] * ret->size[1];
  ret->data = (boolean_T *)mxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

void interpolateFrameForIndex_api(const mxArray * const prhs[7], const mxArray
  *plhs[2])
{
  emxArray_real_T *targetLocationInM;
  emxArray_real_T *targetPixelDimsInM;
  emxArray_real_T *frame;
  emxArray_boolean_T *rayRejectionMap;
  emxArray_real_T *detectorPixelDimsInM;
  real_T x;
  real_T y;
  real_T value;
  boolean_T isRejected;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_real_T(&st, &targetLocationInM, 2, &m_emlrtRTEI, true);
  emxInit_real_T(&st, &targetPixelDimsInM, 2, &m_emlrtRTEI, true);
  emxInit_real_T(&st, &frame, 2, &m_emlrtRTEI, true);
  emxInit_boolean_T(&st, &rayRejectionMap, 2, &m_emlrtRTEI, true);
  emxInit_real_T(&st, &detectorPixelDimsInM, 2, &m_emlrtRTEI, true);

  /* Marshall function inputs */
  x = emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "x");
  y = emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "y");
  c_emlrt_marshallIn(&st, emlrtAlias(prhs[2]), "targetLocationInM",
                     targetLocationInM);
  c_emlrt_marshallIn(&st, emlrtAlias(prhs[3]), "targetPixelDimsInM",
                     targetPixelDimsInM);
  e_emlrt_marshallIn(&st, emlrtAlias(prhs[4]), "frame", frame);
  g_emlrt_marshallIn(&st, emlrtAlias(prhs[5]), "rayRejectionMap",
                     rayRejectionMap);
  c_emlrt_marshallIn(&st, emlrtAlias(prhs[6]), "detectorPixelDimsInM",
                     detectorPixelDimsInM);

  /* Invoke the target function */
  interpolateFrameForIndex(&st, x, y, targetLocationInM, targetPixelDimsInM,
    frame, rayRejectionMap, detectorPixelDimsInM, &value, &isRejected);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(value);
  plhs[1] = b_emlrt_marshallOut(isRejected);
  detectorPixelDimsInM->canFreeData = false;
  emxFree_real_T(&detectorPixelDimsInM);
  rayRejectionMap->canFreeData = false;
  emxFree_boolean_T(&rayRejectionMap);
  frame->canFreeData = false;
  emxFree_real_T(&frame);
  targetPixelDimsInM->canFreeData = false;
  emxFree_real_T(&targetPixelDimsInM);
  targetLocationInM->canFreeData = false;
  emxFree_real_T(&targetLocationInM);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_interpolateFrameForIndex_api.c) */
