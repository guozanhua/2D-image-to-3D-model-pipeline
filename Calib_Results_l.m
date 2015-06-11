c% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1843.463722950638200 ; 1831.060188472588600 ];
camL.f = mean(fc);
%-- Principal point:
cc = [ 1457.180947340274300 ; 907.728368229318560 ];
camL.c = cc';
%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.067660205164109 ; 0.042540411513189 ; 0.004864952869793 ; 0.013957385530073 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 33.349812118312649 ; 29.525699655280665 ];

%-- Principal point uncertainty:
cc_error = [ 55.834372877013024 ; 48.799936036275909 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.090252344111123 ; 0.411098571762569 ; 0.007510227085346 ; 0.010183003306672 ; 0.000000000000000 ];

%-- Image size:
nx = 2736;
ny = 1824;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 8;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 1.879510e+00 ; 1.687184e+00 ; 1.901256e-01 ];
Tc_1l  = [ -8.540793e+02 ; -2.157167e+01 ; 2.936587e+03 ];
omc_error_1 = [ 2.213462e-02 ; 1.969724e-02 ; 3.010863e-02 ];
Tc_error_1  = [ 9.032617e+01 ; 8.023056e+01 ; 5.330009e+01 ];
camL.R = rodrigues(omc_1);

%-- Image #2:
omc_2 = [ 2.049945e+00 ; 1.944643e+00 ; -1.165775e-01 ];
Tc_2l  = [ -8.030443e+02 ; -2.979610e+01 ; 2.765212e+03 ];
omc_error_2 = [ 1.615558e-02 ; 2.051560e-02 ; 3.673551e-02 ];
Tc_error_2  = [ 8.442238e+01 ; 7.544382e+01 ; 5.022878e+01 ];
rot2l = rodrigues(omc_2);

%-- Image #3:
omc_3 = [ 1.732265e+00 ; 1.631841e+00 ; 5.290559e-01 ];
Tc_3l  = [ -6.654649e+02 ; -8.361448e+01 ; 2.703608e+03 ];
omc_error_3 = [ 2.623836e-02 ; 1.941570e-02 ; 2.898709e-02 ];
Tc_error_3  = [ 8.287193e+01 ; 7.346829e+01 ; 4.985002e+01 ];
rot3l = rodrigues(omc_3);

%-- Image #4:
omc_4 = [ 1.601439e+00 ; 1.414153e+00 ; 6.220053e-01 ];
Tc_4l  = [ -6.799458e+02 ; -8.644288e+01 ; 2.533102e+03 ];
omc_error_4 = [ 2.666201e-02 ; 2.009638e-02 ; 2.690166e-02 ];
Tc_error_4  = [ 7.799865e+01 ; 6.913201e+01 ; 4.845157e+01 ];
rot4l = rodrigues(omc_4);

%-- Image #5:
omc_5 = [ 1.590094e+00 ; 1.187457e+00 ; -3.800128e-01 ];
Tc_5l  = [ -8.006268e+02 ; 2.129944e+02 ; 2.974221e+03 ];
omc_error_5 = [ 2.027786e-02 ; 2.414776e-02 ; 2.718525e-02 ];
Tc_error_5  = [ 9.072663e+01 ; 8.174456e+01 ; 5.139105e+01 ];
rot5l = rodrigues(omc_5);

%-- Image #6:
omc_6 = [ 1.574815e+00 ; 1.513031e+00 ; -7.845723e-01 ];
Tc_6l  = [ -7.110940e+02 ; 2.260673e+02 ; 2.971214e+03 ];
omc_error_6 = [ 1.634604e-02 ; 2.647419e-02 ; 2.969011e-02 ];
Tc_error_6  = [ 9.015059e+01 ; 8.119818e+01 ; 4.744411e+01 ];
rot6l = rodrigues(omc_6);

%-- Image #7:
omc_7 = [ 1.891751e+00 ; 1.822540e+00 ; -2.943902e-01 ];
Tc_7l  = [ -7.533645e+02 ; 5.286941e+00 ; 2.675951e+03 ];
omc_error_7 = [ 1.529110e-02 ; 2.198528e-02 ; 3.250962e-02 ];
Tc_error_7  = [ 8.139810e+01 ; 7.296912e+01 ; 4.753174e+01 ];
rot7l = rodrigues(omc_7);

%-- Image #8:
omc_8 = [ 1.789978e+00 ; 1.707083e+00 ; -8.646353e-02 ];
Tc_8l  = [ -6.621884e+02 ; -3.455917e+01 ; 2.838446e+03 ];
omc_error_8 = [ 1.915876e-02 ; 2.173883e-02 ; 3.106638e-02 ];
Tc_error_8  = [ 8.642065e+01 ; 7.679839e+01 ; 4.992620e+01 ];
rot8l = rodrigues(omc_8);