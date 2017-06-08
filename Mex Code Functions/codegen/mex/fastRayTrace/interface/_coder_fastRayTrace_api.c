/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_fastRayTrace_api.c
 *
 * Code generation for function '_coder_fastRayTrace_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "fastRayTrace.h"
#include "_coder_fastRayTrace_api.h"
#include "fastRayTrace_emxutil.h"
#include "fastRayTrace_data.h"

/* Variable Definitions */
static emlrtRTEInfo emlrtRTEI = { 1,   /* lineNo */
  1,                                   /* colNo */
  "_coder_fastRayTrace_api",           /* fName */
  ""                                   /* pName */
};

/* Function Declarations */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[3];
static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *phantomData,
  const char_T *identifier, emxArray_real_T *y);
static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y);
static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *startingIntensity, const char_T *identifier);
static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *pointSourceCoords, const char_T *identifier))[3];
static const mxArray *emlrt_marshallOut(const real_T u);
static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static real_T (*g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[3];
static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret);
static real_T i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);

/* Function Definitions */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[3]
{
  real_T (*y)[3];
  y = g_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *phantomData, const char_T *identifier, emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  d_emlrt_marshallIn(sp, emlrtAlias(phantomData), &thisId, y);
  emlrtDestroyArray(&phantomData);
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
{
  h_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *startingIntensity, const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = f_emlrt_marshallIn(sp, emlrtAlias(startingIntensity), &thisId);
  emlrtDestroyArray(&startingIntensity);
  return y;
}

static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *pointSourceCoords, const char_T *identifier))[3]
{
  real_T (*y)[3];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(pointSourceCoords), &thisId);
  emlrtDestroyArray(&pointSourceCoords);
  return y;
}
  static const mxArray *emlrt_marshallOut(const real_T u)
{
  const mxArray *y;
  const mxArray *m0;
  y = NULL;
  m0 = emlrtCreateDoubleScalar(u);
  emlrtAssign(&y, m0);
  return y;
}

static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = i_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T (*g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[3]
{
  real_T (*ret)[3];
  static const int32_T dims[2] = { 1, 3 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims);
  ret = (real_T (*)[3])mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[3] = { -1, -1, -1 };

  const boolean_T bv0[3] = { true, true, true };

  int32_T iv1[3];
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 3U, dims, &bv0[0],
    iv1);
  ret->size[0] = iv1[0];
  ret->size[1] = iv1[1];
  ret->size[2] = iv1[2];
  ret->allocatedSize = ret->size[0] * ret->size[1] * ret->size[2];
  ret->data = (real_T *)mxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
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

void fastRayTrace_api(const mxArray * const prhs[7], const mxArray *plhs[1])
{
  emxArray_real_T *phantomData;
  real_T (*pointSourceCoords)[3];
  real_T (*pointDetectorCoords)[3];
  real_T (*phantomLocationInM)[3];
  real_T (*phantomDims)[3];
  real_T (*voxelDimsInM)[3];
  real_T startingIntensity;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_real_T(&st, &phantomData, 3, &emlrtRTEI, true);

  /* Marshall function inputs */
  pointSourceCoords = emlrt_marshallIn(&st, emlrtAlias(prhs[0]),
    "pointSourceCoords");
  pointDetectorCoords = emlrt_marshallIn(&st, emlrtAlias(prhs[1]),
    "pointDetectorCoords");
  phantomLocationInM = emlrt_marshallIn(&st, emlrtAlias(prhs[2]),
    "phantomLocationInM");
  phantomDims = emlrt_marshallIn(&st, emlrtAlias(prhs[3]), "phantomDims");
  voxelDimsInM = emlrt_marshallIn(&st, emlrtAlias(prhs[4]), "voxelDimsInM");
  c_emlrt_marshallIn(&st, emlrtAlias(prhs[5]), "phantomData", phantomData);
  startingIntensity = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[6]),
    "startingIntensity");

  /* Invoke the target function */
  startingIntensity = fastRayTrace(&st, *pointSourceCoords, *pointDetectorCoords,
    *phantomLocationInM, *phantomDims, *voxelDimsInM, phantomData,
    startingIntensity);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(startingIntensity);
  phantomData->canFreeData = false;
  emxFree_real_T(&phantomData);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_fastRayTrace_api.c) */
