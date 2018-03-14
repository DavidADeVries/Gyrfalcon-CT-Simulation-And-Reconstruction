/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interpolateFrameForIndex.c
 *
 * Code generation for function 'interpolateFrameForIndex'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interpolateFrameForIndex.h"
#include "rdivide.h"
#include "interpolateFrameForIndex_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "sum.h"
#include "indexShapeCheck.h"
#include "sub2ind.h"
#include "meshgrid.h"
#include "interpolateFrameForIndex_data.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 10,    /* lineNo */
  "interpolateFrameForIndex",          /* fcnName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pathName */
};

static emlrtRSInfo b_emlrtRSI = { 11,  /* lineNo */
  "interpolateFrameForIndex",          /* fcnName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pathName */
};

static emlrtRSInfo c_emlrtRSI = { 22,  /* lineNo */
  "interpolateFrameForIndex",          /* fcnName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pathName */
};

static emlrtRSInfo d_emlrtRSI = { 26,  /* lineNo */
  "interpolateFrameForIndex",          /* fcnName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pathName */
};

static emlrtRSInfo e_emlrtRSI = { 28,  /* lineNo */
  "interpolateFrameForIndex",          /* fcnName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pathName */
};

static emlrtRSInfo f_emlrtRSI = { 30,  /* lineNo */
  "interpolateFrameForIndex",          /* fcnName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pathName */
};

static emlrtRSInfo g_emlrtRSI = { 31,  /* lineNo */
  "interpolateFrameForIndex",          /* fcnName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pathName */
};

static emlrtRSInfo h_emlrtRSI = { 33,  /* lineNo */
  "interpolateFrameForIndex",          /* fcnName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pathName */
};

static emlrtRSInfo i_emlrtRSI = { 37,  /* lineNo */
  "interpolateFrameForIndex",          /* fcnName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pathName */
};

static emlrtRSInfo j_emlrtRSI = { 43,  /* lineNo */
  "interpolateFrameForIndex",          /* fcnName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pathName */
};

static emlrtRSInfo k_emlrtRSI = { 98,  /* lineNo */
  "colon",                             /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\ops\\colon.m"/* pathName */
};

static emlrtRSInfo l_emlrtRSI = { 282, /* lineNo */
  "colon",                             /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\ops\\colon.m"/* pathName */
};

static emlrtRSInfo m_emlrtRSI = { 290, /* lineNo */
  "colon",                             /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\ops\\colon.m"/* pathName */
};

static emlrtRSInfo v_emlrtRSI = { 16,  /* lineNo */
  "sub2ind",                           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\elmat\\sub2ind.m"/* pathName */
};

static emlrtRSInfo w_emlrtRSI = { 39,  /* lineNo */
  "sub2ind",                           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\elmat\\sub2ind.m"/* pathName */
};

static emlrtRSInfo bb_emlrtRSI = { 12, /* lineNo */
  "all",                               /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\ops\\all.m"/* pathName */
};

static emlrtRSInfo cb_emlrtRSI = { 117,/* lineNo */
  "allOrAny",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\allOrAny.m"/* pathName */
};

static emlrtRSInfo db_emlrtRSI = { 124,/* lineNo */
  "allOrAny",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\allOrAny.m"/* pathName */
};

static emlrtRTEInfo emlrtRTEI = { 1,   /* lineNo */
  32,                                  /* colNo */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pName */
};

static emlrtRTEInfo b_emlrtRTEI = { 10,/* lineNo */
  5,                                   /* colNo */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pName */
};

static emlrtRTEInfo c_emlrtRTEI = { 11,/* lineNo */
  5,                                   /* colNo */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pName */
};

static emlrtRTEInfo d_emlrtRTEI = { 13,/* lineNo */
  5,                                   /* colNo */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pName */
};

static emlrtRTEInfo e_emlrtRTEI = { 14,/* lineNo */
  5,                                   /* colNo */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pName */
};

static emlrtRTEInfo f_emlrtRTEI = { 24,/* lineNo */
  5,                                   /* colNo */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pName */
};

static emlrtRTEInfo g_emlrtRTEI = { 28,/* lineNo */
  5,                                   /* colNo */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pName */
};

static emlrtRTEInfo h_emlrtRTEI = { 31,/* lineNo */
  5,                                   /* colNo */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pName */
};

static emlrtRTEInfo i_emlrtRTEI = { 39,/* lineNo */
  5,                                   /* colNo */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pName */
};

static emlrtRTEInfo n_emlrtRTEI = { 42,/* lineNo */
  19,                                  /* colNo */
  "allOrAny",                          /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\allOrAny.m"/* pName */
};

static emlrtRTEInfo o_emlrtRTEI = { 39,/* lineNo */
  19,                                  /* colNo */
  "allOrAny",                          /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\eml\\+coder\\+internal\\allOrAny.m"/* pName */
};

static emlrtRTEInfo p_emlrtRTEI = { 41,/* lineNo */
  19,                                  /* colNo */
  "sub2ind",                           /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\elmat\\sub2ind.m"/* pName */
};

