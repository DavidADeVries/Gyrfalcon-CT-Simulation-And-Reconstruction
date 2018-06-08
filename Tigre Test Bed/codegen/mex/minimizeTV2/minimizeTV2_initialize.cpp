/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * minimizeTV2_initialize.cpp
 *
 * Code generation for function 'minimizeTV2_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "minimizeTV2.h"
#include "minimizeTV2_initialize.h"
#include "_coder_minimizeTV2_mex.h"
#include "minimizeTV2_data.h"

/* Function Definitions */
void minimizeTV2_initialize()
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (minimizeTV2_initialize.cpp) */
