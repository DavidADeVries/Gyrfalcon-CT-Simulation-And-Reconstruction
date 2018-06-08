/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * minimizeTV2.cpp
 *
 * Code generation for function 'minimizeTV2'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "minimizeTV2.h"
#include "minimizeTV2_emxutil.h"
#include "error.h"
#include "eml_int_forloop_overflow_check.h"
#include "power.h"
#include "rdivide.h"
#include "sqrt.h"
#include "minimizeTV2_data.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 3,     /* lineNo */
  "minimizeTV2",                       /* fcnName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pathName */
};

static emlrtRSInfo b_emlrtRSI = { 5,   /* lineNo */
  "minimizeTV2",                       /* fcnName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pathName */
};

static emlrtRSInfo c_emlrtRSI = { 24,  /* lineNo */
  "minimizeTV2",                       /* fcnName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pathName */
};

static emlrtRSInfo d_emlrtRSI = { 23,  /* lineNo */
  "minimizeTV2",                       /* fcnName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pathName */
};

static emlrtRSInfo e_emlrtRSI = { 25,  /* lineNo */
  "minimizeTV2",                       /* fcnName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pathName */
};

static emlrtRSInfo f_emlrtRSI = { 26,  /* lineNo */
  "minimizeTV2",                       /* fcnName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pathName */
};

static emlrtRSInfo g_emlrtRSI = { 27,  /* lineNo */
  "minimizeTV2",                       /* fcnName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pathName */
};

static emlrtRSInfo p_emlrtRSI = { 9,   /* lineNo */
  "sum",                               /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\sum.m"/* pathName */
};

static emlrtRSInfo q_emlrtRSI = { 58,  /* lineNo */
  "sumprod",                           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\private\\sumprod.m"/* pathName */
};

static emlrtRSInfo r_emlrtRSI = { 83,  /* lineNo */
  "combine_vector_elements",           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\private\\combine_vector_elements.m"/* pathName */
};

static emlrtRSInfo s_emlrtRSI = { 107, /* lineNo */
  "combine_vector_elements",           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\private\\combine_vector_elements.m"/* pathName */
};

static emlrtRSInfo t_emlrtRSI = { 110, /* lineNo */
  "combine_vector_elements",           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\private\\combine_vector_elements.m"/* pathName */
};

static emlrtRSInfo u_emlrtRSI = { 121, /* lineNo */
  "combine_vector_elements",           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\private\\combine_vector_elements.m"/* pathName */
};

static emlrtRSInfo w_emlrtRSI = { 77,  /* lineNo */
  "combine_vector_elements",           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\private\\combine_vector_elements.m"/* pathName */
};

