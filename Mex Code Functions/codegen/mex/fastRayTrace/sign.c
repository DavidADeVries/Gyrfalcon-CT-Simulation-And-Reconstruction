/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sign.c
 *
 * Code generation for function 'sign'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "fastRayTrace.h"
#include "sign.h"

/* Function Definitions */
void b_sign(real_T x[3])
{
  int32_T k;
  for (k = 0; k < 3; k++) {
    x[k] = muDoubleScalarSign(x[k]);
  }
}

/* End of code generation (sign.c) */
