/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_testFun_info.c
 *
 * Code generation for function '_coder_testFun_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "testFun.h"
#include "_coder_testFun_info.h"

/* Function Definitions */
mxArray *emlrtMexFcnProperties(void)
{
  mxArray *xResult;
  mxArray *xEntryPoints;
  const char * fldNames[4] = { "Name", "NumberOfInputs", "NumberOfOutputs",
    "ConstantInputs" };

  mxArray *xInputs;
  const char * b_fldNames[4] = { "Version", "ResolvedFunctions", "EntryPoints",
    "CoverageInfo" };

  xEntryPoints = emlrtCreateStructMatrix(1, 1, 4, fldNames);
  xInputs = emlrtCreateLogicalMatrix(1, 1);
  emlrtSetField(xEntryPoints, 0, "Name", mxCreateString("testFun"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", mxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs", mxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  xResult = emlrtCreateStructMatrix(1, 1, 4, b_fldNames);
  emlrtSetField(xResult, 0, "Version", mxCreateString("9.2.0.556344 (R2017a)"));
  emlrtSetField(xResult, 0, "ResolvedFunctions", (mxArray *)
                emlrtMexFcnResolvedFunctionsInfo());
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}

const mxArray *emlrtMexFcnResolvedFunctionsInfo(void)
{
  const mxArray *nameCaptureInfo;
  const char * data[19] = {
    "789ced5ccb6fe3c619e7b6bb791cd20a68d3a60fb44e1a042d366bc90f79bd690f6bbd655b322dc95eafb7814c91436956e49022a98775f2a9e8b17f40f75e14"
    "28da5b73e8c1ed297f409b43d0432f057aea2d402f054289a2571c7022daa2a8253d0308a3f147cd6fe6f337bfef9b17993bc5d21d8661be617e5e373f672f98",
    "717acbca98d824ff1ae34cb8fcce24ff3e56b6d33de6aee377b6fcb7939c579001068655902002e5aedc009a59409c0caeaa111419220e19b57315301ad015a9"
    "0784b1448412a84119ec2b538502340b726e4a7455188946dfd32dc0b7ab5d99d15afacbe64ad305664a3f9784fedff5a89f5f12f413c3e4cfb21fa73f8a1fe9",
    "40d3e325b6c20966bfe37968ac5480aae8f1fcb9267292a9b407e9da832a94bb126740b3b48384071560fe5d37b42e3ffa53bc067463250584b8617ec975d1aa"
    "3cdd9f33427b5ff3d81f3cb7d39bcc1b53a56f3fb6f10684fabceaef6d025e0c93f38a00b455681a958638695502a869b498d9fd9ed50e3c91da61271bef4f37",
    "c4b3eb2fcfc0b3e5cf8afb2763d36135a5a971f2cac8c64d13daa9edefa4e295f5c4da432e6e288ad4500671204be3cffdb1b6e2f76d75c52d758d2c25383bb9"
    "f8f3179fff632758bb0c7a1c2c0f2fa87157caf5d9638dad159399ed4aa39c1caac2d0986a073b0367563b184239a8fa2f09bfa7fcef4c4e3b7cfff1bcbc6bd7",
    "ff75025e6c22d1bbe3eecdcdf376fdaf61e59778964450ba0d09f8c7f345229e537e6d9e9760232e7386c435e20267706217c54d5d59c6c004caf36f3f1328cf"
    "879ee7ab5038e99c0ec4fda1de1407a5e7c516ea30d1e1793a8edddbefb4bb15dfe2fa770878314c8ec5f588d39a10f1adf6b2e2facb1be25d3b1eb88e9de82d",
    "4e331dbe15d54f627b3cc4bfd25cd0f1c0c5b73eaafc9df2ff82f0e61d87df21e0c530f9f9a05f7cc4e5c46632c11f6495eaf35cf7613f1b1dfebf24fc3eace3"
    "9a64175eed901477bf39c9df71fcf5bdc756fec124ffd0b7f8ff1ea11db18944941465b46a48e37f72dc00a451d430d6d432e286bf1e7d40e3ffb0f3ff76e7e1",
    "41ad236592ed54ab7698af1a9d4c86cf4587ffe938766f3f29febf20d4e7555f3f26e0c5303916ff433dd585925144e5ae0c34c82f8df73f9913ef8488e794fb"
    "b3be8fab6d55a6ebfcd1c00b8aff0f7a9df48e58e86dd70e37cff9ac8cd673a75281f2ffede2fff77de3ff1f10f062981ce37f9de7244e5bb5a3fee5edefcecb",
    "ff4733f06cb93ffc7fdfd2db94ed04c8ffbf7ff23dcaff61e7ff466b8b3d419221541539db45858d4636b59ba7fc7f5bf9ff3784fabceaeb6704bc1826c7f89f"
    "5355e9bc3a26b35c178d37bc8b889538de3e3266b74f9db37ddf9cd13e5b2e4e5a516f714830270836fea773e23766e0db727ffc0359adb6a10568675ffc97ce",
    "1742ef2f0afd4cba32d81e6e285c01ece68c6dfe404c45c85fd0f1edde2f6ff6b81ab979c4b2d691e83c62517856ba2d78741ee14ffd6198472cff1cd17bbeed"
    "0fbf4ec08b4d24661f554d117ce3f7bb58f9259e25e15bdcd8a1f8c5efc7443ca77c640fecbc06a16ab0c719203e515ac0f7017ec8d173a2a1e7f75661b3a426",
    "734292ad6ea73787e2690bf49299e8f03b1dcfeeb99d9cf697a0fbc50cdd2f9e6eb7073f40f78b178847f78bfda99ffa01f7dc4e4efbdbf0edde8057fb33fbc9"
    "035daf4fba5c8748ed1aba7feb3cd79d07ccbb5e08b032833d67cb7db517772506bceec3fc3ff13fea0fc2ee0f40adadb53b25b4d92d2a1565bdc5f2837d3d42",
    "eb3e747cbbf7cb9b3daed37b6537c4b3eb7fd5ee9f9c11da4bef9585038fde2bf3a77eea17dcfbe5cd1e7f7ee5177e4da8cfab1e7f42c08b6172cc2f8cdfac51"
    "565015a2a6040c0565a0b563b2ac75a4cb39f116e22788eb486eea0bdc4fd0f5a405e205e527328383bddda3a779cd486cf59f1ff3f0c96ef16984f615a89f70",
    "ef97377bccf9367ff82e012f86c95dcf13659ba1bd87cc6265067bce96fbe3176c7505baaff0e2c53fa91f08bb1f4894fb0fe51a944ff76045c8ee65f8aa289e"
    "a7a2e307e838766fbfc3ee2e4a577caf12eaf3aaafb7b032833d67cba18eacad5063f426daf0be6fe28088e794dfe87c990807405015d33ce20e7d99114180f6",
    "f1077a4e34fc3c9fdf689f573b4d28a56be976a5936ad6da47d908c5fb94e7dddb4fe279129e577dbd819599abe72c09d44568ce725a61e5f55d229e533e3faf"
    "5b7a5ac2bd11caeb0bc40bea3da2bd0ec8aa3d5e7f74d2df501456afae6d3c3d65a2c3ebe13ae7f792d7df15a1a61b220cd4fefe75e61bbfcf3a8f33e2ad51be",
    "2c7effdd9c7839229e53ee07bf077c3eec13ba3effeaf2bad778bd7aae4239d9a93c59830d61b3787ac896d67a118ad7e9f87526d239ffb0afc75cf75c275d8f"
    "716f3f8ddb83c1a3eb31fed44fcff3bbe77672da5f21b0fbbb50079d2e278576bd7d8f88e794cff75e28f34b7ca2a9c9c24c80fbaa347e5f205e60f1fb51a76b",
    "948bc7c74795eae196d6d929240147f7556fd1381ea515dfe278d2ff2786e5a60aea931ed7794503613d57f93111cf299fcbff5b06627b7f5c75419fbbda39a3"
    "f7b242cffb29bdb20164304c1d1792a75ce6101d1a5bb908ddd3bd24fc9e8e6b6772dae14fe97dac1be2d9f5d3fb588bc6b3d26dc1a3f7b1fca99faef3b8e776",
    "72da5fc9373fe0fd5cbddc8008d47b803714ad0e2433384186cef8352f59f67b9dc519f8b6dc57fb212835607bfadb2f563ea3fe614178419ddf618bc5470765"
    "b6fff4b0ac412873fb48caab4c74fc031ddfeefdf2648f8fab57fee282509f573dfe888017c3e4e3c91232eaa2a2498aa2d6951ed04449e9d7f916e0dbf3ef0b",
    "e329a8f9c31956c6f16cf95ceb8dd6b1b0afd05fa0f7b3fef2ef7bd43fbcaafec1ebfc41dfcb0eb299e190dd1dac6f96d613e9c39db54484e60fff21fcdeab1e"
    "7f45a83f86c9173daedffdea07ea2d20a9400bda5ef34b3b0fbaa47bc31009605044063d674668373d271a0c1e3d27ea4ffdd43f38dbebafbd167df30fb3f687",
    "cdaecbdc20bce74a177a1fcc795e61aca925dc07fb233d571a7e7f200db64e41e2f941e208a612b5fe708ddb94d808ed3f537fe06cafbff78383f50710517fe0"
    "cd1f4044fd41b4f082f207c962a9adb6cb6060144ad5269bdf63f3092902e750bf042e7db4eb",
    "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(data, 40312U, &nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_testFun_info.c) */