static emlrtRTEInfo emlrtRTEI = { 1,   /* lineNo */
  15,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtRTEInfo b_emlrtRTEI = { 11,/* lineNo */
  19,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtRTEInfo c_emlrtRTEI = { 18,/* lineNo */
  5,                                   /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtRTEInfo d_emlrtRTEI = { 19,/* lineNo */
  5,                                   /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtRTEInfo e_emlrtRTEI = { 20,/* lineNo */
  5,                                   /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtRTEInfo i_emlrtRTEI = { 3, /* lineNo */
  9,                                   /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo emlrtECI = { 3,     /* nDims */
  23,                                  /* lineNo */
  12,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo b_emlrtECI = { 3,   /* nDims */
  23,                                  /* lineNo */
  38,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo c_emlrtECI = { 3,   /* nDims */
  23,                                  /* lineNo */
  11,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo d_emlrtECI = { 3,   /* nDims */
  23,                                  /* lineNo */
  64,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo e_emlrtECI = { 3,   /* nDims */
  24,                                  /* lineNo */
  21,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo f_emlrtECI = { 3,   /* nDims */
  24,                                  /* lineNo */
  50,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo g_emlrtECI = { 3,   /* nDims */
  24,                                  /* lineNo */
  15,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo h_emlrtECI = { 3,   /* nDims */
  24,                                  /* lineNo */
  79,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo i_emlrtECI = { 3,   /* nDims */
  25,                                  /* lineNo */
  12,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo j_emlrtECI = { 3,   /* nDims */
  25,                                  /* lineNo */
  46,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo k_emlrtECI = { 3,   /* nDims */
  25,                                  /* lineNo */
  73,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo l_emlrtECI = { 3,   /* nDims */
  25,                                  /* lineNo */
  41,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo m_emlrtECI = { 3,   /* nDims */
  25,                                  /* lineNo */
  104,                                 /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo n_emlrtECI = { 3,   /* nDims */
  23,                                  /* lineNo */
  9,                                   /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo o_emlrtECI = { 3,   /* nDims */
  26,                                  /* lineNo */
  12,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo p_emlrtECI = { 3,   /* nDims */
  26,                                  /* lineNo */
  46,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo q_emlrtECI = { 3,   /* nDims */
  26,                                  /* lineNo */
  73,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo r_emlrtECI = { 3,   /* nDims */
  26,                                  /* lineNo */
  41,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo s_emlrtECI = { 3,   /* nDims */
  26,                                  /* lineNo */
  104,                                 /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo t_emlrtECI = { 3,   /* nDims */
  27,                                  /* lineNo */
  12,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo u_emlrtECI = { 3,   /* nDims */
  27,                                  /* lineNo */
  46,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo v_emlrtECI = { 3,   /* nDims */
  27,                                  /* lineNo */
  73,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo w_emlrtECI = { 3,   /* nDims */
  27,                                  /* lineNo */
  41,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtECInfo x_emlrtECI = { 3,   /* nDims */
  27,                                  /* lineNo */
  104,                                 /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtBCInfo emlrtBCI = { -1,    /* iFirst */
  -1,                                  /* iLast */
  22,                                  /* lineNo */
  12,                                  /* colNo */
  "f_grad",                            /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo b_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  22,                                  /* lineNo */
  14,                                  /* colNo */
  "f_grad",                            /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo c_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  22,                                  /* lineNo */
  21,                                  /* colNo */
  "f_grad",                            /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo d_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  22,                                  /* lineNo */
  23,                                  /* colNo */
  "f_grad",                            /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo e_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  22,                                  /* lineNo */
  30,                                  /* colNo */
  "f_grad",                            /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo f_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  22,                                  /* lineNo */
  32,                                  /* colNo */
  "f_grad",                            /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo y_emlrtECI = { -1,  /* nDims */
  22,                                  /* lineNo */
  5,                                   /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtBCInfo g_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  14,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo h_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  16,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo i_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  18,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo j_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  25,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo k_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  29,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo l_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  31,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo m_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  40,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo n_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  42,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo o_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  44,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo p_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  51,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo q_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  53,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo r_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  57,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo s_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  66,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo t_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  68,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo u_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  70,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo v_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  77,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo w_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  79,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo x_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  81,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo y_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  23,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ab_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  25,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo bb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  27,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo cb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  34,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo db_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  38,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo eb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  40,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo fb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  52,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo gb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  54,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo hb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  56,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ib_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  63,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo jb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  65,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo kb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  69,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo lb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  81,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo mb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  83,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo nb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  85,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ob_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  92,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo pb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  94,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo qb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  96,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo rb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  14,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo sb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  18,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo tb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  20,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ub_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  25,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo vb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  27,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo wb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  29,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo xb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  48,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo yb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  52,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ac_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  54,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo bc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  59,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo cc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  61,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo dc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  63,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ec_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  75,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo fc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  79,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo gc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  81,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo hc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  86,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ic_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  90,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo jc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  94,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo kc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  106,                                 /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo lc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  110,                                 /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo mc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  112,                                 /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo nc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  117,                                 /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo oc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  121,                                 /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo pc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  123,                                 /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo qc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  14,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo rc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  16,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo sc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  20,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo tc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  25,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo uc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  27,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo vc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  29,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo wc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  48,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo xc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  50,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo yc_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  54,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ad_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  59,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo bd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  61,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo cd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  63,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo dd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  75,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ed_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  77,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo fd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  81,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo gd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  86,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo hd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  90,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo id_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  94,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo jd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  106,                                 /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo kd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  108,                                 /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ld_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  112,                                 /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo md_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  117,                                 /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo nd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  119,                                 /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo od_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  123,                                 /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo pd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  14,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo qd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  16,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo rd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  18,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo sd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  25,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo td_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  27,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ud_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  29,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo vd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  48,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo wd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  50,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo xd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  52,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo yd_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  59,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ae_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  61,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo be_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  63,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ce_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  75,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo de_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  77,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ee_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  79,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo fe_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  86,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ge_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  90,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo he_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  92,                                  /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ie_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  106,                                 /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo je_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  108,                                 /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ke_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  110,                                 /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo le_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  117,                                 /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo me_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  119,                                 /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ne_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  123,                                 /* colNo */
  "f",                                 /* aName */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo n_emlrtRTEI = { 20,/* lineNo */
  15,                                  /* colNo */
  "sumprod",                           /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\private\\sumprod.m"/* pName */
};

static emlrtRTEInfo o_emlrtRTEI = { 48,/* lineNo */
  9,                                   /* colNo */
  "sumprod",                           /* fName */
  "C:\\Program Files\\MATLAB\\R2017a\\toolbox\\eml\\lib\\matlab\\datafun\\private\\sumprod.m"/* pName */
};

static emlrtECInfo ab_emlrtECI = { 3,  /* nDims */
  7,                                   /* lineNo */
  13,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

static emlrtRTEInfo p_emlrtRTEI = { 2, /* lineNo */
  11,                                  /* colNo */
  "minimizeTV2",                       /* fName */
  "E:\\Data Files\\Git Repos\\Gyrfalcon-CT-Simulation-And-Reconstruction\\Tigre Test Bed\\minimizeTV2.m"/* pName */
};

/* Function Declarations */
static void tvGradient(const emlrtStack *sp, const emxArray_real32_T *f,
  emxArray_real_T *f_grad);

/* Function Definitions */
static void tvGradient(const emlrtStack *sp, const emxArray_real32_T *f,
  emxArray_real_T *f_grad)
{
  int32_T i0;
  uint32_T dims[3];
  int32_T loop_ub;
  emxArray_int32_T *s;
  emxArray_int32_T *t;
  emxArray_int32_T *u;
  emxArray_real32_T *r0;
  int32_T b_f;
  int32_T c_f;
  int32_T d_f;
  emxArray_real32_T *r1;
  int32_T b_loop_ub;
  int32_T i1;
  int32_T c_loop_ub;
  int32_T i2;
  int32_T i3;
  int32_T i4;
  emxArray_int32_T *b_s;
  int32_T i5;
  emxArray_int32_T *b_t;
  emxArray_int32_T *b_u;
  emxArray_int32_T *c_s;
  int32_T d_s[3];
  emxArray_int32_T *c_t;
  emxArray_int32_T *c_u;
  emxArray_real32_T *r2;
  int32_T e_s[3];
  emxArray_real32_T *r3;
  emxArray_int32_T *f_s;
  emxArray_int32_T *d_t;
  emxArray_int32_T *d_u;
  emxArray_int32_T *g_s;
  emxArray_int32_T *e_t;
  emxArray_int32_T *e_u;
  emxArray_int32_T *h_s;
  emxArray_int32_T *f_t;
  emxArray_int32_T *f_u;
  emxArray_int32_T *i_s;
  emxArray_int32_T *g_t;
  emxArray_int32_T *g_u;
  emxArray_real32_T *r4;
  emxArray_real32_T *r5;
  emxArray_int32_T *j_s;
  emxArray_int32_T *h_t;
  emxArray_int32_T *h_u;
  emxArray_int32_T *k_s;
  emxArray_int32_T *i_t;
  emxArray_int32_T *i_u;
  emxArray_int32_T *l_s;
  emxArray_int32_T *j_t;
  emxArray_int32_T *j_u;
  emxArray_int32_T *m_s;
  emxArray_int32_T *k_t;
  emxArray_int32_T *k_u;
  emxArray_real32_T *r6;
  emxArray_real32_T *r7;
  emxArray_int32_T *n_s;
  emxArray_int32_T *l_t;
  emxArray_int32_T *l_u;
  emxArray_int32_T *o_s;
  emxArray_int32_T *m_t;
  emxArray_int32_T *m_u;
  emxArray_real32_T *r8;
  emxArray_real32_T *r9;
  emxArray_int32_T *p_s;
  emxArray_int32_T *n_t;
  emxArray_int32_T *n_u;
  emxArray_int32_T *q_s;
  emxArray_int32_T *o_t;
  emxArray_int32_T *o_u;
  emxArray_real32_T *r10;
  emxArray_real32_T *r11;
  emxArray_int32_T *r_s;
  emxArray_int32_T *p_t;
  emxArray_int32_T *p_u;
  emxArray_int32_T *s_s;
  emxArray_int32_T *q_t;
  emxArray_int32_T *q_u;
  emxArray_real32_T *r12;
  emxArray_real32_T *r13;
  emxArray_int32_T *t_s;
  emxArray_int32_T *r_t;
  emxArray_int32_T *r_u;
  emxArray_int32_T *u_s;
  emxArray_int32_T *s_t;
  emxArray_int32_T *s_u;
  emxArray_real32_T *r14;
  emxArray_real32_T *r15;
  emxArray_int32_T *v_s;
  emxArray_int32_T *t_t;
  emxArray_int32_T *t_u;
  emxArray_int32_T *w_s;
  emxArray_int32_T *u_t;
  emxArray_int32_T *u_u;
  emxArray_real32_T *r16;
  emxArray_real32_T *r17;
  emxArray_int32_T *x_s;
  emxArray_int32_T *v_t;
  emxArray_int32_T *v_u;
  emxArray_int32_T *y_s;
  emxArray_int32_T *w_t;
  emxArray_int32_T *w_u;
  emxArray_real32_T *r18;
  emxArray_real32_T *r19;
  emxArray_int32_T *ab_s;
  emxArray_int32_T *x_t;
  emxArray_int32_T *x_u;
  emxArray_int32_T *bb_s;
  emxArray_int32_T *y_t;
  emxArray_int32_T *y_u;
  emxArray_real32_T *r20;
  emxArray_real32_T *r21;
  emxArray_real32_T *r22;
  emxArray_int32_T *cb_s;
  emxArray_int32_T *ab_t;
  emxArray_int32_T *ab_u;
  emxArray_int32_T *db_s;
  emxArray_int32_T *bb_t;
  emxArray_int32_T *bb_u;
  emxArray_int32_T *eb_s;
  emxArray_int32_T *cb_t;
  emxArray_int32_T *cb_u;
  emxArray_int32_T *fb_s;
  emxArray_int32_T *db_t;
  emxArray_int32_T *db_u;
  emxArray_int32_T *gb_s;
  emxArray_int32_T *eb_t;
  emxArray_int32_T *eb_u;
  emxArray_int32_T *hb_s;
  emxArray_int32_T *fb_t;
  emxArray_int32_T *fb_u;
  emxArray_real32_T *r23;
  emxArray_real32_T *r24;
  emxArray_int32_T *ib_s;
  emxArray_int32_T *gb_t;
  emxArray_int32_T *gb_u;
  emxArray_int32_T *jb_s;
  emxArray_int32_T *hb_t;
  emxArray_int32_T *hb_u;
  emxArray_real32_T *r25;
  emxArray_real32_T *r26;
  emxArray_int32_T *kb_s;
  emxArray_int32_T *ib_t;
  emxArray_int32_T *ib_u;
  emxArray_int32_T *lb_s;
  emxArray_int32_T *jb_t;
  emxArray_int32_T *jb_u;
  emxArray_int32_T *mb_s;
  emxArray_int32_T *kb_t;
  emxArray_int32_T *kb_u;
  emxArray_int32_T *nb_s;
  emxArray_int32_T *lb_t;
  emxArray_int32_T *lb_u;
  emxArray_int32_T *ob_s;
  emxArray_int32_T *mb_t;
  emxArray_int32_T *mb_u;
  emxArray_int32_T *pb_s;
  emxArray_int32_T *nb_t;
  emxArray_int32_T *nb_u;
  emxArray_real32_T *r27;
  emxArray_real32_T *r28;
  emxArray_int32_T *qb_s;
  emxArray_int32_T *ob_t;
  emxArray_int32_T *ob_u;
  emxArray_int32_T *rb_s;
  emxArray_int32_T *pb_t;
  emxArray_int32_T *pb_u;
  emxArray_real32_T *r29;
  emxArray_real32_T *r30;
  emxArray_int32_T *r31;
  emxArray_int32_T *r32;
  emxArray_int32_T *r33;
  emxArray_real_T *r34;
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  for (i0 = 0; i0 < 3; i0++) {
    dims[i0] = (uint32_T)f->size[i0];
  }

  i0 = f_grad->size[0] * f_grad->size[1] * f_grad->size[2];
  f_grad->size[0] = (int32_T)dims[0];
  f_grad->size[1] = (int32_T)dims[1];
  f_grad->size[2] = (int32_T)dims[2];
  emxEnsureCapacity(sp, (emxArray__common *)f_grad, i0, sizeof(real_T),
                    &b_emlrtRTEI);
  loop_ub = (int32_T)dims[0] * (int32_T)dims[1] * (int32_T)dims[2];
  for (i0 = 0; i0 < loop_ub; i0++) {
    f_grad->data[i0] = 0.0;
  }

  emxInit_int32_T(sp, &s, 2, &c_emlrtRTEI, true);
  if ((int32_T)dims[0] - 1 < 2) {
    i0 = s->size[0] * s->size[1];
    s->size[0] = 1;
    s->size[1] = 0;
    emxEnsureCapacity(sp, (emxArray__common *)s, i0, sizeof(int32_T),
                      &b_emlrtRTEI);
  } else {
    loop_ub = (int32_T)dims[0] - 3;
    i0 = s->size[0] * s->size[1];
    s->size[0] = 1;
    s->size[1] = (int32_T)dims[0] - 2;
    emxEnsureCapacity(sp, (emxArray__common *)s, i0, sizeof(int32_T),
                      &b_emlrtRTEI);
    for (i0 = 0; i0 <= loop_ub; i0++) {
      s->data[s->size[0] * i0] = 2 + i0;
    }
  }

  emxInit_int32_T(sp, &t, 2, &d_emlrtRTEI, true);
  if ((int32_T)dims[1] - 1 < 2) {
    i0 = t->size[0] * t->size[1];
    t->size[0] = 1;
    t->size[1] = 0;
    emxEnsureCapacity(sp, (emxArray__common *)t, i0, sizeof(int32_T),
                      &b_emlrtRTEI);
  } else {
    loop_ub = (int32_T)dims[1] - 3;
    i0 = t->size[0] * t->size[1];
    t->size[0] = 1;
    t->size[1] = (int32_T)dims[1] - 2;
    emxEnsureCapacity(sp, (emxArray__common *)t, i0, sizeof(int32_T),
                      &b_emlrtRTEI);
    for (i0 = 0; i0 <= loop_ub; i0++) {
      t->data[t->size[0] * i0] = 2 + i0;
    }
  }

  emxInit_int32_T(sp, &u, 2, &e_emlrtRTEI, true);
  if ((int32_T)dims[2] - 1 < 2) {
    i0 = u->size[0] * u->size[1];
    u->size[0] = 1;
    u->size[1] = 0;
    emxEnsureCapacity(sp, (emxArray__common *)u, i0, sizeof(int32_T),
                      &b_emlrtRTEI);
  } else {
    loop_ub = (int32_T)dims[2] - 3;
    i0 = u->size[0] * u->size[1];
    u->size[0] = 1;
    u->size[1] = (int32_T)dims[2] - 2;
    emxEnsureCapacity(sp, (emxArray__common *)u, i0, sizeof(int32_T),
                      &b_emlrtRTEI);
    for (i0 = 0; i0 <= loop_ub; i0++) {
      u->data[u->size[0] * i0] = 2 + i0;
    }
  }

  emxInit_real32_T(sp, &r0, 3, &b_emlrtRTEI, true);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r0->size[0] * r0->size[1] * r0->size[2];
  r0->size[0] = s->size[1];
  r0->size[1] = t->size[1];
  r0->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r0, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&g_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&h_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&i_emlrtBCI,
            sp);
        }

        r0->data[(i2 + r0->size[0] * i1) + r0->size[0] * r0->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_real32_T(sp, &r1, 3, &b_emlrtRTEI, true);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r1->size[0] * r1->size[1] * r1->size[2];
  r1->size[0] = s->size[1];
  r1->size[1] = t->size[1];
  r1->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r1, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2] - 1;
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&j_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&k_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&l_emlrtBCI,
            sp);
        }

        r1->data[(i2 + r1->size[0] * i1) + r1->size[0] * r1->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_int32_T1(sp, &b_s, 1, &b_emlrtRTEI, true);
  i0 = b_s->size[0];
  b_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)b_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &b_t, 1, &b_emlrtRTEI, true);
  i0 = b_t->size[0];
  b_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)b_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &b_u, 1, &b_emlrtRTEI, true);
  i0 = b_u->size[0];
  b_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)b_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &c_s, 1, &b_emlrtRTEI, true);
  d_s[0] = b_s->size[0];
  d_s[1] = b_t->size[0];
  d_s[2] = b_u->size[0];
  i0 = c_s->size[0];
  c_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)c_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&b_u);
  emxFree_int32_T(&b_t);
  emxFree_int32_T(&b_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    c_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &c_t, 1, &b_emlrtRTEI, true);
  i0 = c_t->size[0];
  c_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)c_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    c_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &c_u, 1, &b_emlrtRTEI, true);
  i0 = c_u->size[0];
  c_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)c_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    c_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_real32_T(sp, &r2, 3, &b_emlrtRTEI, true);
  e_s[0] = c_s->size[0];
  e_s[1] = c_t->size[0];
  e_s[2] = c_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&emlrtECI, sp);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r2->size[0] * r2->size[1] * r2->size[2];
  r2->size[0] = s->size[1];
  r2->size[1] = t->size[1];
  r2->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r2, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  emxFree_int32_T(&c_u);
  emxFree_int32_T(&c_t);
  emxFree_int32_T(&c_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&m_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&n_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&o_emlrtBCI,
            sp);
        }

        r2->data[(i2 + r2->size[0] * i1) + r2->size[0] * r2->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_real32_T(sp, &r3, 3, &b_emlrtRTEI, true);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r3->size[0] * r3->size[1] * r3->size[2];
  r3->size[0] = s->size[1];
  r3->size[1] = t->size[1];
  r3->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r3, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&p_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1] - 1;
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&q_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&r_emlrtBCI,
            sp);
        }

        r3->data[(i2 + r3->size[0] * i1) + r3->size[0] * r3->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_int32_T1(sp, &f_s, 1, &b_emlrtRTEI, true);
  i0 = f_s->size[0];
  f_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)f_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    f_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &d_t, 1, &b_emlrtRTEI, true);
  i0 = d_t->size[0];
  d_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)d_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    d_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &d_u, 1, &b_emlrtRTEI, true);
  i0 = d_u->size[0];
  d_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)d_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    d_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &g_s, 1, &b_emlrtRTEI, true);
  d_s[0] = f_s->size[0];
  d_s[1] = d_t->size[0];
  d_s[2] = d_u->size[0];
  i0 = g_s->size[0];
  g_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)g_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&d_u);
  emxFree_int32_T(&d_t);
  emxFree_int32_T(&f_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    g_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &e_t, 1, &b_emlrtRTEI, true);
  i0 = e_t->size[0];
  e_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)e_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    e_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &e_u, 1, &b_emlrtRTEI, true);
  i0 = e_u->size[0];
  e_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)e_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    e_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &h_s, 1, &b_emlrtRTEI, true);
  e_s[0] = g_s->size[0];
  e_s[1] = e_t->size[0];
  e_s[2] = e_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&b_emlrtECI, sp);
  i0 = h_s->size[0];
  h_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)h_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&e_u);
  emxFree_int32_T(&e_t);
  emxFree_int32_T(&g_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    h_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &f_t, 1, &b_emlrtRTEI, true);
  i0 = f_t->size[0];
  f_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)f_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    f_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &f_u, 1, &b_emlrtRTEI, true);
  i0 = f_u->size[0];
  f_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)f_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    f_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &i_s, 1, &b_emlrtRTEI, true);
  d_s[0] = h_s->size[0];
  d_s[1] = f_t->size[0];
  d_s[2] = f_u->size[0];
  i0 = i_s->size[0];
  i_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)i_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&f_u);
  emxFree_int32_T(&f_t);
  emxFree_int32_T(&h_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    i_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &g_t, 1, &b_emlrtRTEI, true);
  i0 = g_t->size[0];
  g_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)g_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    g_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &g_u, 1, &b_emlrtRTEI, true);
  i0 = g_u->size[0];
  g_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)g_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    g_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_real32_T(sp, &r4, 3, &b_emlrtRTEI, true);
  e_s[0] = i_s->size[0];
  e_s[1] = g_t->size[0];
  e_s[2] = g_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&c_emlrtECI, sp);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r4->size[0] * r4->size[1] * r4->size[2];
  r4->size[0] = s->size[1];
  r4->size[1] = t->size[1];
  r4->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r4, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  emxFree_int32_T(&g_u);
  emxFree_int32_T(&g_t);
  emxFree_int32_T(&i_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&s_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&t_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&u_emlrtBCI,
            sp);
        }

        r4->data[(i2 + r4->size[0] * i1) + r4->size[0] * r4->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_real32_T(sp, &r5, 3, &b_emlrtRTEI, true);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r5->size[0] * r5->size[1] * r5->size[2];
  r5->size[0] = s->size[1];
  r5->size[1] = t->size[1];
  r5->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r5, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&v_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&w_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0] - 1;
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&x_emlrtBCI,
            sp);
        }

        r5->data[(i2 + r5->size[0] * i1) + r5->size[0] * r5->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_int32_T1(sp, &j_s, 1, &b_emlrtRTEI, true);
  i0 = j_s->size[0];
  j_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)j_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    j_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &h_t, 1, &b_emlrtRTEI, true);
  i0 = h_t->size[0];
  h_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)h_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    h_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &h_u, 1, &b_emlrtRTEI, true);
  i0 = h_u->size[0];
  h_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)h_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    h_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &k_s, 1, &b_emlrtRTEI, true);
  d_s[0] = j_s->size[0];
  d_s[1] = h_t->size[0];
  d_s[2] = h_u->size[0];
  i0 = k_s->size[0];
  k_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)k_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&h_u);
  emxFree_int32_T(&h_t);
  emxFree_int32_T(&j_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    k_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &i_t, 1, &b_emlrtRTEI, true);
  i0 = i_t->size[0];
  i_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)i_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    i_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &i_u, 1, &b_emlrtRTEI, true);
  i0 = i_u->size[0];
  i_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)i_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    i_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &l_s, 1, &b_emlrtRTEI, true);
  e_s[0] = k_s->size[0];
  e_s[1] = i_t->size[0];
  e_s[2] = i_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&d_emlrtECI, sp);
  i0 = l_s->size[0];
  l_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)l_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&i_u);
  emxFree_int32_T(&i_t);
  emxFree_int32_T(&k_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    l_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &j_t, 1, &b_emlrtRTEI, true);
  i0 = j_t->size[0];
  j_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)j_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    j_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &j_u, 1, &b_emlrtRTEI, true);
  i0 = j_u->size[0];
  j_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)j_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    j_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &m_s, 1, &b_emlrtRTEI, true);
  d_s[0] = l_s->size[0];
  d_s[1] = j_t->size[0];
  d_s[2] = j_u->size[0];
  i0 = m_s->size[0];
  m_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)m_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&j_u);
  emxFree_int32_T(&j_t);
  emxFree_int32_T(&l_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    m_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &k_t, 1, &b_emlrtRTEI, true);
  i0 = k_t->size[0];
  k_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)k_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    k_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &k_u, 1, &b_emlrtRTEI, true);
  i0 = k_u->size[0];
  k_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)k_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    k_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_real32_T(sp, &r6, 3, &b_emlrtRTEI, true);
  e_s[0] = m_s->size[0];
  e_s[1] = k_t->size[0];
  e_s[2] = k_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&c_emlrtECI, sp);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r6->size[0] * r6->size[1] * r6->size[2];
  r6->size[0] = s->size[1];
  r6->size[1] = t->size[1];
  r6->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r6, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  emxFree_int32_T(&k_u);
  emxFree_int32_T(&k_t);
  emxFree_int32_T(&m_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&y_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&ab_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&bb_emlrtBCI,
            sp);
        }

        r6->data[(i2 + r6->size[0] * i1) + r6->size[0] * r6->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_real32_T(sp, &r7, 3, &b_emlrtRTEI, true);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r7->size[0] * r7->size[1] * r7->size[2];
  r7->size[0] = s->size[1];
  r7->size[1] = t->size[1];
  r7->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r7, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2] - 1;
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&cb_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&db_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&eb_emlrtBCI,
            sp);
        }

        r7->data[(i2 + r7->size[0] * i1) + r7->size[0] * r7->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_int32_T1(sp, &n_s, 1, &b_emlrtRTEI, true);
  i0 = n_s->size[0];
  n_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)n_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    n_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &l_t, 1, &b_emlrtRTEI, true);
  i0 = l_t->size[0];
  l_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)l_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    l_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &l_u, 1, &b_emlrtRTEI, true);
  i0 = l_u->size[0];
  l_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)l_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    l_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &o_s, 1, &b_emlrtRTEI, true);
  d_s[0] = n_s->size[0];
  d_s[1] = l_t->size[0];
  d_s[2] = l_u->size[0];
  i0 = o_s->size[0];
  o_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)o_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&l_u);
  emxFree_int32_T(&l_t);
  emxFree_int32_T(&n_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    o_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &m_t, 1, &b_emlrtRTEI, true);
  i0 = m_t->size[0];
  m_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)m_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    m_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &m_u, 1, &b_emlrtRTEI, true);
  i0 = m_u->size[0];
  m_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)m_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    m_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_real32_T(sp, &r8, 3, &b_emlrtRTEI, true);
  e_s[0] = o_s->size[0];
  e_s[1] = m_t->size[0];
  e_s[2] = m_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&e_emlrtECI, sp);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r8->size[0] * r8->size[1] * r8->size[2];
  r8->size[0] = s->size[1];
  r8->size[1] = t->size[1];
  r8->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r8, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  emxFree_int32_T(&m_u);
  emxFree_int32_T(&m_t);
  emxFree_int32_T(&o_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&fb_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&gb_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&hb_emlrtBCI,
            sp);
        }

        r8->data[(i2 + r8->size[0] * i1) + r8->size[0] * r8->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_real32_T(sp, &r9, 3, &b_emlrtRTEI, true);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r9->size[0] * r9->size[1] * r9->size[2];
  r9->size[0] = s->size[1];
  r9->size[1] = t->size[1];
  r9->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r9, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&ib_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1] - 1;
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&jb_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&kb_emlrtBCI,
            sp);
        }

        r9->data[(i2 + r9->size[0] * i1) + r9->size[0] * r9->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_int32_T1(sp, &p_s, 1, &b_emlrtRTEI, true);
  i0 = p_s->size[0];
  p_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)p_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    p_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &n_t, 1, &b_emlrtRTEI, true);
  i0 = n_t->size[0];
  n_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)n_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    n_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &n_u, 1, &b_emlrtRTEI, true);
  i0 = n_u->size[0];
  n_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)n_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    n_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &q_s, 1, &b_emlrtRTEI, true);
  d_s[0] = p_s->size[0];
  d_s[1] = n_t->size[0];
  d_s[2] = n_u->size[0];
  i0 = q_s->size[0];
  q_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)q_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&n_u);
  emxFree_int32_T(&n_t);
  emxFree_int32_T(&p_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    q_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &o_t, 1, &b_emlrtRTEI, true);
  i0 = o_t->size[0];
  o_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)o_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    o_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &o_u, 1, &b_emlrtRTEI, true);
  i0 = o_u->size[0];
  o_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)o_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    o_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_real32_T(sp, &r10, 3, &b_emlrtRTEI, true);
  e_s[0] = q_s->size[0];
  e_s[1] = o_t->size[0];
  e_s[2] = o_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&f_emlrtECI, sp);
  i0 = r10->size[0] * r10->size[1] * r10->size[2];
  r10->size[0] = r6->size[0];
  r10->size[1] = r6->size[1];
  r10->size[2] = r6->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r10, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = r6->size[0] * r6->size[1] * r6->size[2];
  emxFree_int32_T(&o_u);
  emxFree_int32_T(&o_t);
  emxFree_int32_T(&q_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    r10->data[i0] = r6->data[i0] - r7->data[i0];
  }

  emxInit_real32_T(sp, &r11, 3, &b_emlrtRTEI, true);
  st.site = &c_emlrtRSI;
  power(&st, r10, r6);
  i0 = r11->size[0] * r11->size[1] * r11->size[2];
  r11->size[0] = r8->size[0];
  r11->size[1] = r8->size[1];
  r11->size[2] = r8->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r11, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = r8->size[0] * r8->size[1] * r8->size[2];
  emxFree_real32_T(&r10);
  for (i0 = 0; i0 < loop_ub; i0++) {
    r11->data[i0] = r8->data[i0] - r9->data[i0];
  }

  st.site = &c_emlrtRSI;
  power(&st, r11, r7);
  emxFree_real32_T(&r11);
  for (i0 = 0; i0 < 3; i0++) {
    d_s[i0] = r6->size[i0];
    e_s[i0] = r7->size[i0];
  }

  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&g_emlrtECI, sp);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r8->size[0] * r8->size[1] * r8->size[2];
  r8->size[0] = s->size[1];
  r8->size[1] = t->size[1];
  r8->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r8, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&lb_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&mb_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&nb_emlrtBCI,
            sp);
        }

        r8->data[(i2 + r8->size[0] * i1) + r8->size[0] * r8->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r9->size[0] * r9->size[1] * r9->size[2];
  r9->size[0] = s->size[1];
  r9->size[1] = t->size[1];
  r9->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r9, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&ob_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&pb_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0] - 1;
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&qb_emlrtBCI,
            sp);
        }

        r9->data[(i2 + r9->size[0] * i1) + r9->size[0] * r9->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_int32_T1(sp, &r_s, 1, &b_emlrtRTEI, true);
  i0 = r_s->size[0];
  r_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    r_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &p_t, 1, &b_emlrtRTEI, true);
  i0 = p_t->size[0];
  p_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)p_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    p_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &p_u, 1, &b_emlrtRTEI, true);
  i0 = p_u->size[0];
  p_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)p_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    p_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &s_s, 1, &b_emlrtRTEI, true);
  d_s[0] = r_s->size[0];
  d_s[1] = p_t->size[0];
  d_s[2] = p_u->size[0];
  i0 = s_s->size[0];
  s_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)s_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&p_u);
  emxFree_int32_T(&p_t);
  emxFree_int32_T(&r_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    s_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &q_t, 1, &b_emlrtRTEI, true);
  i0 = q_t->size[0];
  q_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)q_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    q_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &q_u, 1, &b_emlrtRTEI, true);
  i0 = q_u->size[0];
  q_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)q_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    q_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_real32_T(sp, &r12, 3, &b_emlrtRTEI, true);
  e_s[0] = s_s->size[0];
  e_s[1] = q_t->size[0];
  e_s[2] = q_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&h_emlrtECI, sp);
  i0 = r12->size[0] * r12->size[1] * r12->size[2];
  r12->size[0] = r8->size[0];
  r12->size[1] = r8->size[1];
  r12->size[2] = r8->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r12, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = r8->size[0] * r8->size[1] * r8->size[2];
  emxFree_int32_T(&q_u);
  emxFree_int32_T(&q_t);
  emxFree_int32_T(&s_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    r12->data[i0] = r8->data[i0] - r9->data[i0];
  }

  st.site = &c_emlrtRSI;
  power(&st, r12, r8);
  emxFree_real32_T(&r12);
  for (i0 = 0; i0 < 3; i0++) {
    d_s[i0] = r6->size[i0];
    e_s[i0] = r8->size[i0];
  }

  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&g_emlrtECI, sp);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r9->size[0] * r9->size[1] * r9->size[2];
  r9->size[0] = s->size[1];
  r9->size[1] = t->size[1];
  r9->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r9, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2] + 1;
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&rb_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&sb_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&tb_emlrtBCI,
            sp);
        }

        r9->data[(i2 + r9->size[0] * i1) + r9->size[0] * r9->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_real32_T(sp, &r13, 3, &b_emlrtRTEI, true);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r13->size[0] * r13->size[1] * r13->size[2];
  r13->size[0] = s->size[1];
  r13->size[1] = t->size[1];
  r13->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r13, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&ub_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&vb_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&wb_emlrtBCI,
            sp);
        }

        r13->data[(i2 + r13->size[0] * i1) + r13->size[0] * r13->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_int32_T1(sp, &t_s, 1, &b_emlrtRTEI, true);
  i0 = t_s->size[0];
  t_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)t_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    t_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &r_t, 1, &b_emlrtRTEI, true);
  i0 = r_t->size[0];
  r_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    r_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &r_u, 1, &b_emlrtRTEI, true);
  i0 = r_u->size[0];
  r_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    r_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &u_s, 1, &b_emlrtRTEI, true);
  d_s[0] = t_s->size[0];
  d_s[1] = r_t->size[0];
  d_s[2] = r_u->size[0];
  i0 = u_s->size[0];
  u_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)u_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&r_u);
  emxFree_int32_T(&r_t);
  emxFree_int32_T(&t_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    u_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &s_t, 1, &b_emlrtRTEI, true);
  i0 = s_t->size[0];
  s_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)s_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    s_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &s_u, 1, &b_emlrtRTEI, true);
  i0 = s_u->size[0];
  s_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)s_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    s_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_real32_T(sp, &r14, 3, &b_emlrtRTEI, true);
  e_s[0] = u_s->size[0];
  e_s[1] = s_t->size[0];
  e_s[2] = s_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&i_emlrtECI, sp);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r14->size[0] * r14->size[1] * r14->size[2];
  r14->size[0] = s->size[1];
  r14->size[1] = t->size[1];
  r14->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r14, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  emxFree_int32_T(&s_u);
  emxFree_int32_T(&s_t);
  emxFree_int32_T(&u_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2] + 1;
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&xb_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&yb_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&ac_emlrtBCI,
            sp);
        }

        r14->data[(i2 + r14->size[0] * i1) + r14->size[0] * r14->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_real32_T(sp, &r15, 3, &b_emlrtRTEI, true);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r15->size[0] * r15->size[1] * r15->size[2];
  r15->size[0] = s->size[1];
  r15->size[1] = t->size[1];
  r15->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r15, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&bc_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&cc_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&dc_emlrtBCI,
            sp);
        }

        r15->data[(i2 + r15->size[0] * i1) + r15->size[0] * r15->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_int32_T1(sp, &v_s, 1, &b_emlrtRTEI, true);
  i0 = v_s->size[0];
  v_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)v_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    v_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &t_t, 1, &b_emlrtRTEI, true);
  i0 = t_t->size[0];
  t_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)t_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    t_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &t_u, 1, &b_emlrtRTEI, true);
  i0 = t_u->size[0];
  t_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)t_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    t_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &w_s, 1, &b_emlrtRTEI, true);
  d_s[0] = v_s->size[0];
  d_s[1] = t_t->size[0];
  d_s[2] = t_u->size[0];
  i0 = w_s->size[0];
  w_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)w_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&t_u);
  emxFree_int32_T(&t_t);
  emxFree_int32_T(&v_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    w_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &u_t, 1, &b_emlrtRTEI, true);
  i0 = u_t->size[0];
  u_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)u_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    u_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &u_u, 1, &b_emlrtRTEI, true);
  i0 = u_u->size[0];
  u_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)u_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    u_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_real32_T(sp, &r16, 3, &b_emlrtRTEI, true);
  e_s[0] = w_s->size[0];
  e_s[1] = u_t->size[0];
  e_s[2] = u_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&j_emlrtECI, sp);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r16->size[0] * r16->size[1] * r16->size[2];
  r16->size[0] = s->size[1];
  r16->size[1] = t->size[1];
  r16->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r16, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  emxFree_int32_T(&u_u);
  emxFree_int32_T(&u_t);
  emxFree_int32_T(&w_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2] + 1;
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&ec_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&fc_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&gc_emlrtBCI,
            sp);
        }

        r16->data[(i2 + r16->size[0] * i1) + r16->size[0] * r16->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_real32_T(sp, &r17, 3, &b_emlrtRTEI, true);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r17->size[0] * r17->size[1] * r17->size[2];
  r17->size[0] = s->size[1];
  r17->size[1] = t->size[1];
  r17->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r17, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2] + 1;
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&hc_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1] - 1;
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&ic_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&jc_emlrtBCI,
            sp);
        }

        r17->data[(i2 + r17->size[0] * i1) + r17->size[0] * r17->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_int32_T1(sp, &x_s, 1, &b_emlrtRTEI, true);
  i0 = x_s->size[0];
  x_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)x_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    x_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &v_t, 1, &b_emlrtRTEI, true);
  i0 = v_t->size[0];
  v_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)v_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    v_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &v_u, 1, &b_emlrtRTEI, true);
  i0 = v_u->size[0];
  v_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)v_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    v_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &y_s, 1, &b_emlrtRTEI, true);
  d_s[0] = x_s->size[0];
  d_s[1] = v_t->size[0];
  d_s[2] = v_u->size[0];
  i0 = y_s->size[0];
  y_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)y_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&v_u);
  emxFree_int32_T(&v_t);
  emxFree_int32_T(&x_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    y_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &w_t, 1, &b_emlrtRTEI, true);
  i0 = w_t->size[0];
  w_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)w_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    w_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &w_u, 1, &b_emlrtRTEI, true);
  i0 = w_u->size[0];
  w_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)w_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    w_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_real32_T(sp, &r18, 3, &b_emlrtRTEI, true);
  e_s[0] = y_s->size[0];
  e_s[1] = w_t->size[0];
  e_s[2] = w_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&k_emlrtECI, sp);
  i0 = r18->size[0] * r18->size[1] * r18->size[2];
  r18->size[0] = r14->size[0];
  r18->size[1] = r14->size[1];
  r18->size[2] = r14->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r18, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = r14->size[0] * r14->size[1] * r14->size[2];
  emxFree_int32_T(&w_u);
  emxFree_int32_T(&w_t);
  emxFree_int32_T(&y_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    r18->data[i0] = r14->data[i0] - r15->data[i0];
  }

  emxInit_real32_T(sp, &r19, 3, &b_emlrtRTEI, true);
  st.site = &e_emlrtRSI;
  power(&st, r18, r14);
  i0 = r19->size[0] * r19->size[1] * r19->size[2];
  r19->size[0] = r16->size[0];
  r19->size[1] = r16->size[1];
  r19->size[2] = r16->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r19, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = r16->size[0] * r16->size[1] * r16->size[2];
  emxFree_real32_T(&r18);
  for (i0 = 0; i0 < loop_ub; i0++) {
    r19->data[i0] = r16->data[i0] - r17->data[i0];
  }

  st.site = &e_emlrtRSI;
  power(&st, r19, r15);
  emxFree_real32_T(&r19);
  for (i0 = 0; i0 < 3; i0++) {
    d_s[i0] = r14->size[i0];
    e_s[i0] = r15->size[i0];
  }

  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&l_emlrtECI, sp);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r16->size[0] * r16->size[1] * r16->size[2];
  r16->size[0] = s->size[1];
  r16->size[1] = t->size[1];
  r16->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r16, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2] + 1;
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&kc_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&lc_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&mc_emlrtBCI,
            sp);
        }

        r16->data[(i2 + r16->size[0] * i1) + r16->size[0] * r16->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r17->size[0] * r17->size[1] * r17->size[2];
  r17->size[0] = s->size[1];
  r17->size[1] = t->size[1];
  r17->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r17, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2] + 1;
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&nc_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&oc_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0] - 1;
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&pc_emlrtBCI,
            sp);
        }

        r17->data[(i2 + r17->size[0] * i1) + r17->size[0] * r17->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_int32_T1(sp, &ab_s, 1, &b_emlrtRTEI, true);
  i0 = ab_s->size[0];
  ab_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)ab_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    ab_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &x_t, 1, &b_emlrtRTEI, true);
  i0 = x_t->size[0];
  x_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)x_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    x_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &x_u, 1, &b_emlrtRTEI, true);
  i0 = x_u->size[0];
  x_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)x_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    x_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &bb_s, 1, &b_emlrtRTEI, true);
  d_s[0] = ab_s->size[0];
  d_s[1] = x_t->size[0];
  d_s[2] = x_u->size[0];
  i0 = bb_s->size[0];
  bb_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)bb_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&x_u);
  emxFree_int32_T(&x_t);
  emxFree_int32_T(&ab_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    bb_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &y_t, 1, &b_emlrtRTEI, true);
  i0 = y_t->size[0];
  y_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)y_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    y_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &y_u, 1, &b_emlrtRTEI, true);
  i0 = y_u->size[0];
  y_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)y_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    y_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_real32_T(sp, &r20, 3, &b_emlrtRTEI, true);
  e_s[0] = bb_s->size[0];
  e_s[1] = y_t->size[0];
  e_s[2] = y_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&m_emlrtECI, sp);
  i0 = r20->size[0] * r20->size[1] * r20->size[2];
  r20->size[0] = r16->size[0];
  r20->size[1] = r16->size[1];
  r20->size[2] = r16->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r20, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = r16->size[0] * r16->size[1] * r16->size[2];
  emxFree_int32_T(&y_u);
  emxFree_int32_T(&y_t);
  emxFree_int32_T(&bb_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    r20->data[i0] = r16->data[i0] - r17->data[i0];
  }

  emxFree_real32_T(&r17);
  st.site = &e_emlrtRSI;
  power(&st, r20, r16);
  emxFree_real32_T(&r20);
  for (i0 = 0; i0 < 3; i0++) {
    d_s[i0] = r14->size[i0];
    e_s[i0] = r16->size[i0];
  }

  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&l_emlrtECI, sp);
  i0 = r6->size[0] * r6->size[1] * r6->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r6, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  i0 = r6->size[0];
  i1 = r6->size[1];
  i2 = r6->size[2];
  loop_ub = i0 * i1 * i2;
  for (i0 = 0; i0 < loop_ub; i0++) {
    r6->data[i0] = ((1.0E-8F + r6->data[i0]) + r7->data[i0]) + r8->data[i0];
  }

  emxInit_real32_T(sp, &r21, 3, &b_emlrtRTEI, true);
  st.site = &c_emlrtRSI;
  b_sqrt(&st, r6);
  i0 = r21->size[0] * r21->size[1] * r21->size[2];
  r21->size[0] = r0->size[0];
  r21->size[1] = r0->size[1];
  r21->size[2] = r0->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r21, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = r0->size[0] * r0->size[1] * r0->size[2];
  for (i0 = 0; i0 < loop_ub; i0++) {
    r21->data[i0] = ((r0->data[i0] - r1->data[i0]) + (r2->data[i0] - r3->data[i0]))
      + (r4->data[i0] - r5->data[i0]);
  }

  st.site = &d_emlrtRSI;
  rdivide(&st, r21, r6, r0);
  i0 = r14->size[0] * r14->size[1] * r14->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r14, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  i0 = r14->size[0];
  i1 = r14->size[1];
  i2 = r14->size[2];
  loop_ub = i0 * i1 * i2;
  emxFree_real32_T(&r21);
  for (i0 = 0; i0 < loop_ub; i0++) {
    r14->data[i0] = ((1.0E-8F + r14->data[i0]) + r15->data[i0]) + r16->data[i0];
  }

  emxFree_real32_T(&r16);
  emxFree_real32_T(&r15);
  emxInit_real32_T(sp, &r22, 3, &b_emlrtRTEI, true);
  st.site = &e_emlrtRSI;
  b_sqrt(&st, r14);
  i0 = r22->size[0] * r22->size[1] * r22->size[2];
  r22->size[0] = r9->size[0];
  r22->size[1] = r9->size[1];
  r22->size[2] = r9->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r22, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = r9->size[0] * r9->size[1] * r9->size[2];
  for (i0 = 0; i0 < loop_ub; i0++) {
    r22->data[i0] = r9->data[i0] - r13->data[i0];
  }

  emxFree_real32_T(&r13);
  emxFree_real32_T(&r9);
  st.site = &e_emlrtRSI;
  rdivide(&st, r22, r14, r1);
  emxFree_real32_T(&r22);
  emxFree_real32_T(&r14);
  for (i0 = 0; i0 < 3; i0++) {
    d_s[i0] = r0->size[i0];
    e_s[i0] = r1->size[i0];
  }

  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&n_emlrtECI, sp);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r2->size[0] * r2->size[1] * r2->size[2];
  r2->size[0] = s->size[1];
  r2->size[1] = t->size[1];
  r2->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r2, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&qc_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1] + 1;
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&rc_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&sc_emlrtBCI,
            sp);
        }

        r2->data[(i2 + r2->size[0] * i1) + r2->size[0] * r2->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r3->size[0] * r3->size[1] * r3->size[2];
  r3->size[0] = s->size[1];
  r3->size[1] = t->size[1];
  r3->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r3, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&tc_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&uc_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&vc_emlrtBCI,
            sp);
        }

        r3->data[(i2 + r3->size[0] * i1) + r3->size[0] * r3->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_int32_T1(sp, &cb_s, 1, &b_emlrtRTEI, true);
  i0 = cb_s->size[0];
  cb_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)cb_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    cb_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &ab_t, 1, &b_emlrtRTEI, true);
  i0 = ab_t->size[0];
  ab_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)ab_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    ab_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &ab_u, 1, &b_emlrtRTEI, true);
  i0 = ab_u->size[0];
  ab_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)ab_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    ab_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &db_s, 1, &b_emlrtRTEI, true);
  d_s[0] = cb_s->size[0];
  d_s[1] = ab_t->size[0];
  d_s[2] = ab_u->size[0];
  i0 = db_s->size[0];
  db_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)db_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&ab_u);
  emxFree_int32_T(&ab_t);
  emxFree_int32_T(&cb_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    db_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &bb_t, 1, &b_emlrtRTEI, true);
  i0 = bb_t->size[0];
  bb_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)bb_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    bb_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &bb_u, 1, &b_emlrtRTEI, true);
  i0 = bb_u->size[0];
  bb_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)bb_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    bb_u->data[i0] = u->data[u->size[0] * i0];
  }

  e_s[0] = db_s->size[0];
  e_s[1] = bb_t->size[0];
  e_s[2] = bb_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&o_emlrtECI, sp);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r4->size[0] * r4->size[1] * r4->size[2];
  r4->size[0] = s->size[1];
  r4->size[1] = t->size[1];
  r4->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r4, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  emxFree_int32_T(&bb_u);
  emxFree_int32_T(&bb_t);
  emxFree_int32_T(&db_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&wc_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1] + 1;
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&xc_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&yc_emlrtBCI,
            sp);
        }

        r4->data[(i2 + r4->size[0] * i1) + r4->size[0] * r4->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r5->size[0] * r5->size[1] * r5->size[2];
  r5->size[0] = s->size[1];
  r5->size[1] = t->size[1];
  r5->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r5, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&ad_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&bd_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&cd_emlrtBCI,
            sp);
        }

        r5->data[(i2 + r5->size[0] * i1) + r5->size[0] * r5->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_int32_T1(sp, &eb_s, 1, &b_emlrtRTEI, true);
  i0 = eb_s->size[0];
  eb_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)eb_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    eb_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &cb_t, 1, &b_emlrtRTEI, true);
  i0 = cb_t->size[0];
  cb_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)cb_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    cb_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &cb_u, 1, &b_emlrtRTEI, true);
  i0 = cb_u->size[0];
  cb_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)cb_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    cb_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &fb_s, 1, &b_emlrtRTEI, true);
  d_s[0] = eb_s->size[0];
  d_s[1] = cb_t->size[0];
  d_s[2] = cb_u->size[0];
  i0 = fb_s->size[0];
  fb_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)fb_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&cb_u);
  emxFree_int32_T(&cb_t);
  emxFree_int32_T(&eb_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    fb_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &db_t, 1, &b_emlrtRTEI, true);
  i0 = db_t->size[0];
  db_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)db_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    db_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &db_u, 1, &b_emlrtRTEI, true);
  i0 = db_u->size[0];
  db_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)db_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    db_u->data[i0] = u->data[u->size[0] * i0];
  }

  e_s[0] = fb_s->size[0];
  e_s[1] = db_t->size[0];
  e_s[2] = db_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&p_emlrtECI, sp);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r6->size[0] * r6->size[1] * r6->size[2];
  r6->size[0] = s->size[1];
  r6->size[1] = t->size[1];
  r6->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r6, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  emxFree_int32_T(&db_u);
  emxFree_int32_T(&db_t);
  emxFree_int32_T(&fb_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&dd_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1] + 1;
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&ed_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&fd_emlrtBCI,
            sp);
        }

        r6->data[(i2 + r6->size[0] * i1) + r6->size[0] * r6->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r7->size[0] * r7->size[1] * r7->size[2];
  r7->size[0] = s->size[1];
  r7->size[1] = t->size[1];
  r7->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r7, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2] - 1;
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&gd_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1] + 1;
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&hd_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&id_emlrtBCI,
            sp);
        }

        r7->data[(i2 + r7->size[0] * i1) + r7->size[0] * r7->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_int32_T1(sp, &gb_s, 1, &b_emlrtRTEI, true);
  i0 = gb_s->size[0];
  gb_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)gb_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    gb_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &eb_t, 1, &b_emlrtRTEI, true);
  i0 = eb_t->size[0];
  eb_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)eb_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    eb_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &eb_u, 1, &b_emlrtRTEI, true);
  i0 = eb_u->size[0];
  eb_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)eb_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    eb_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &hb_s, 1, &b_emlrtRTEI, true);
  d_s[0] = gb_s->size[0];
  d_s[1] = eb_t->size[0];
  d_s[2] = eb_u->size[0];
  i0 = hb_s->size[0];
  hb_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)hb_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&eb_u);
  emxFree_int32_T(&eb_t);
  emxFree_int32_T(&gb_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    hb_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &fb_t, 1, &b_emlrtRTEI, true);
  i0 = fb_t->size[0];
  fb_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)fb_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    fb_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &fb_u, 1, &b_emlrtRTEI, true);
  i0 = fb_u->size[0];
  fb_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)fb_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    fb_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_real32_T(sp, &r23, 3, &b_emlrtRTEI, true);
  e_s[0] = hb_s->size[0];
  e_s[1] = fb_t->size[0];
  e_s[2] = fb_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&q_emlrtECI, sp);
  i0 = r23->size[0] * r23->size[1] * r23->size[2];
  r23->size[0] = r4->size[0];
  r23->size[1] = r4->size[1];
  r23->size[2] = r4->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r23, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = r4->size[0] * r4->size[1] * r4->size[2];
  emxFree_int32_T(&fb_u);
  emxFree_int32_T(&fb_t);
  emxFree_int32_T(&hb_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    r23->data[i0] = r4->data[i0] - r5->data[i0];
  }

  emxInit_real32_T(sp, &r24, 3, &b_emlrtRTEI, true);
  st.site = &f_emlrtRSI;
  power(&st, r23, r4);
  i0 = r24->size[0] * r24->size[1] * r24->size[2];
  r24->size[0] = r6->size[0];
  r24->size[1] = r6->size[1];
  r24->size[2] = r6->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r24, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = r6->size[0] * r6->size[1] * r6->size[2];
  emxFree_real32_T(&r23);
  for (i0 = 0; i0 < loop_ub; i0++) {
    r24->data[i0] = r6->data[i0] - r7->data[i0];
  }

  st.site = &f_emlrtRSI;
  power(&st, r24, r5);
  emxFree_real32_T(&r24);
  for (i0 = 0; i0 < 3; i0++) {
    d_s[i0] = r4->size[i0];
    e_s[i0] = r5->size[i0];
  }

  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&r_emlrtECI, sp);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r6->size[0] * r6->size[1] * r6->size[2];
  r6->size[0] = s->size[1];
  r6->size[1] = t->size[1];
  r6->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r6, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&jd_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1] + 1;
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&kd_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&ld_emlrtBCI,
            sp);
        }

        r6->data[(i2 + r6->size[0] * i1) + r6->size[0] * r6->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r7->size[0] * r7->size[1] * r7->size[2];
  r7->size[0] = s->size[1];
  r7->size[1] = t->size[1];
  r7->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r7, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&md_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1] + 1;
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&nd_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0] - 1;
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&od_emlrtBCI,
            sp);
        }

        r7->data[(i2 + r7->size[0] * i1) + r7->size[0] * r7->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_int32_T1(sp, &ib_s, 1, &b_emlrtRTEI, true);
  i0 = ib_s->size[0];
  ib_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)ib_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    ib_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &gb_t, 1, &b_emlrtRTEI, true);
  i0 = gb_t->size[0];
  gb_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)gb_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    gb_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &gb_u, 1, &b_emlrtRTEI, true);
  i0 = gb_u->size[0];
  gb_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)gb_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    gb_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &jb_s, 1, &b_emlrtRTEI, true);
  d_s[0] = ib_s->size[0];
  d_s[1] = gb_t->size[0];
  d_s[2] = gb_u->size[0];
  i0 = jb_s->size[0];
  jb_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)jb_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&gb_u);
  emxFree_int32_T(&gb_t);
  emxFree_int32_T(&ib_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    jb_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &hb_t, 1, &b_emlrtRTEI, true);
  i0 = hb_t->size[0];
  hb_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)hb_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    hb_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &hb_u, 1, &b_emlrtRTEI, true);
  i0 = hb_u->size[0];
  hb_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)hb_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    hb_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_real32_T(sp, &r25, 3, &b_emlrtRTEI, true);
  e_s[0] = jb_s->size[0];
  e_s[1] = hb_t->size[0];
  e_s[2] = hb_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&s_emlrtECI, sp);
  i0 = r25->size[0] * r25->size[1] * r25->size[2];
  r25->size[0] = r6->size[0];
  r25->size[1] = r6->size[1];
  r25->size[2] = r6->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r25, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = r6->size[0] * r6->size[1] * r6->size[2];
  emxFree_int32_T(&hb_u);
  emxFree_int32_T(&hb_t);
  emxFree_int32_T(&jb_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    r25->data[i0] = r6->data[i0] - r7->data[i0];
  }

  st.site = &f_emlrtRSI;
  power(&st, r25, r6);
  emxFree_real32_T(&r25);
  for (i0 = 0; i0 < 3; i0++) {
    d_s[i0] = r4->size[i0];
    e_s[i0] = r6->size[i0];
  }

  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&r_emlrtECI, sp);
  i0 = r4->size[0] * r4->size[1] * r4->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r4, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  i0 = r4->size[0];
  i1 = r4->size[1];
  i2 = r4->size[2];
  loop_ub = i0 * i1 * i2;
  for (i0 = 0; i0 < loop_ub; i0++) {
    r4->data[i0] = ((1.0E-8F + r4->data[i0]) + r5->data[i0]) + r6->data[i0];
  }

  emxInit_real32_T(sp, &r26, 3, &b_emlrtRTEI, true);
  st.site = &f_emlrtRSI;
  b_sqrt(&st, r4);
  i0 = r26->size[0] * r26->size[1] * r26->size[2];
  r26->size[0] = r2->size[0];
  r26->size[1] = r2->size[1];
  r26->size[2] = r2->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r26, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = r2->size[0] * r2->size[1] * r2->size[2];
  for (i0 = 0; i0 < loop_ub; i0++) {
    r26->data[i0] = r2->data[i0] - r3->data[i0];
  }

  st.site = &f_emlrtRSI;
  rdivide(&st, r26, r4, r2);
  emxFree_real32_T(&r26);
  for (i0 = 0; i0 < 3; i0++) {
    d_s[i0] = r0->size[i0];
    e_s[i0] = r2->size[i0];
  }

  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&n_emlrtECI, sp);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r3->size[0] * r3->size[1] * r3->size[2];
  r3->size[0] = s->size[1];
  r3->size[1] = t->size[1];
  r3->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r3, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&pd_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&qd_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0] + 1;
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&rd_emlrtBCI,
            sp);
        }

        r3->data[(i2 + r3->size[0] * i1) + r3->size[0] * r3->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r4->size[0] * r4->size[1] * r4->size[2];
  r4->size[0] = s->size[1];
  r4->size[1] = t->size[1];
  r4->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r4, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&sd_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&td_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&ud_emlrtBCI,
            sp);
        }

        r4->data[(i2 + r4->size[0] * i1) + r4->size[0] * r4->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_int32_T1(sp, &kb_s, 1, &b_emlrtRTEI, true);
  i0 = kb_s->size[0];
  kb_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)kb_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    kb_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &ib_t, 1, &b_emlrtRTEI, true);
  i0 = ib_t->size[0];
  ib_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)ib_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    ib_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &ib_u, 1, &b_emlrtRTEI, true);
  i0 = ib_u->size[0];
  ib_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)ib_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    ib_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &lb_s, 1, &b_emlrtRTEI, true);
  d_s[0] = kb_s->size[0];
  d_s[1] = ib_t->size[0];
  d_s[2] = ib_u->size[0];
  i0 = lb_s->size[0];
  lb_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)lb_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&ib_u);
  emxFree_int32_T(&ib_t);
  emxFree_int32_T(&kb_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    lb_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &jb_t, 1, &b_emlrtRTEI, true);
  i0 = jb_t->size[0];
  jb_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)jb_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    jb_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &jb_u, 1, &b_emlrtRTEI, true);
  i0 = jb_u->size[0];
  jb_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)jb_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    jb_u->data[i0] = u->data[u->size[0] * i0];
  }

  e_s[0] = lb_s->size[0];
  e_s[1] = jb_t->size[0];
  e_s[2] = jb_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&t_emlrtECI, sp);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r5->size[0] * r5->size[1] * r5->size[2];
  r5->size[0] = s->size[1];
  r5->size[1] = t->size[1];
  r5->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r5, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  emxFree_int32_T(&jb_u);
  emxFree_int32_T(&jb_t);
  emxFree_int32_T(&lb_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&vd_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&wd_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0] + 1;
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&xd_emlrtBCI,
            sp);
        }

        r5->data[(i2 + r5->size[0] * i1) + r5->size[0] * r5->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r6->size[0] * r6->size[1] * r6->size[2];
  r6->size[0] = s->size[1];
  r6->size[1] = t->size[1];
  r6->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r6, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&yd_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&ae_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0];
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&be_emlrtBCI,
            sp);
        }

        r6->data[(i2 + r6->size[0] * i1) + r6->size[0] * r6->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_int32_T1(sp, &mb_s, 1, &b_emlrtRTEI, true);
  i0 = mb_s->size[0];
  mb_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)mb_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    mb_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &kb_t, 1, &b_emlrtRTEI, true);
  i0 = kb_t->size[0];
  kb_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)kb_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    kb_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &kb_u, 1, &b_emlrtRTEI, true);
  i0 = kb_u->size[0];
  kb_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)kb_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    kb_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &nb_s, 1, &b_emlrtRTEI, true);
  d_s[0] = mb_s->size[0];
  d_s[1] = kb_t->size[0];
  d_s[2] = kb_u->size[0];
  i0 = nb_s->size[0];
  nb_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)nb_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&kb_u);
  emxFree_int32_T(&kb_t);
  emxFree_int32_T(&mb_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    nb_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &lb_t, 1, &b_emlrtRTEI, true);
  i0 = lb_t->size[0];
  lb_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)lb_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    lb_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &lb_u, 1, &b_emlrtRTEI, true);
  i0 = lb_u->size[0];
  lb_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)lb_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    lb_u->data[i0] = u->data[u->size[0] * i0];
  }

  e_s[0] = nb_s->size[0];
  e_s[1] = lb_t->size[0];
  e_s[2] = lb_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&u_emlrtECI, sp);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r7->size[0] * r7->size[1] * r7->size[2];
  r7->size[0] = s->size[1];
  r7->size[1] = t->size[1];
  r7->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r7, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  emxFree_int32_T(&lb_u);
  emxFree_int32_T(&lb_t);
  emxFree_int32_T(&nb_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&ce_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&de_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0] + 1;
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&ee_emlrtBCI,
            sp);
        }

        r7->data[(i2 + r7->size[0] * i1) + r7->size[0] * r7->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r8->size[0] * r8->size[1] * r8->size[2];
  r8->size[0] = s->size[1];
  r8->size[1] = t->size[1];
  r8->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r8, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2] - 1;
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&fe_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&ge_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0] + 1;
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&he_emlrtBCI,
            sp);
        }

        r8->data[(i2 + r8->size[0] * i1) + r8->size[0] * r8->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_int32_T1(sp, &ob_s, 1, &b_emlrtRTEI, true);
  i0 = ob_s->size[0];
  ob_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)ob_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    ob_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &mb_t, 1, &b_emlrtRTEI, true);
  i0 = mb_t->size[0];
  mb_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)mb_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    mb_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &mb_u, 1, &b_emlrtRTEI, true);
  i0 = mb_u->size[0];
  mb_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)mb_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    mb_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &pb_s, 1, &b_emlrtRTEI, true);
  d_s[0] = ob_s->size[0];
  d_s[1] = mb_t->size[0];
  d_s[2] = mb_u->size[0];
  i0 = pb_s->size[0];
  pb_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)pb_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&mb_u);
  emxFree_int32_T(&mb_t);
  emxFree_int32_T(&ob_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    pb_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &nb_t, 1, &b_emlrtRTEI, true);
  i0 = nb_t->size[0];
  nb_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)nb_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    nb_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &nb_u, 1, &b_emlrtRTEI, true);
  i0 = nb_u->size[0];
  nb_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)nb_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    nb_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_real32_T(sp, &r27, 3, &b_emlrtRTEI, true);
  e_s[0] = pb_s->size[0];
  e_s[1] = nb_t->size[0];
  e_s[2] = nb_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&v_emlrtECI, sp);
  i0 = r27->size[0] * r27->size[1] * r27->size[2];
  r27->size[0] = r5->size[0];
  r27->size[1] = r5->size[1];
  r27->size[2] = r5->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r27, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = r5->size[0] * r5->size[1] * r5->size[2];
  emxFree_int32_T(&nb_u);
  emxFree_int32_T(&nb_t);
  emxFree_int32_T(&pb_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    r27->data[i0] = r5->data[i0] - r6->data[i0];
  }

  emxInit_real32_T(sp, &r28, 3, &b_emlrtRTEI, true);
  st.site = &g_emlrtRSI;
  power(&st, r27, r5);
  i0 = r28->size[0] * r28->size[1] * r28->size[2];
  r28->size[0] = r7->size[0];
  r28->size[1] = r7->size[1];
  r28->size[2] = r7->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r28, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = r7->size[0] * r7->size[1] * r7->size[2];
  emxFree_real32_T(&r27);
  for (i0 = 0; i0 < loop_ub; i0++) {
    r28->data[i0] = r7->data[i0] - r8->data[i0];
  }

  st.site = &g_emlrtRSI;
  power(&st, r28, r6);
  emxFree_real32_T(&r28);
  for (i0 = 0; i0 < 3; i0++) {
    d_s[i0] = r5->size[i0];
    e_s[i0] = r6->size[i0];
  }

  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&w_emlrtECI, sp);
  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r7->size[0] * r7->size[1] * r7->size[2];
  r7->size[0] = s->size[1];
  r7->size[1] = t->size[1];
  r7->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r7, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&ie_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1];
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&je_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0] + 1;
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&ke_emlrtBCI,
            sp);
        }

        r7->data[(i2 + r7->size[0] * i1) + r7->size[0] * r7->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  b_f = f->size[0];
  c_f = f->size[1];
  d_f = f->size[2];
  i0 = r8->size[0] * r8->size[1] * r8->size[2];
  r8->size[0] = s->size[1];
  r8->size[1] = t->size[1];
  r8->size[2] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)r8, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = t->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = s->size[1];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        i3 = s->data[s->size[0] * i2];
        if (!((i3 >= 1) && (i3 <= b_f))) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, b_f, (emlrtBCInfo *)&le_emlrtBCI,
            sp);
        }

        i4 = t->data[t->size[0] * i1] - 1;
        if (!((i4 >= 1) && (i4 <= c_f))) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, c_f, (emlrtBCInfo *)&me_emlrtBCI,
            sp);
        }

        i5 = u->data[u->size[0] * i0] + 1;
        if (!((i5 >= 1) && (i5 <= d_f))) {
          emlrtDynamicBoundsCheckR2012b(i5, 1, d_f, (emlrtBCInfo *)&ne_emlrtBCI,
            sp);
        }

        r8->data[(i2 + r8->size[0] * i1) + r8->size[0] * r8->size[1] * i0] =
          f->data[((i3 + f->size[0] * (i4 - 1)) + f->size[0] * f->size[1] * (i5
                    - 1)) - 1];
      }
    }
  }

  emxInit_int32_T1(sp, &qb_s, 1, &b_emlrtRTEI, true);
  i0 = qb_s->size[0];
  qb_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)qb_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    qb_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxInit_int32_T1(sp, &ob_t, 1, &b_emlrtRTEI, true);
  i0 = ob_t->size[0];
  ob_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)ob_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    ob_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxInit_int32_T1(sp, &ob_u, 1, &b_emlrtRTEI, true);
  i0 = ob_u->size[0];
  ob_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)ob_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    ob_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxInit_int32_T1(sp, &rb_s, 1, &b_emlrtRTEI, true);
  d_s[0] = qb_s->size[0];
  d_s[1] = ob_t->size[0];
  d_s[2] = ob_u->size[0];
  i0 = rb_s->size[0];
  rb_s->size[0] = s->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)rb_s, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = s->size[1];
  emxFree_int32_T(&ob_u);
  emxFree_int32_T(&ob_t);
  emxFree_int32_T(&qb_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    rb_s->data[i0] = s->data[s->size[0] * i0];
  }

  emxFree_int32_T(&s);
  emxInit_int32_T1(sp, &pb_t, 1, &b_emlrtRTEI, true);
  i0 = pb_t->size[0];
  pb_t->size[0] = t->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)pb_t, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = t->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    pb_t->data[i0] = t->data[t->size[0] * i0];
  }

  emxFree_int32_T(&t);
  emxInit_int32_T1(sp, &pb_u, 1, &b_emlrtRTEI, true);
  i0 = pb_u->size[0];
  pb_u->size[0] = u->size[1];
  emxEnsureCapacity(sp, (emxArray__common *)pb_u, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = u->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    pb_u->data[i0] = u->data[u->size[0] * i0];
  }

  emxFree_int32_T(&u);
  emxInit_real32_T(sp, &r29, 3, &b_emlrtRTEI, true);
  e_s[0] = rb_s->size[0];
  e_s[1] = pb_t->size[0];
  e_s[2] = pb_u->size[0];
  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&x_emlrtECI, sp);
  i0 = r29->size[0] * r29->size[1] * r29->size[2];
  r29->size[0] = r7->size[0];
  r29->size[1] = r7->size[1];
  r29->size[2] = r7->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r29, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = r7->size[0] * r7->size[1] * r7->size[2];
  emxFree_int32_T(&pb_u);
  emxFree_int32_T(&pb_t);
  emxFree_int32_T(&rb_s);
  for (i0 = 0; i0 < loop_ub; i0++) {
    r29->data[i0] = r7->data[i0] - r8->data[i0];
  }

  emxFree_real32_T(&r8);
  st.site = &g_emlrtRSI;
  power(&st, r29, r7);
  emxFree_real32_T(&r29);
  for (i0 = 0; i0 < 3; i0++) {
    d_s[i0] = r5->size[i0];
    e_s[i0] = r7->size[i0];
  }

  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&w_emlrtECI, sp);
  i0 = r5->size[0] * r5->size[1] * r5->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r5, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  i0 = r5->size[0];
  i1 = r5->size[1];
  i2 = r5->size[2];
  loop_ub = i0 * i1 * i2;
  for (i0 = 0; i0 < loop_ub; i0++) {
    r5->data[i0] = ((1.0E-8F + r5->data[i0]) + r6->data[i0]) + r7->data[i0];
  }

  emxFree_real32_T(&r7);
  emxFree_real32_T(&r6);
  emxInit_real32_T(sp, &r30, 3, &b_emlrtRTEI, true);
  st.site = &g_emlrtRSI;
  b_sqrt(&st, r5);
  i0 = r30->size[0] * r30->size[1] * r30->size[2];
  r30->size[0] = r3->size[0];
  r30->size[1] = r3->size[1];
  r30->size[2] = r3->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r30, i0, sizeof(real32_T),
                    &b_emlrtRTEI);
  loop_ub = r3->size[0] * r3->size[1] * r3->size[2];
  for (i0 = 0; i0 < loop_ub; i0++) {
    r30->data[i0] = r3->data[i0] - r4->data[i0];
  }

  emxFree_real32_T(&r4);
  st.site = &g_emlrtRSI;
  rdivide(&st, r30, r5, r3);
  emxFree_real32_T(&r30);
  emxFree_real32_T(&r5);
  for (i0 = 0; i0 < 3; i0++) {
    d_s[i0] = r0->size[i0];
    e_s[i0] = r3->size[i0];
  }

  emlrtSizeEqCheckNDR2012b(d_s, e_s, (emlrtECInfo *)&n_emlrtECI, sp);
  if (2 > (int32_T)dims[0] - 1) {
    i0 = 0;
    i2 = 0;
  } else {
    i0 = (int32_T)dims[0];
    if (!(2 <= i0)) {
      emlrtDynamicBoundsCheckR2012b(2, 1, i0, (emlrtBCInfo *)&emlrtBCI, sp);
    }

    i0 = 1;
    i1 = (int32_T)dims[0];
    i2 = (int32_T)dims[0] - 1;
    if (!((i2 >= 1) && (i2 <= i1))) {
      emlrtDynamicBoundsCheckR2012b(i2, 1, i1, (emlrtBCInfo *)&b_emlrtBCI, sp);
    }
  }

  if (2 > (int32_T)dims[1] - 1) {
    i1 = 0;
    i4 = 0;
  } else {
    i1 = (int32_T)dims[1];
    if (!(2 <= i1)) {
      emlrtDynamicBoundsCheckR2012b(2, 1, i1, (emlrtBCInfo *)&c_emlrtBCI, sp);
    }

    i1 = 1;
    i3 = (int32_T)dims[1];
    i4 = (int32_T)dims[1] - 1;
    if (!((i4 >= 1) && (i4 <= i3))) {
      emlrtDynamicBoundsCheckR2012b(i4, 1, i3, (emlrtBCInfo *)&d_emlrtBCI, sp);
    }
  }

  if (2 > (int32_T)dims[2] - 1) {
    i3 = 0;
    b_f = 0;
  } else {
    i3 = (int32_T)dims[2];
    if (!(2 <= i3)) {
      emlrtDynamicBoundsCheckR2012b(2, 1, i3, (emlrtBCInfo *)&e_emlrtBCI, sp);
    }

    i3 = 1;
    i5 = (int32_T)dims[2];
    b_f = (int32_T)dims[2] - 1;
    if (!((b_f >= 1) && (b_f <= i5))) {
      emlrtDynamicBoundsCheckR2012b(b_f, 1, i5, (emlrtBCInfo *)&f_emlrtBCI, sp);
    }
  }

  emxInit_int32_T1(sp, &r31, 1, &b_emlrtRTEI, true);
  i5 = r31->size[0];
  r31->size[0] = i2 - i0;
  emxEnsureCapacity(sp, (emxArray__common *)r31, i5, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = i2 - i0;
  for (i2 = 0; i2 < loop_ub; i2++) {
    r31->data[i2] = i0 + i2;
  }

  emxInit_int32_T1(sp, &r32, 1, &b_emlrtRTEI, true);
  i0 = r32->size[0];
  r32->size[0] = i4 - i1;
  emxEnsureCapacity(sp, (emxArray__common *)r32, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = i4 - i1;
  for (i0 = 0; i0 < loop_ub; i0++) {
    r32->data[i0] = i1 + i0;
  }

  emxInit_int32_T1(sp, &r33, 1, &b_emlrtRTEI, true);
  i0 = r33->size[0];
  r33->size[0] = b_f - i3;
  emxEnsureCapacity(sp, (emxArray__common *)r33, i0, sizeof(int32_T),
                    &b_emlrtRTEI);
  loop_ub = b_f - i3;
  for (i0 = 0; i0 < loop_ub; i0++) {
    r33->data[i0] = i3 + i0;
  }

  emxInit_real_T(sp, &r34, 3, &b_emlrtRTEI, true);
  i0 = r34->size[0] * r34->size[1] * r34->size[2];
  r34->size[0] = r0->size[0];
  r34->size[1] = r0->size[1];
  r34->size[2] = r0->size[2];
  emxEnsureCapacity(sp, (emxArray__common *)r34, i0, sizeof(real_T),
                    &b_emlrtRTEI);
  loop_ub = r0->size[0] * r0->size[1] * r0->size[2];
  for (i0 = 0; i0 < loop_ub; i0++) {
    r34->data[i0] = ((r0->data[i0] - r1->data[i0]) - r2->data[i0]) - r3->data[i0];
  }

  emxFree_real32_T(&r3);
  emxFree_real32_T(&r2);
  emxFree_real32_T(&r1);
  emxFree_real32_T(&r0);
  d_s[0] = r31->size[0];
  d_s[1] = r32->size[0];
  d_s[2] = r33->size[0];
  emlrtSubAssignSizeCheckR2012b(d_s, 3, *(int32_T (*)[3])r34->size, 3,
    (emlrtECInfo *)&y_emlrtECI, sp);
  loop_ub = r34->size[2];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_loop_ub = r34->size[1];
    for (i1 = 0; i1 < b_loop_ub; i1++) {
      c_loop_ub = r34->size[0];
      for (i2 = 0; i2 < c_loop_ub; i2++) {
        f_grad->data[(r31->data[i2] + f_grad->size[0] * r32->data[i1]) +
          f_grad->size[0] * f_grad->size[1] * r33->data[i0]] = r34->data[(i2 +
          r34->size[0] * i1) + r34->size[0] * r34->size[1] * i0];
      }
    }
  }

  emxFree_real_T(&r34);
  emxFree_int32_T(&r33);
  emxFree_int32_T(&r32);
  emxFree_int32_T(&r31);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void minimizeTV2(const emlrtStack *sp, emxArray_real32_T *f, real_T tvConstant,
                 real_T nIterTV)
{
  int32_T i;
  emxArray_real_T *f_grad;
  emxArray_real_T *x;
  emxArray_real_T *b_x;
  emxArray_real_T *c_x;
  boolean_T overflow;
  boolean_T p;
  int32_T k;
  uint32_T sz[3];
  int32_T vlen;
  int32_T npages;
  int32_T b_k;
  int32_T b_i;
  int32_T xoffset;
  real_T s;
  int32_T b_f[3];
  int32_T b_f_grad[3];
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
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emlrtForLoopVectorCheckR2012b(1.0, 1.0, nIterTV, mxDOUBLE_CLASS, (int32_T)
    nIterTV, (emlrtRTEInfo *)&p_emlrtRTEI, sp);
  i = 0;
  emxInit_real_T(sp, &f_grad, 3, &i_emlrtRTEI, true);
  emxInit_real_T(sp, &x, 3, &emlrtRTEI, true);
  emxInit_real_T(sp, &b_x, 3, &emlrtRTEI, true);
  emxInit_real_T(sp, &c_x, 3, &emlrtRTEI, true);
  while (i <= (int32_T)nIterTV - 1) {
    st.site = &emlrtRSI;
    tvGradient(&st, f, f_grad);
    st.site = &b_emlrtRSI;
    b_power(&st, f_grad, x);
    st.site = &b_emlrtRSI;
    b_st.site = &p_emlrtRSI;
    if (((x->size[0] == 1) && (x->size[1] == 1) && (x->size[2] == 1)) ||
        (x->size[0] != 1)) {
      overflow = true;
    } else {
      overflow = false;
    }

    if (!overflow) {
      emlrtErrorWithMessageIdR2012b(&b_st, &n_emlrtRTEI,
        "Coder:toolbox:autoDimIncompatibility", 0);
    }

    overflow = false;
    p = false;
    if ((x->size[0] != 0) || (x->size[1] != 0) || (x->size[2] != 1)) {
    } else {
      p = true;
    }

    if (p) {
      overflow = true;
    }

    if (overflow) {
      emlrtErrorWithMessageIdR2012b(&b_st, &o_emlrtRTEI,
        "Coder:toolbox:UnsupportedSpecialEmpty", 0);
    }

    c_st.site = &q_emlrtRSI;
    for (k = 0; k < 3; k++) {
      sz[k] = (uint32_T)x->size[k];
    }

    k = b_x->size[0] * b_x->size[1] * b_x->size[2];
    b_x->size[0] = 1;
    b_x->size[1] = (int32_T)sz[1];
    b_x->size[2] = (int32_T)sz[2];
    emxEnsureCapacity(&c_st, (emxArray__common *)b_x, k, sizeof(real_T),
                      &emlrtRTEI);
    if ((x->size[0] == 0) || (x->size[1] == 0) || (x->size[2] == 0)) {
      k = b_x->size[0] * b_x->size[1] * b_x->size[2];
      b_x->size[0] = 1;
      emxEnsureCapacity(&c_st, (emxArray__common *)b_x, k, sizeof(real_T),
                        &emlrtRTEI);
      b_i = b_x->size[2];
      for (k = 0; k < b_i; k++) {
        xoffset = b_x->size[1];
        for (vlen = 0; vlen < xoffset; vlen++) {
          b_x->data[b_x->size[0] * vlen + b_x->size[0] * b_x->size[1] * k] = 0.0;
        }
      }
    } else {
      vlen = x->size[0];
      d_st.site = &r_emlrtRSI;
      npages = 1;
      b_k = 3;
      while ((b_k > 2) && (x->size[2] == 1)) {
        b_k = 2;
      }

      for (k = 2; k <= b_k; k++) {
        npages *= x->size[k - 1];
      }

      d_st.site = &s_emlrtRSI;
      if ((!(1 > npages)) && (npages > 2147483646)) {
        e_st.site = &l_emlrtRSI;
        check_forloop_overflow_error(&e_st);
      }

      for (b_i = 0; b_i + 1 <= npages; b_i++) {
        xoffset = b_i * vlen;
        d_st.site = &t_emlrtRSI;
        s = x->data[xoffset];
        d_st.site = &u_emlrtRSI;
        if ((!(2 > vlen)) && (vlen > 2147483646)) {
          e_st.site = &l_emlrtRSI;
          check_forloop_overflow_error(&e_st);
        }

        for (b_k = 1; b_k + 1 <= vlen; b_k++) {
          s += x->data[xoffset + b_k];
        }

        b_x->data[b_i] = s;
      }
    }

    st.site = &b_emlrtRSI;
    b_st.site = &p_emlrtRSI;
    if (((b_x->size[1] == 1) && (b_x->size[2] == 1)) || (b_x->size[1] != 1)) {
      overflow = true;
    } else {
      overflow = false;
    }

    if (!overflow) {
      emlrtErrorWithMessageIdR2012b(&b_st, &n_emlrtRTEI,
        "Coder:toolbox:autoDimIncompatibility", 0);
    }

    c_st.site = &q_emlrtRSI;
    k = c_x->size[0] * c_x->size[1] * c_x->size[2];
    c_x->size[0] = 1;
    c_x->size[1] = 1;
    c_x->size[2] = b_x->size[2];
    emxEnsureCapacity(&c_st, (emxArray__common *)c_x, k, sizeof(real_T),
                      &emlrtRTEI);
    if ((b_x->size[1] == 0) || (b_x->size[2] == 0)) {
      k = c_x->size[0] * c_x->size[1] * c_x->size[2];
      c_x->size[0] = 1;
      c_x->size[1] = 1;
      emxEnsureCapacity(&c_st, (emxArray__common *)c_x, k, sizeof(real_T),
                        &emlrtRTEI);
      b_i = c_x->size[2];
      for (k = 0; k < b_i; k++) {
        c_x->data[c_x->size[0] * c_x->size[1] * k] = 0.0;
      }
    } else {
      vlen = b_x->size[1];
      npages = 1;
      b_k = 3;
      while ((b_k > 2) && (b_x->size[2] == 1)) {
        b_k = 2;
      }

      k = 3;
      while (k <= b_k) {
        npages *= b_x->size[2];
        k = 4;
      }

      d_st.site = &s_emlrtRSI;
      if ((!(1 > npages)) && (npages > 2147483646)) {
        e_st.site = &l_emlrtRSI;
        check_forloop_overflow_error(&e_st);
      }

      for (b_i = 0; b_i + 1 <= npages; b_i++) {
        xoffset = b_i * vlen;
        d_st.site = &t_emlrtRSI;
        s = b_x->data[xoffset];
        d_st.site = &u_emlrtRSI;
        if ((!(2 > vlen)) && (vlen > 2147483646)) {
          e_st.site = &l_emlrtRSI;
          check_forloop_overflow_error(&e_st);
        }

        for (b_k = 1; b_k + 1 <= vlen; b_k++) {
          s += b_x->data[xoffset + b_k];
        }

        c_x->data[b_i] = s;
      }
    }

    st.site = &b_emlrtRSI;
    b_st.site = &p_emlrtRSI;
    if ((c_x->size[2] == 1) || (c_x->size[2] != 1)) {
      overflow = true;
    } else {
      overflow = false;
    }

    if (!overflow) {
      emlrtErrorWithMessageIdR2012b(&b_st, &n_emlrtRTEI,
        "Coder:toolbox:autoDimIncompatibility", 0);
    }

    c_st.site = &q_emlrtRSI;
    if (c_x->size[2] == 0) {
      s = 0.0;
    } else {
      s = c_x->data[0];
      d_st.site = &w_emlrtRSI;
      overflow = ((!(2 > c_x->size[2])) && (c_x->size[2] > 2147483646));
      if (overflow) {
        e_st.site = &l_emlrtRSI;
        check_forloop_overflow_error(&e_st);
      }

      for (b_k = 2; b_k <= c_x->size[2]; b_k++) {
        s += c_x->data[b_k - 1];
      }
    }

    st.site = &b_emlrtRSI;
    if (s < 0.0) {
      b_st.site = &m_emlrtRSI;
      error(&b_st);
    }

    s = muDoubleScalarSqrt(s);
    k = f_grad->size[0] * f_grad->size[1] * f_grad->size[2];
    emxEnsureCapacity(sp, (emxArray__common *)f_grad, k, sizeof(real_T),
                      &emlrtRTEI);
    k = f_grad->size[0];
    b_i = f_grad->size[1];
    xoffset = f_grad->size[2];
    b_i = k * b_i * xoffset;
    for (k = 0; k < b_i; k++) {
      f_grad->data[k] = tvConstant * f_grad->data[k] / s;
    }

    for (k = 0; k < 3; k++) {
      b_f[k] = f->size[k];
      b_f_grad[k] = f_grad->size[k];
    }

    emlrtSizeEqCheckNDR2012b(b_f, b_f_grad, (emlrtECInfo *)&ab_emlrtECI, sp);
    k = f->size[0] * f->size[1] * f->size[2];
    emxEnsureCapacity(sp, (emxArray__common *)f, k, sizeof(real32_T), &emlrtRTEI);
    b_i = f->size[2];
    for (k = 0; k < b_i; k++) {
      xoffset = f->size[1];
      for (vlen = 0; vlen < xoffset; vlen++) {
        npages = f->size[0];
        for (b_k = 0; b_k < npages; b_k++) {
          f->data[(b_k + f->size[0] * vlen) + f->size[0] * f->size[1] * k] -=
            (real32_T)f_grad->data[(b_k + f_grad->size[0] * vlen) + f_grad->
            size[0] * f_grad->size[1] * k];
        }
      }
    }

    i++;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_real_T(&c_x);
  emxFree_real_T(&b_x);
  emxFree_real_T(&x);
  emxFree_real_T(&f_grad);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (minimizeTV2.cpp) */
