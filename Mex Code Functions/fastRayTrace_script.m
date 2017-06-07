% FASTRAYTRACE_SCRIPT   Generate MEX-function fastRayTrace_mex from
%  fastRayTrace.
% 
% Script generated from project 'fastRayTrace.prj' on 07-Jun-2017.
% 
% See also CODER, CODER.CONFIG, CODER.TYPEOF, CODEGEN.

%% Create configuration object of class 'coder.MexCodeConfig'.
cfg = coder.config('mex');
cfg.GenerateReport = true;
cfg.ReportPotentialDifferences = false;

%% Define argument types for entry-point 'fastRayTrace'.
ARGS = cell(1,1);
ARGS{1} = cell(7,1);
ARGS{1}{1} = coder.typeof(0,[1 3]);
ARGS{1}{2} = coder.typeof(0,[1 3]);
ARGS{1}{3} = coder.typeof(0,[1 3]);
ARGS{1}{4} = coder.typeof(0,[1 3]);
ARGS{1}{5} = coder.typeof(0,[1 3]);
ARGS{1}{6} = coder.typeof(0,[Inf Inf Inf],[1 1 1]);
ARGS{1}{7} = coder.typeof(0);

%% Invoke MATLAB Coder.
codegen -config cfg fastRayTrace -args ARGS{1}