static emlrtRTEInfo q_emlrtRTEI = { 31,/* lineNo */
  23,                                  /* colNo */
  "sub2ind",                           /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\elmat\\sub2ind.m"/* pName */
};

static emlrtRTEInfo r_emlrtRTEI = { 388,/* lineNo */
  15,                                  /* colNo */
  "colon",                             /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\ops\\colon.m"/* pName */
};

static emlrtECInfo emlrtECI = { 2,     /* nDims */
  41,                                  /* lineNo */
  25,                                  /* colNo */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pName */
};

static emlrtECInfo b_emlrtECI = { 2,   /* nDims */
  35,                                  /* lineNo */
  13,                                  /* colNo */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pName */
};

static emlrtECInfo c_emlrtECI = { 2,   /* nDims */
  24,                                  /* lineNo */
  13,                                  /* colNo */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m"/* pName */
};

static emlrtBCInfo emlrtBCI = { -1,    /* iFirst */
  -1,                                  /* iLast */
  20,                                  /* lineNo */
  82,                                  /* colNo */
  "detectorPixelDimsInM",              /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo b_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  19,                                  /* lineNo */
  18,                                  /* colNo */
  "ySideLengths",                      /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo c_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  19,                                  /* lineNo */
  89,                                  /* colNo */
  "detectorPixelDimsInM",              /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo d_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  19,                                  /* lineNo */
  62,                                  /* colNo */
  "yIndices",                          /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo e_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  19,                                  /* lineNo */
  36,                                  /* colNo */
  "ySideLengths",                      /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo f_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  17,                                  /* lineNo */
  82,                                  /* colNo */
  "detectorPixelDimsInM",              /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo g_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  16,                                  /* lineNo */
  18,                                  /* colNo */
  "xSideLengths",                      /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo h_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  16,                                  /* lineNo */
  87,                                  /* colNo */
  "detectorPixelDimsInM",              /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo i_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  16,                                  /* lineNo */
  60,                                  /* colNo */
  "xIndices",                          /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo j_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  16,                                  /* lineNo */
  36,                                  /* colNo */
  "xSideLengths",                      /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo k_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  14,                                  /* lineNo */
  66,                                  /* colNo */
  "detectorPixelDimsInM",              /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo l_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  13,                                  /* lineNo */
  66,                                  /* colNo */
  "detectorPixelDimsInM",              /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo m_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  11,                                  /* lineNo */
  99,                                  /* colNo */
  "detectorPixelDimsInM",              /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo n_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  11,                                  /* lineNo */
  53,                                  /* colNo */
  "detectorPixelDimsInM",              /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo o_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  10,                                  /* lineNo */
  99,                                  /* colNo */
  "detectorPixelDimsInM",              /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo p_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  10,                                  /* lineNo */
  51,                                  /* colNo */
  "detectorPixelDimsInM",              /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo q_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  8,                                   /* lineNo */
  63,                                  /* colNo */
  "targetPixelDimsInM",                /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo r_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  8,                                   /* lineNo */
  33,                                  /* colNo */
  "targetLocationInM",                 /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo s_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  7,                                   /* lineNo */
  58,                                  /* colNo */
  "targetPixelDimsInM",                /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo t_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  7,                                   /* lineNo */
  30,                                  /* colNo */
  "targetLocationInM",                 /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo u_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  5,                                   /* lineNo */
  60,                                  /* colNo */
  "targetPixelDimsInM",                /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo v_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  5,                                   /* lineNo */
  32,                                  /* colNo */
  "targetLocationInM",                 /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo w_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  4,                                   /* lineNo */
  61,                                  /* colNo */
  "targetPixelDimsInM",                /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo x_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  4,                                   /* lineNo */
  31,                                  /* colNo */
  "targetLocationInM",                 /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo y_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  17,                                  /* lineNo */
  38,                                  /* colNo */
  "xSideLengths",                      /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ab_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  17,                                  /* lineNo */
  56,                                  /* colNo */
  "xIndices",                          /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo bb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  17,                                  /* lineNo */
  18,                                  /* colNo */
  "xSideLengths",                      /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo cb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  20,                                  /* lineNo */
  38,                                  /* colNo */
  "ySideLengths",                      /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo db_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  20,                                  /* lineNo */
  56,                                  /* colNo */
  "yIndices",                          /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo eb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  20,                                  /* lineNo */
  18,                                  /* colNo */
  "ySideLengths",                      /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo fb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  30,                                  /* lineNo */
  23,                                  /* colNo */
  "frame",                             /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo gb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  31,                                  /* lineNo */
  37,                                  /* colNo */
  "rayRejectionMap",                   /* aName */
  "interpolateFrameForIndex",          /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Helper Functions\\interpolateFrameForIndex.m",/* pName */
  0                                    /* checkKind */
};

