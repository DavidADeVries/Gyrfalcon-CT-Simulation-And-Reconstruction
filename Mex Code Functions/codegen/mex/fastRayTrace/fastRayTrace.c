/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * fastRayTrace.c
 *
 * Code generation for function 'fastRayTrace'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "fastRayTrace.h"
#include "norm.h"
#include "sign.h"
#include "fastRayTrace_data.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 89,    /* lineNo */
  "fastRayTrace",                      /* fcnName */
  "C:\\Users\\MPRadmin\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Mex Code Functions\\fastRayTrace.m"/* pathName */
};

static emlrtRSInfo b_emlrtRSI = { 95,  /* lineNo */
  "fastRayTrace",                      /* fcnName */
  "C:\\Users\\MPRadmin\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Mex Code Functions\\fastRayTrace.m"/* pathName */
};

static emlrtRSInfo c_emlrtRSI = { 13,  /* lineNo */
  "min",                               /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\min.m"/* pathName */
};

static emlrtRSInfo d_emlrtRSI = { 19,  /* lineNo */
  "minOrMax",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pathName */
};

static emlrtDCInfo emlrtDCI = { 102,   /* lineNo */
  35,                                  /* colNo */
  "fastRayTrace",                      /* fName */
  "C:\\Users\\MPRadmin\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Mex Code Functions\\fastRayTrace.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo emlrtBCI = { -1,    /* iFirst */
  -1,                                  /* iLast */
  102,                                 /* lineNo */
  35,                                  /* colNo */
  "phantomData",                       /* aName */
  "fastRayTrace",                      /* fName */
  "C:\\Users\\MPRadmin\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Mex Code Functions\\fastRayTrace.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo b_emlrtDCI = { 102, /* lineNo */
  47,                                  /* colNo */
  "fastRayTrace",                      /* fName */
  "C:\\Users\\MPRadmin\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Mex Code Functions\\fastRayTrace.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo b_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  102,                                 /* lineNo */
  47,                                  /* colNo */
  "phantomData",                       /* aName */
  "fastRayTrace",                      /* fName */
  "C:\\Users\\MPRadmin\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Mex Code Functions\\fastRayTrace.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo c_emlrtDCI = { 102, /* lineNo */
  59,                                  /* colNo */
  "fastRayTrace",                      /* fName */
  "C:\\Users\\MPRadmin\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Mex Code Functions\\fastRayTrace.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo c_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  102,                                 /* lineNo */
  59,                                  /* colNo */
  "phantomData",                       /* aName */
  "fastRayTrace",                      /* fName */
  "C:\\Users\\MPRadmin\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Mex Code Functions\\fastRayTrace.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo emlrtECI = { -1,    /* nDims */
  134,                                 /* lineNo */
  5,                                   /* colNo */
  "fastRayTrace",                      /* fName */
  "C:\\Users\\MPRadmin\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Mex Code Functions\\fastRayTrace.m"/* pName */
};

static emlrtECInfo b_emlrtECI = { -1,  /* nDims */
  135,                                 /* lineNo */
  5,                                   /* colNo */
  "fastRayTrace",                      /* fName */
  "C:\\Users\\MPRadmin\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Mex Code Functions\\fastRayTrace.m"/* pName */
};

static emlrtRTEInfo b_emlrtRTEI = { 39,/* lineNo */
  27,                                  /* colNo */
  "minOrMax",                          /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pName */
};

static emlrtRTEInfo c_emlrtRTEI = { 121,/* lineNo */
  27,                                  /* colNo */
  "minOrMax",                          /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pName */
};

