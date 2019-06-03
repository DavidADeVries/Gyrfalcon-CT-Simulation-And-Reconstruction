/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interpolateFrameForIndex_terminate.c
 *
 * Code generation for function 'interpolateFrameForIndex_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interpolateFrameForIndex.h"
#include "interpolateFrameForIndex_terminate.h"
#include "_coder_interpolateFrameForIndex_mex.h"
#include "interpolateFrameForIndex_data.h"

/* Function Definitions */
void interpolateFrameForIndex_atexit(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void interpolateFrameForIndex_terminate(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (interpolateFrameForIndex_terminate.c) */