/* Function Definitions */
void interpolateFrameForIndex(const emlrtStack *sp, real_T x, real_T y, const
  emxArray_real_T *targetLocationInM, const emxArray_real_T *targetPixelDimsInM,
  const emxArray_real_T *frame, const emxArray_boolean_T *rayRejectionMap, const
  emxArray_real_T *detectorPixelDimsInM, real_T *value, boolean_T *isRejected)
{
  int32_T iy;
  real_T xLeft;
  real_T xRight;
  real_T yTop;
  real_T yBottom;
  real_T ndbl;
  real_T b_x;
  real_T apnd;
  real_T c_x;
  real_T cdiff;
  emxArray_real_T *xIndices;
  real_T absa;
  int32_T npages;
  real_T absb;
  int32_T i2;
  emxArray_real_T *yIndices;
  int32_T nm1d2;
  emxArray_real_T *xSideLengths;
  emxArray_real_T *ySideLengths;
  emxArray_real_T *areas;
  emxArray_real_T *areasNorm;
  int32_T b_areas[2];
  int32_T b_areasNorm[2];
  emxArray_real_T *frameIndices;
  int32_T siz[2];
  boolean_T overflow;
  uint32_T outsize[2];
  boolean_T p;
  uint32_T varargin_2[2];
  boolean_T exitg1;
  emxArray_boolean_T *rayRejectVals;
  emxArray_boolean_T *d_x;
  int32_T i;
  int32_T i1;
  emxArray_real_T *b_frame;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);

  /* function [value, isRejected] = interpolateFrameForIndex(x, y, targetLocationInM, targetPixelDimsInM, frame, rayRejectionMap, detectorPixelDimsInM) */
  iy = targetLocationInM->size[1];
  if (!(1 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(1, 1, iy, &x_emlrtBCI, sp);
  }

  iy = targetPixelDimsInM->size[1];
  if (!(1 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(1, 1, iy, &w_emlrtBCI, sp);
  }

  xLeft = targetLocationInM->data[0] + (x - 1.0) * targetPixelDimsInM->data[0];
  iy = targetLocationInM->size[1];
  if (!(1 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(1, 1, iy, &v_emlrtBCI, sp);
  }

  iy = targetPixelDimsInM->size[1];
  if (!(1 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(1, 1, iy, &u_emlrtBCI, sp);
  }

  xRight = targetLocationInM->data[0] + x * targetPixelDimsInM->data[0];
  iy = targetLocationInM->size[1];
  if (!(2 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(2, 1, iy, &t_emlrtBCI, sp);
  }

  iy = targetPixelDimsInM->size[1];
  if (!(2 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(2, 1, iy, &s_emlrtBCI, sp);
  }

  yTop = targetLocationInM->data[1] + y * targetPixelDimsInM->data[1];
  iy = targetLocationInM->size[1];
  if (!(2 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(2, 1, iy, &r_emlrtBCI, sp);
  }

  iy = targetPixelDimsInM->size[1];
  if (!(2 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(2, 1, iy, &q_emlrtBCI, sp);
  }

  yBottom = targetLocationInM->data[1] + (y - 1.0) * targetPixelDimsInM->data[1];
  iy = detectorPixelDimsInM->size[1];
  if (!(1 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(1, 1, iy, &p_emlrtBCI, sp);
  }

  iy = detectorPixelDimsInM->size[1];
  if (!(1 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(1, 1, iy, &o_emlrtBCI, sp);
  }

  ndbl = xLeft / detectorPixelDimsInM->data[0];
  b_x = muDoubleScalarFloor(ndbl);
  apnd = xRight / detectorPixelDimsInM->data[0];
  c_x = muDoubleScalarFloor(apnd);
  st.site = &emlrtRSI;
  cdiff = muDoubleScalarFloor(ndbl) + 1.0;
  ndbl = muDoubleScalarFloor(apnd) + 1.0;
  emxInit_real_T(&st, &xIndices, 2, &b_emlrtRTEI, true);
  if (muDoubleScalarIsNaN(cdiff) || muDoubleScalarIsNaN(ndbl)) {
    iy = xIndices->size[0] * xIndices->size[1];
    xIndices->size[0] = 1;
    xIndices->size[1] = 1;
    emxEnsureCapacity(&st, (emxArray__common *)xIndices, iy, sizeof(real_T),
                      &emlrtRTEI);
    xIndices->data[0] = rtNaN;
  } else if (c_x + 1.0 < b_x + 1.0) {
    iy = xIndices->size[0] * xIndices->size[1];
    xIndices->size[0] = 1;
    xIndices->size[1] = 0;
    emxEnsureCapacity(&st, (emxArray__common *)xIndices, iy, sizeof(real_T),
                      &emlrtRTEI);
  } else if ((muDoubleScalarIsInf(cdiff) || muDoubleScalarIsInf(ndbl)) && (b_x +
              1.0 == c_x + 1.0)) {
    iy = xIndices->size[0] * xIndices->size[1];
    xIndices->size[0] = 1;
    xIndices->size[1] = 1;
    emxEnsureCapacity(&st, (emxArray__common *)xIndices, iy, sizeof(real_T),
                      &emlrtRTEI);
    xIndices->data[0] = rtNaN;
  } else if (cdiff == b_x + 1.0) {
    iy = xIndices->size[0] * xIndices->size[1];
    xIndices->size[0] = 1;
    xIndices->size[1] = (int32_T)((c_x + 1.0) - (b_x + 1.0)) + 1;
    emxEnsureCapacity(&st, (emxArray__common *)xIndices, iy, sizeof(real_T),
                      &emlrtRTEI);
    npages = (int32_T)((c_x + 1.0) - (b_x + 1.0));
    for (iy = 0; iy <= npages; iy++) {
      xIndices->data[xIndices->size[0] * iy] = (b_x + 1.0) + (real_T)iy;
    }
  } else {
    b_st.site = &k_emlrtRSI;
    ndbl = muDoubleScalarFloor(((c_x + 1.0) - (b_x + 1.0)) + 0.5);
    apnd = (b_x + 1.0) + ndbl;
    cdiff = apnd - (c_x + 1.0);
    absa = muDoubleScalarAbs(b_x + 1.0);
    absb = muDoubleScalarAbs(c_x + 1.0);
    if (muDoubleScalarAbs(cdiff) < 4.4408920985006262E-16 * muDoubleScalarMax
        (absa, absb)) {
      ndbl++;
      apnd = c_x + 1.0;
    } else if (cdiff > 0.0) {
      apnd = (b_x + 1.0) + (ndbl - 1.0);
    } else {
      ndbl++;
    }

    if (ndbl >= 0.0) {
      i2 = (int32_T)ndbl;
    } else {
      i2 = 0;
    }

    c_st.site = &l_emlrtRSI;
    if (2.147483647E+9 < ndbl) {
      emlrtErrorWithMessageIdR2012b(&c_st, &r_emlrtRTEI, "Coder:MATLAB:pmaxsize",
        0);
    }

    iy = xIndices->size[0] * xIndices->size[1];
    xIndices->size[0] = 1;
    xIndices->size[1] = i2;
    emxEnsureCapacity(&b_st, (emxArray__common *)xIndices, iy, sizeof(real_T),
                      &emlrtRTEI);
    if (i2 > 0) {
      xIndices->data[0] = b_x + 1.0;
      if (i2 > 1) {
        xIndices->data[i2 - 1] = apnd;
        nm1d2 = (i2 - 1) / 2;
        c_st.site = &m_emlrtRSI;
        for (npages = 1; npages < nm1d2; npages++) {
          xIndices->data[npages] = (b_x + 1.0) + (real_T)npages;
          xIndices->data[(i2 - npages) - 1] = apnd - (real_T)npages;
        }

        if (nm1d2 << 1 == i2 - 1) {
          xIndices->data[nm1d2] = ((b_x + 1.0) + apnd) / 2.0;
        } else {
          xIndices->data[nm1d2] = (b_x + 1.0) + (real_T)nm1d2;
          xIndices->data[nm1d2 + 1] = apnd - (real_T)nm1d2;
        }
      }
    }
  }

  iy = detectorPixelDimsInM->size[1];
  if (!(2 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(2, 1, iy, &n_emlrtBCI, sp);
  }

  iy = detectorPixelDimsInM->size[1];
  if (!(2 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(2, 1, iy, &m_emlrtBCI, sp);
  }

  ndbl = yBottom / detectorPixelDimsInM->data[1];
  b_x = muDoubleScalarFloor(ndbl);
  apnd = yTop / detectorPixelDimsInM->data[1];
  c_x = muDoubleScalarFloor(apnd);
  st.site = &b_emlrtRSI;
  cdiff = muDoubleScalarFloor(ndbl) + 1.0;
  ndbl = muDoubleScalarFloor(apnd) + 1.0;
  emxInit_real_T(&st, &yIndices, 2, &c_emlrtRTEI, true);
  if (muDoubleScalarIsNaN(cdiff) || muDoubleScalarIsNaN(ndbl)) {
    iy = yIndices->size[0] * yIndices->size[1];
    yIndices->size[0] = 1;
    yIndices->size[1] = 1;
    emxEnsureCapacity(&st, (emxArray__common *)yIndices, iy, sizeof(real_T),
                      &emlrtRTEI);
    yIndices->data[0] = rtNaN;
  } else if (c_x + 1.0 < b_x + 1.0) {
    iy = yIndices->size[0] * yIndices->size[1];
    yIndices->size[0] = 1;
    yIndices->size[1] = 0;
    emxEnsureCapacity(&st, (emxArray__common *)yIndices, iy, sizeof(real_T),
                      &emlrtRTEI);
  } else if ((muDoubleScalarIsInf(cdiff) || muDoubleScalarIsInf(ndbl)) && (b_x +
              1.0 == c_x + 1.0)) {
    iy = yIndices->size[0] * yIndices->size[1];
    yIndices->size[0] = 1;
    yIndices->size[1] = 1;
    emxEnsureCapacity(&st, (emxArray__common *)yIndices, iy, sizeof(real_T),
                      &emlrtRTEI);
    yIndices->data[0] = rtNaN;
  } else if (cdiff == b_x + 1.0) {
    iy = yIndices->size[0] * yIndices->size[1];
    yIndices->size[0] = 1;
    yIndices->size[1] = (int32_T)((c_x + 1.0) - (b_x + 1.0)) + 1;
    emxEnsureCapacity(&st, (emxArray__common *)yIndices, iy, sizeof(real_T),
                      &emlrtRTEI);
    npages = (int32_T)((c_x + 1.0) - (b_x + 1.0));
    for (iy = 0; iy <= npages; iy++) {
      yIndices->data[yIndices->size[0] * iy] = (b_x + 1.0) + (real_T)iy;
    }
  } else {
    b_st.site = &k_emlrtRSI;
    ndbl = muDoubleScalarFloor(((c_x + 1.0) - (b_x + 1.0)) + 0.5);
    apnd = (b_x + 1.0) + ndbl;
    cdiff = apnd - (c_x + 1.0);
    absa = muDoubleScalarAbs(b_x + 1.0);
    absb = muDoubleScalarAbs(c_x + 1.0);
    if (muDoubleScalarAbs(cdiff) < 4.4408920985006262E-16 * muDoubleScalarMax
        (absa, absb)) {
      ndbl++;
      apnd = c_x + 1.0;
    } else if (cdiff > 0.0) {
      apnd = (b_x + 1.0) + (ndbl - 1.0);
    } else {
      ndbl++;
    }

    if (ndbl >= 0.0) {
      i2 = (int32_T)ndbl;
    } else {
      i2 = 0;
    }

    c_st.site = &l_emlrtRSI;
    if (2.147483647E+9 < ndbl) {
      emlrtErrorWithMessageIdR2012b(&c_st, &r_emlrtRTEI, "Coder:MATLAB:pmaxsize",
        0);
    }

    iy = yIndices->size[0] * yIndices->size[1];
    yIndices->size[0] = 1;
    yIndices->size[1] = i2;
    emxEnsureCapacity(&b_st, (emxArray__common *)yIndices, iy, sizeof(real_T),
                      &emlrtRTEI);
    if (i2 > 0) {
      yIndices->data[0] = b_x + 1.0;
      if (i2 > 1) {
        yIndices->data[i2 - 1] = apnd;
        nm1d2 = (i2 - 1) / 2;
        c_st.site = &m_emlrtRSI;
        for (npages = 1; npages < nm1d2; npages++) {
          yIndices->data[npages] = (b_x + 1.0) + (real_T)npages;
          yIndices->data[(i2 - npages) - 1] = apnd - (real_T)npages;
        }

        if (nm1d2 << 1 == i2 - 1) {
          yIndices->data[nm1d2] = ((b_x + 1.0) + apnd) / 2.0;
        } else {
          yIndices->data[nm1d2] = (b_x + 1.0) + (real_T)nm1d2;
          yIndices->data[nm1d2 + 1] = apnd - (real_T)nm1d2;
        }
      }
    }
  }

  emxInit_real_T(&st, &xSideLengths, 2, &d_emlrtRTEI, true);
  iy = detectorPixelDimsInM->size[1];
  if (!(1 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(1, 1, iy, &l_emlrtBCI, sp);
  }

  iy = xSideLengths->size[0] * xSideLengths->size[1];
  xSideLengths->size[0] = 1;
  xSideLengths->size[1] = xIndices->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)xSideLengths, iy, sizeof(real_T),
                    &emlrtRTEI);
  ndbl = detectorPixelDimsInM->data[0];
  npages = xIndices->size[1];
  for (iy = 0; iy < npages; iy++) {
    xSideLengths->data[iy] = ndbl;
  }

  emxInit_real_T(sp, &ySideLengths, 2, &e_emlrtRTEI, true);
  iy = detectorPixelDimsInM->size[1];
  if (!(2 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(2, 1, iy, &k_emlrtBCI, sp);
  }

  iy = ySideLengths->size[0] * ySideLengths->size[1];
  ySideLengths->size[0] = 1;
  ySideLengths->size[1] = yIndices->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)ySideLengths, iy, sizeof(real_T),
                    &emlrtRTEI);
  ndbl = detectorPixelDimsInM->data[1];
  npages = yIndices->size[1];
  for (iy = 0; iy < npages; iy++) {
    ySideLengths->data[iy] = ndbl;
  }

  emxInit_real_T(sp, &areas, 2, &f_emlrtRTEI, true);
  emxInit_real_T(sp, &areasNorm, 2, &i_emlrtRTEI, true);
  iy = xSideLengths->size[1];
  if (!(1 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(1, 1, iy, &g_emlrtBCI, sp);
  }

  iy = xSideLengths->size[1];
  if (!(1 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(1, 1, iy, &j_emlrtBCI, sp);
  }

  iy = xIndices->size[1];
  if (!(1 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(1, 1, iy, &i_emlrtBCI, sp);
  }

  iy = detectorPixelDimsInM->size[1];
  if (!(1 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(1, 1, iy, &h_emlrtBCI, sp);
  }

  xSideLengths->data[0] -= xLeft - (xIndices->data[0] - 1.0) *
    detectorPixelDimsInM->data[0];
  iy = detectorPixelDimsInM->size[1];
  if (!(1 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(1, 1, iy, &f_emlrtBCI, sp);
  }

  iy = xSideLengths->size[1];
  i2 = xSideLengths->size[1];
  if (!((i2 >= 1) && (i2 <= iy))) {
    emlrtDynamicBoundsCheckR2012b(i2, 1, iy, &y_emlrtBCI, sp);
  }

  iy = xIndices->size[1];
  nm1d2 = xIndices->size[1];
  if (!((nm1d2 >= 1) && (nm1d2 <= iy))) {
    emlrtDynamicBoundsCheckR2012b(nm1d2, 1, iy, &ab_emlrtBCI, sp);
  }

  iy = xSideLengths->size[1];
  npages = xSideLengths->size[1];
  if (!((npages >= 1) && (npages <= iy))) {
    emlrtDynamicBoundsCheckR2012b(npages, 1, iy, &bb_emlrtBCI, sp);
  }

  xSideLengths->data[npages - 1] = xSideLengths->data[i2 - 1] - (xIndices->
    data[nm1d2 - 1] * detectorPixelDimsInM->data[0] - xRight);
  iy = ySideLengths->size[1];
  if (!(1 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(1, 1, iy, &b_emlrtBCI, sp);
  }

  iy = ySideLengths->size[1];
  if (!(1 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(1, 1, iy, &e_emlrtBCI, sp);
  }

  iy = yIndices->size[1];
  if (!(1 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(1, 1, iy, &d_emlrtBCI, sp);
  }

  iy = detectorPixelDimsInM->size[1];
  if (!(2 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(2, 1, iy, &c_emlrtBCI, sp);
  }

  ySideLengths->data[0] -= yBottom - (yIndices->data[0] - 1.0) *
    detectorPixelDimsInM->data[1];
  iy = detectorPixelDimsInM->size[1];
  if (!(2 <= iy)) {
    emlrtDynamicBoundsCheckR2012b(2, 1, iy, &emlrtBCI, sp);
  }

  iy = ySideLengths->size[1];
  i2 = ySideLengths->size[1];
  if (!((i2 >= 1) && (i2 <= iy))) {
    emlrtDynamicBoundsCheckR2012b(i2, 1, iy, &cb_emlrtBCI, sp);
  }

  iy = yIndices->size[1];
  nm1d2 = yIndices->size[1];
  if (!((nm1d2 >= 1) && (nm1d2 <= iy))) {
    emlrtDynamicBoundsCheckR2012b(nm1d2, 1, iy, &db_emlrtBCI, sp);
  }

  iy = ySideLengths->size[1];
  npages = ySideLengths->size[1];
  if (!((npages >= 1) && (npages <= iy))) {
    emlrtDynamicBoundsCheckR2012b(npages, 1, iy, &eb_emlrtBCI, sp);
  }

  ySideLengths->data[npages - 1] = ySideLengths->data[i2 - 1] - (yIndices->
    data[nm1d2 - 1] * detectorPixelDimsInM->data[1] - yTop);
  st.site = &c_emlrtRSI;
  meshgrid(&st, xSideLengths, ySideLengths, areas, areasNorm);
  emxFree_real_T(&ySideLengths);
  emxFree_real_T(&xSideLengths);
  for (iy = 0; iy < 2; iy++) {
    b_areas[iy] = areas->size[iy];
    b_areasNorm[iy] = areasNorm->size[iy];
  }

  if ((b_areas[0] != b_areasNorm[0]) || (b_areas[1] != b_areasNorm[1])) {
    emlrtSizeEqCheckNDR2012b(&b_areas[0], &b_areasNorm[0], &c_emlrtECI, sp);
  }

  iy = areas->size[0] * areas->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)areas, iy, sizeof(real_T),
                    &emlrtRTEI);
  nm1d2 = areas->size[0];
  npages = areas->size[1];
  npages *= nm1d2;
  for (iy = 0; iy < npages; iy++) {
    areas->data[iy] *= areasNorm->data[iy];
  }

  emxInit_real_T(sp, &frameIndices, 2, &g_emlrtRTEI, true);
  st.site = &d_emlrtRSI;
  meshgrid(&st, xIndices, yIndices, areasNorm, frameIndices);
  st.site = &e_emlrtRSI;
  b_st.site = &v_emlrtRSI;
  emxFree_real_T(&yIndices);
  for (iy = 0; iy < 2; iy++) {
    siz[iy] = frame->size[iy];
  }

  if (!allinrange(frameIndices, siz[0])) {
    emlrtErrorWithMessageIdR2012b(&b_st, &p_emlrtRTEI,
      "MATLAB:sub2ind:IndexOutOfRange", 0);
  }

  for (iy = 0; iy < 2; iy++) {
    outsize[iy] = (uint32_T)frameIndices->size[iy];
    varargin_2[iy] = (uint32_T)areasNorm->size[iy];
  }

  overflow = false;
  p = true;
  npages = 0;
  exitg1 = false;
  while ((!exitg1) && (npages < 2)) {
    if (!((int32_T)outsize[npages] == (int32_T)varargin_2[npages])) {
      p = false;
      exitg1 = true;
    } else {
      npages++;
    }
  }

  if (p) {
    overflow = true;
  }

  if (!overflow) {
    emlrtErrorWithMessageIdR2012b(&b_st, &q_emlrtRTEI,
      "MATLAB:sub2ind:SubscriptVectorSize", 0);
  }

  c_st.site = &w_emlrtRSI;
  if (!allinrange(areasNorm, siz[1])) {
    emlrtErrorWithMessageIdR2012b(&b_st, &p_emlrtRTEI,
      "MATLAB:sub2ind:IndexOutOfRange", 0);
  }

  iy = frameIndices->size[0] * frameIndices->size[1];
  emxEnsureCapacity(&st, (emxArray__common *)frameIndices, iy, sizeof(real_T),
                    &emlrtRTEI);
  nm1d2 = frameIndices->size[0];
  npages = frameIndices->size[1];
  npages *= nm1d2;
  for (iy = 0; iy < npages; iy++) {
    frameIndices->data[iy] = (int32_T)frameIndices->data[iy] + siz[0] *
      ((int32_T)areasNorm->data[iy] - 1);
  }

  st.site = &f_emlrtRSI;
  indexShapeCheck(&st, *(int32_T (*)[2])frame->size, *(int32_T (*)[2])
                  frameIndices->size);
  nm1d2 = frame->size[0] * frame->size[1];
  npages = frameIndices->size[0] * frameIndices->size[1];
  for (iy = 0; iy < npages; iy++) {
    i2 = (int32_T)frameIndices->data[iy];
    if (!((i2 >= 1) && (i2 <= nm1d2))) {
      emlrtDynamicBoundsCheckR2012b(i2, 1, nm1d2, &fb_emlrtBCI, sp);
    }
  }

  emxInit_boolean_T(sp, &rayRejectVals, 2, &h_emlrtRTEI, true);
  st.site = &g_emlrtRSI;
  indexShapeCheck(&st, *(int32_T (*)[2])rayRejectionMap->size, *(int32_T (*)[2])
                  frameIndices->size);
  iy = rayRejectVals->size[0] * rayRejectVals->size[1];
  rayRejectVals->size[0] = frameIndices->size[0];
  rayRejectVals->size[1] = frameIndices->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)rayRejectVals, iy, sizeof(boolean_T),
                    &emlrtRTEI);
  nm1d2 = rayRejectionMap->size[0] * rayRejectionMap->size[1];
  npages = frameIndices->size[0] * frameIndices->size[1];
  for (iy = 0; iy < npages; iy++) {
    i2 = (int32_T)frameIndices->data[iy];
    if (!((i2 >= 1) && (i2 <= nm1d2))) {
      emlrtDynamicBoundsCheckR2012b(i2, 1, nm1d2, &gb_emlrtBCI, sp);
    }

    rayRejectVals->data[iy] = rayRejectionMap->data[i2 - 1];
  }

  st.site = &h_emlrtRSI;
  b_st.site = &bb_emlrtRSI;
  overflow = false;
  p = false;
  if ((frameIndices->size[0] != 0) || (frameIndices->size[1] != 0)) {
  } else {
    p = true;
  }

  if (p) {
    overflow = true;
  }

  if (overflow) {
    emlrtErrorWithMessageIdR2012b(&b_st, &o_emlrtRTEI,
      "Coder:toolbox:eml_all_or_any_specialEmpty", 0);
  }

  if (((frameIndices->size[0] == 1) && (frameIndices->size[1] == 1)) ||
      (frameIndices->size[0] != 1)) {
    overflow = true;
  } else {
    overflow = false;
  }

  if (!overflow) {
    emlrtErrorWithMessageIdR2012b(&b_st, &n_emlrtRTEI,
      "Coder:toolbox:eml_all_or_any_autoDimIncompatibility", 0);
  }

  for (iy = 0; iy < 2; iy++) {
    outsize[iy] = (uint32_T)frameIndices->size[iy];
  }

  emxInit_boolean_T(&b_st, &d_x, 2, &emlrtRTEI, true);
  iy = d_x->size[0] * d_x->size[1];
  d_x->size[0] = 1;
  d_x->size[1] = (int32_T)outsize[1];
  emxEnsureCapacity(&b_st, (emxArray__common *)d_x, iy, sizeof(boolean_T),
                    &emlrtRTEI);
  npages = (int32_T)outsize[1];
  for (iy = 0; iy < npages; iy++) {
    d_x->data[iy] = true;
  }

  nm1d2 = frameIndices->size[0];
  npages = frameIndices->size[1];
  i2 = 0;
  iy = -1;
  c_st.site = &cb_emlrtRSI;
  overflow = ((!(1 > frameIndices->size[1])) && (frameIndices->size[1] >
    2147483646));
  if (overflow) {
    d_st.site = &n_emlrtRSI;
    check_forloop_overflow_error(&d_st);
  }

  for (i = 1; i <= npages; i++) {
    i1 = i2 + 1;
    i2 += nm1d2;
    iy++;
    c_st.site = &db_emlrtRSI;
    if ((!(i1 > i2)) && (i2 > 2147483646)) {
      d_st.site = &n_emlrtRSI;
      check_forloop_overflow_error(&d_st);
    }

    exitg1 = false;
    while ((!exitg1) && (i1 <= i2)) {
      if (!rayRejectVals->data[i1 - 1]) {
        d_x->data[iy] = false;
        exitg1 = true;
      } else {
        i1++;
      }
    }
  }

  st.site = &h_emlrtRSI;
  b_st.site = &bb_emlrtRSI;
  if ((d_x->size[1] == 1) || (d_x->size[1] != 1)) {
    overflow = true;
  } else {
    overflow = false;
  }

  if (!overflow) {
    emlrtErrorWithMessageIdR2012b(&b_st, &n_emlrtRTEI,
      "Coder:toolbox:eml_all_or_any_autoDimIncompatibility", 0);
  }

  *isRejected = true;
  c_st.site = &db_emlrtRSI;
  overflow = ((!(1 > d_x->size[1])) && (d_x->size[1] > 2147483646));
  if (overflow) {
    d_st.site = &n_emlrtRSI;
    check_forloop_overflow_error(&d_st);
  }

  nm1d2 = 1;
  exitg1 = false;
  while ((!exitg1) && (nm1d2 <= d_x->size[1])) {
    if (!d_x->data[nm1d2 - 1]) {
      *isRejected = false;
      exitg1 = true;
    } else {
      nm1d2++;
    }
  }

  emxFree_boolean_T(&d_x);
  iy = rayRejectVals->size[0] * rayRejectVals->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)rayRejectVals, iy, sizeof(boolean_T),
                    &emlrtRTEI);
  nm1d2 = rayRejectVals->size[0];
  npages = rayRejectVals->size[1];
  npages *= nm1d2;
  for (iy = 0; iy < npages; iy++) {
    rayRejectVals->data[iy] = !rayRejectVals->data[iy];
  }

  for (iy = 0; iy < 2; iy++) {
    b_areas[iy] = areas->size[iy];
    siz[iy] = rayRejectVals->size[iy];
  }

  if ((b_areas[0] != siz[0]) || (b_areas[1] != siz[1])) {
    emlrtSizeEqCheckNDR2012b(&b_areas[0], &siz[0], &b_emlrtECI, sp);
  }

  iy = areas->size[0] * areas->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)areas, iy, sizeof(real_T),
                    &emlrtRTEI);
  nm1d2 = areas->size[0];
  npages = areas->size[1];
  npages *= nm1d2;
  for (iy = 0; iy < npages; iy++) {
    areas->data[iy] *= (real_T)rayRejectVals->data[iy];
  }

  emxFree_boolean_T(&rayRejectVals);
  st.site = &i_emlrtRSI;
  sum(&st, areas, xIndices);
  st.site = &i_emlrtRSI;
  ndbl = b_sum(&st, xIndices);
  rdivide(sp, areas, ndbl, areasNorm);
  emxFree_real_T(&areas);
  for (iy = 0; iy < 2; iy++) {
    siz[iy] = frameIndices->size[iy];
    b_areasNorm[iy] = areasNorm->size[iy];
  }

  emxInit_real_T(sp, &b_frame, 2, &emlrtRTEI, true);
  if ((siz[0] != b_areasNorm[0]) || (siz[1] != b_areasNorm[1])) {
    emlrtSizeEqCheckNDR2012b(&siz[0], &b_areasNorm[0], &emlrtECI, sp);
  }

  iy = b_frame->size[0] * b_frame->size[1];
  b_frame->size[0] = frameIndices->size[0];
  b_frame->size[1] = frameIndices->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)b_frame, iy, sizeof(real_T),
                    &emlrtRTEI);
  npages = frameIndices->size[0] * frameIndices->size[1];
  for (iy = 0; iy < npages; iy++) {
    b_frame->data[iy] = frame->data[(int32_T)frameIndices->data[iy] - 1] *
      areasNorm->data[iy];
  }

  emxFree_real_T(&areasNorm);
  emxFree_real_T(&frameIndices);
  st.site = &j_emlrtRSI;
  sum(&st, b_frame, xIndices);
  st.site = &j_emlrtRSI;
  *value = b_sum(&st, xIndices);
  emxFree_real_T(&b_frame);
  emxFree_real_T(&xIndices);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (interpolateFrameForIndex.c) */