/* Function Definitions */
real_T fastRayTrace(const emlrtStack *sp, const real_T pointSourceCoords[3],
                    const real_T pointDetectorCoords[3], const real_T
                    phantomLocationInM[3], const real_T phantomDims[3], const
                    real_T voxelDimsInM[3], const emxArray_real_T *phantomData,
                    real_T startingIntensity)
{
  real_T rawDetectorValue;
  real_T bounds1[3];
  real_T bounds2[3];
  int32_T i;
  int32_T trueCount;
  real_T b_bounds1;
  real_T tMins;
  real_T b_tMins[3];
  int32_T ixstart;
  real_T deltas[3];
  real_T tMaxs[3];
  real_T invDeltas[3];
  int32_T tmp_data[3];
  real_T b_bounds2[3];
  int32_T b_tmp_data[3];
  real_T tMin;
  real_T tMax;
  real_T radonSum;
  real_T nextLatticeAdder[3];
  boolean_T isDeltaNeg[3];
  boolean_T latticeToIndex[3];
  real_T invVoxelDims[3];
  static const int8_T iv0[3] = { 1, -1, -1 };

  boolean_T b_isDeltaNeg[3];
  boolean_T isDelta0[3];
  int32_T c_tmp_data[3];
  real_T floorVals_data[3];
  int32_T b_trueCount;
  int32_T d_tmp_data[3];
  real_T ceilVals_data[3];
  int32_T e_tmp_data[3];
  boolean_T b0;
  boolean_T exitg1;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;

  /*  rawDetectorValue = fastRayTrace(pointSourceCoords, pointDetectorCoords, phantomLocationInM, phantomDims, voxelDimsInM, phantomData, startingIntensity) */
  bounds1[0] = phantomLocationInM[0];
  bounds2[0] = phantomLocationInM[0] + voxelDimsInM[0] * phantomDims[0];
  for (i = 0; i < 2; i++) {
    bounds1[i + 1] = phantomLocationInM[1 + i] - voxelDimsInM[1 + i] *
      phantomDims[1 + i];
    bounds2[i + 1] = phantomLocationInM[1 + i];
  }

  /*  [deltas, point] = createLineEquation(point1, point2) */
  /*  creates a description of a line in 3-space to satisfy the equation: */
  /*  newPoint = point + t*deltas */
  for (i = 0; i < 3; i++) {
    b_bounds1 = pointDetectorCoords[i] - pointSourceCoords[i];
    tMins = 1.0 / b_bounds1;
    b_tMins[i] = (bounds1[i] - pointSourceCoords[i]) * tMins;
    tMaxs[i] = (bounds2[i] - pointSourceCoords[i]) * tMins;
    deltas[i] = b_bounds1;
    invDeltas[i] = tMins;
  }

  trueCount = 0;
  for (i = 0; i < 3; i++) {
    if (deltas[i] < 0.0) {
      trueCount++;
    }
  }

  ixstart = 0;
  for (i = 0; i < 3; i++) {
    if (deltas[i] < 0.0) {
      tmp_data[ixstart] = i + 1;
      ixstart++;
    }

    b_bounds2[i] = (bounds2[i] - pointSourceCoords[i]) * invDeltas[i];
  }

  for (i = 0; i < trueCount; i++) {
    b_tMins[tmp_data[i] - 1] = b_bounds2[tmp_data[i] - 1];
  }

  trueCount = 0;
  for (i = 0; i < 3; i++) {
    if (deltas[i] < 0.0) {
      trueCount++;
    }
  }

  ixstart = 0;
  for (i = 0; i < 3; i++) {
    if (deltas[i] < 0.0) {
      b_tmp_data[ixstart] = i + 1;
      ixstart++;
    }

    b_bounds2[i] = (bounds1[i] - pointSourceCoords[i]) * invDeltas[i];
  }

  for (i = 0; i < trueCount; i++) {
    tMaxs[b_tmp_data[i] - 1] = b_bounds2[b_tmp_data[i] - 1];
  }

  tMin = rtMinusInf;
  tMax = rtInf;
  if (deltas[0] != 0.0) {
    if (b_tMins[0] > rtMinusInf) {
      tMin = b_tMins[0];
    }

    if (tMaxs[0] < rtInf) {
      tMax = tMaxs[0];
    }
  } else {
    if ((pointSourceCoords[0] > bounds2[0]) || (pointSourceCoords[0] < bounds1[0]))
    {
      tMin = rtInf;
      tMax = rtMinusInf;
    }
  }

  if (deltas[1] != 0.0) {
    if (b_tMins[1] > tMin) {
      tMin = b_tMins[1];
    }

    if (tMaxs[1] < tMax) {
      tMax = tMaxs[1];
    }
  } else {
    if ((pointSourceCoords[1] > bounds2[1]) || (pointSourceCoords[1] < bounds1[1]))
    {
      tMin = rtInf;
      tMax = rtMinusInf;
    }
  }

  if (deltas[2] != 0.0) {
    if (b_tMins[2] > tMin) {
      tMin = b_tMins[2];
    }

    if (tMaxs[2] < tMax) {
      tMax = tMaxs[2];
    }
  } else {
    if ((pointSourceCoords[2] > bounds2[2]) || (pointSourceCoords[2] < bounds1[2]))
    {
      tMin = rtInf;
      tMax = rtMinusInf;
    }
  }

  if (tMax < tMin) {
    rawDetectorValue = startingIntensity;
  } else {
    /*  run through the voxels */
    /* shift over so corner is at origin */
    /*  have starting point and end point, now will find which voxels and with */
    /*  what distances across each voxel the ray travels */
    radonSum = 0.0;
    for (i = 0; i < 3; i++) {
      tMins = pointSourceCoords[i] - phantomLocationInM[i];
      tMaxs[i] = tMins + tMin * deltas[i];
      isDeltaNeg[i] = (deltas[i] < 0.0);
      invVoxelDims[i] = 1.0 / voxelDimsInM[i];
      nextLatticeAdder[i] = deltas[i];
      b_tMins[i] = tMins;
    }

    b_sign(nextLatticeAdder);
    for (i = 0; i < 3; i++) {
      latticeToIndex[i] = isDeltaNeg[i];
      nextLatticeAdder[i] *= (real_T)iv0[i];
    }

    latticeToIndex[0] = !isDeltaNeg[0];
    for (i = 0; i < 3; i++) {
      if (deltas[i] == 0.0) {
        latticeToIndex[i] = true;
      }
    }

    /* needs to be, since we always floor to find the lattice for delta == 0 */
    while (tMin < tMax) {
      st.site = &emlrtRSI;

      /*  ** HELPER FUNCTIONS ** */
      /*  first need to kill off any rounding errors */
      for (ixstart = 0; ixstart < 3; ixstart++) {
        b_isDeltaNeg[ixstart] = isDeltaNeg[ixstart];
        isDelta0[ixstart] = (deltas[ixstart] == 0.0);
        bounds1[ixstart] = muDoubleScalarFloor((real_T)iv0[ixstart] *
          (tMaxs[ixstart] * invVoxelDims[ixstart]) * 1.0E+10 + 0.5) * 1.0E-10;
      }

      /*  no round to get lattice/index values */
      b_isDeltaNeg[0] = !isDeltaNeg[0];

      /*  ceiling if delta is positive ONLY */
      trueCount = 0;
      for (i = 0; i < 3; i++) {
        if (b_isDeltaNeg[i] || isDelta0[i]) {
          trueCount++;
        }
      }

      ixstart = 0;
      for (i = 0; i < 3; i++) {
        if (b_isDeltaNeg[i] || isDelta0[i]) {
          c_tmp_data[ixstart] = i + 1;
          ixstart++;
        }
      }

      for (i = 0; i < trueCount; i++) {
        floorVals_data[i] = bounds1[c_tmp_data[i] - 1];
      }

      for (ixstart = 0; ixstart + 1 <= trueCount; ixstart++) {
        floorVals_data[ixstart] = muDoubleScalarFloor(floorVals_data[ixstart]);
      }

      b_trueCount = 0;
      for (i = 0; i < 3; i++) {
        if (!(b_isDeltaNeg[i] || isDelta0[i])) {
          b_trueCount++;
        }
      }

      ixstart = 0;
      for (i = 0; i < 3; i++) {
        if (!(b_isDeltaNeg[i] || isDelta0[i])) {
          d_tmp_data[ixstart] = i + 1;
          ixstart++;
        }
      }

      for (i = 0; i < b_trueCount; i++) {
        ceilVals_data[i] = bounds1[d_tmp_data[i] - 1];
      }

      for (ixstart = 0; ixstart + 1 <= b_trueCount; ixstart++) {
        ceilVals_data[ixstart] = muDoubleScalarCeil(ceilVals_data[ixstart]);
      }

      ixstart = 0;
      for (i = 0; i < 3; i++) {
        bounds2[i] = 0.0;
        if (b_isDeltaNeg[i] || isDelta0[i]) {
          ixstart++;
        }
      }

      if (ixstart != trueCount) {
        emlrtSizeEqCheck1DR2012b(ixstart, trueCount, &emlrtECI, &st);
      }

      ixstart = 0;
      trueCount = 0;
      for (i = 0; i < 3; i++) {
        if (b_isDeltaNeg[i] || isDelta0[i]) {
          bounds2[i] = floorVals_data[ixstart];
          ixstart++;
        }

        if (!(b_isDeltaNeg[i] || isDelta0[i])) {
          trueCount++;
        }
      }

      if (trueCount != b_trueCount) {
        emlrtSizeEqCheck1DR2012b(trueCount, b_trueCount, &b_emlrtECI, &st);
      }

      ixstart = 0;
      for (i = 0; i < 3; i++) {
        if (!(b_isDeltaNeg[i] || isDelta0[i])) {
          bounds2[i] = ceilVals_data[ixstart];
          ixstart++;
        }

        if (voxelDimsInM[i] == 0.0) {
          bounds2[i] = 0.0;
        }
      }

      trueCount = 0;
      for (i = 0; i < 3; i++) {
        bounds1[i] = ((bounds2[i] + nextLatticeAdder[i]) * voxelDimsInM[i] *
                      (real_T)iv0[i] - b_tMins[i]) * invDeltas[i];
        if (!(deltas[i] == 0.0)) {
          trueCount++;
        }
      }

      ixstart = 0;
      for (i = 0; i < 3; i++) {
        if (!(deltas[i] == 0.0)) {
          e_tmp_data[ixstart] = i + 1;
          ixstart++;
        }
      }

      st.site = &b_emlrtRSI;
      for (i = 0; i < 3; i++) {
        b_bounds2[i] = ((bounds2[i] + nextLatticeAdder[i]) * voxelDimsInM[i] *
                        (real_T)iv0[i] - b_tMins[i]) * invDeltas[i];
      }

      for (i = 0; i < trueCount; i++) {
        floorVals_data[i] = b_bounds2[e_tmp_data[i] - 1];
      }

      b_st.site = &c_emlrtRSI;
      c_st.site = &d_emlrtRSI;
      if ((trueCount == 1) || (trueCount != 1)) {
        b0 = true;
      } else {
        b0 = false;
      }

      if (!b0) {
        emlrtErrorWithMessageIdR2012b(&c_st, &b_emlrtRTEI,
          "Coder:toolbox:autoDimIncompatibility", 0);
      }

      if (!(trueCount > 0)) {
        emlrtErrorWithMessageIdR2012b(&c_st, &c_emlrtRTEI,
          "Coder:toolbox:eml_min_or_max_varDimZero", 0);
      }

      ixstart = 1;
      tMin = bounds1[e_tmp_data[0] - 1];
      if (trueCount > 1) {
        if (muDoubleScalarIsNaN(bounds1[e_tmp_data[0] - 1])) {
          i = 2;
          exitg1 = false;
          while ((!exitg1) && (i <= trueCount)) {
            ixstart = i;
            if (!muDoubleScalarIsNaN(bounds1[e_tmp_data[i - 1] - 1])) {
              tMin = bounds1[e_tmp_data[i - 1] - 1];
              exitg1 = true;
            } else {
              i++;
            }
          }
        }

        if (ixstart < trueCount) {
          while (ixstart + 1 <= trueCount) {
            if (bounds1[e_tmp_data[ixstart] - 1] < tMin) {
              tMin = bounds1[e_tmp_data[ixstart] - 1];
            }

            ixstart++;
          }
        }
      }

      for (i = 0; i < 3; i++) {
        b_bounds1 = b_tMins[i] + tMin * deltas[i];
        b_bounds2[i] = tMaxs[i] - b_bounds1;
        bounds1[i] = b_bounds1;
        bounds2[i] += (real_T)latticeToIndex[i];
      }

      if (bounds2[1] != (int32_T)muDoubleScalarFloor(bounds2[1])) {
        emlrtIntegerCheckR2012b(bounds2[1], &emlrtDCI, sp);
      }

      i = phantomData->size[0];
      ixstart = (int32_T)bounds2[1];
      if (!((ixstart >= 1) && (ixstart <= i))) {
        emlrtDynamicBoundsCheckR2012b(ixstart, 1, i, &emlrtBCI, sp);
      }

      if (bounds2[0] != (int32_T)muDoubleScalarFloor(bounds2[0])) {
        emlrtIntegerCheckR2012b(bounds2[0], &b_emlrtDCI, sp);
      }

      i = phantomData->size[1];
      ixstart = (int32_T)bounds2[0];
      if (!((ixstart >= 1) && (ixstart <= i))) {
        emlrtDynamicBoundsCheckR2012b(ixstart, 1, i, &b_emlrtBCI, sp);
      }

      if (bounds2[2] != (int32_T)muDoubleScalarFloor(bounds2[2])) {
        emlrtIntegerCheckR2012b(bounds2[2], &c_emlrtDCI, sp);
      }

      i = phantomData->size[2];
      ixstart = (int32_T)bounds2[2];
      if (!((ixstart >= 1) && (ixstart <= i))) {
        emlrtDynamicBoundsCheckR2012b(ixstart, 1, i, &c_emlrtBCI, sp);
      }

      for (i = 0; i < 3; i++) {
        tMaxs[i] = bounds1[i];
      }

      radonSum += norm(b_bounds2) * phantomData->data[(((int32_T)bounds2[1] +
        phantomData->size[0] * ((int32_T)bounds2[0] - 1)) + phantomData->size[0]
        * phantomData->size[1] * ((int32_T)bounds2[2] - 1)) - 1];
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(sp);
      }
    }

    rawDetectorValue = startingIntensity * muDoubleScalarExp(-radonSum);
  }

  return rawDetectorValue;
}

/* End of code generation (fastRayTrace.c) */
