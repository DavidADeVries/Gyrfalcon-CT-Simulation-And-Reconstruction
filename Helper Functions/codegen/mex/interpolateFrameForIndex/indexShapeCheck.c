/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * indexShapeCheck.c
 *
 * Code generation for function 'indexShapeCheck'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interpolateFrameForIndex.h"
#include "indexShapeCheck.h"

/* Variable Definitions */
static emlrtRSInfo y_emlrtRSI = { 14,  /* lineNo */
  "indexShapeCheck",                   /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\indexShapeCheck.m"/* pathName */
};

static emlrtRSInfo ab_emlrtRSI = { 80, /* lineNo */
  "indexShapeCheck",                   /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\indexShapeCheck.m"/* pathName */
};

static emlrtRTEInfo v_emlrtRTEI = { 88,/* lineNo */
  9,                                   /* colNo */
  "indexShapeCheck",                   /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\indexShapeCheck.m"/* pName */
};

/* Function Definitions */
void indexShapeCheck(const emlrtStack *sp, const int32_T matrixSize[2], const
                     int32_T indexSize[2])
{
  boolean_T nonSingletonDimFound;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  nonSingletonDimFound = false;
  if (matrixSize[0] != 1) {
    nonSingletonDimFound = true;
  }

  if (matrixSize[1] != 1) {
    if (nonSingletonDimFound) {
      nonSingletonDimFound = false;
    } else {
      nonSingletonDimFound = true;
    }
  }

  if (nonSingletonDimFound) {
    nonSingletonDimFound = false;
    if (indexSize[0] != 1) {
      nonSingletonDimFound = true;
    }

    if (indexSize[1] != 1) {
      if (nonSingletonDimFound) {
        nonSingletonDimFound = false;
      } else {
        nonSingletonDimFound = true;
      }
    }

    if (nonSingletonDimFound) {
      st.site = &y_emlrtRSI;
      nonSingletonDimFound = ((matrixSize[0] == 1) != (indexSize[0] == 1));
      if (nonSingletonDimFound || ((matrixSize[1] == 1) != (indexSize[1] == 1)))
      {
        nonSingletonDimFound = true;
      }

      b_st.site = &ab_emlrtRSI;
      if (nonSingletonDimFound) {
        emlrtErrorWithMessageIdR2012b(&b_st, &v_emlrtRTEI,
          "Coder:FE:PotentialMatrixMatrix", 0);
      }
    }
  }
}

/* End of code generation (indexShapeCheck.c) */
