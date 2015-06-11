% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1834.982566594790100 ; 1840.126401445344300 ];
camR.f = mean(fc);
%-- Principal point:
cc = [ 1463.788543422015700 ; 991.790475398290940 ];
camR.c = cc';
%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.074779317538046 ; -0.522802216877433 ; 0.014687197515514 ; 0.023315526928305 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 25.594133302552933 ; 21.459492601564090 ];

%-- Principal point uncertainty:
cc_error = [ 33.844910328384202 ; 29.264908432020416 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.087732514713999 ; 1.076571463104891 ; 0.004711084530169 ; 0.005451014543039 ; 0.000000000000000 ];

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
omc_1 = [ 2.109946e+00 ; 2.179564e+00 ; -5.337366e-01 ];
Tc_1r  = [ -2.297558e+02 ; -1.820600e+02 ; 3.346794e+03 ];
omc_error_1 = [ 1.051293e-02 ; 1.481943e-02 ; 3.078384e-02 ];
Tc_error_1  = [ 6.178080e+01 ; 5.312910e+01 ; 4.566885e+01 ];
rot1r = rodrigues(omc_1);
camR.R = rodrigues(omc_1);
%-- Image #2:
omc_2 = [ -1.896247e+00 ; -2.052281e+00 ; 8.287345e-01 ];
Tc_2r  = [ -3.098787e+02 ; -1.829559e+02 ; 3.185918e+03 ];
omc_error_2 = [ 1.725321e-02 ; 1.215124e-02 ; 2.545286e-02 ];
Tc_error_2  = [ 5.886989e+01 ; 5.083076e+01 ; 3.865880e+01 ];
rot2r = rodrigues(omc_2);

%-- Image #3:
omc_3 = [ 2.078769e+00 ; 2.134766e+00 ; -1.222711e-01 ];
Tc_3r  = [ -2.475452e+02 ; -2.287063e+02 ; 3.050238e+03 ];
omc_error_3 = [ 1.301404e-02 ; 1.462338e-02 ; 2.850978e-02 ];
Tc_error_3  = [ 5.621137e+01 ; 4.824592e+01 ; 4.168204e+01 ];
rot3r = rodrigues(omc_3);

%-- Image #4:
omc_4 = [ 1.950706e+00 ; 1.947514e+00 ; 3.950049e-02 ];
Tc_4r  = [ -3.747821e+02 ; -2.266995e+02 ; 2.927817e+03 ];
omc_error_4 = [ 1.311921e-02 ; 1.397501e-02 ; 2.079744e-02 ];
Tc_error_4  = [ 5.402174e+01 ; 4.652298e+01 ; 4.061229e+01 ];
rot4r = rodrigues(omc_4);

%-- Image #5:
omc_5 = [ 1.505967e+00 ; 1.768536e+00 ; -9.916514e-01 ];
Tc_5r  = [ -1.692792e+02 ; 5.453605e+01 ; 3.342632e+03 ];
omc_error_5 = [ 9.111740e-03 ; 1.751804e-02 ; 1.946190e-02 ];
Tc_error_5  = [ 6.154746e+01 ; 5.315941e+01 ; 4.370740e+01 ];
rot5r = rodrigues(omc_5);

%-- Image #6:
omc_6 = [ 1.346053e+00 ; 2.058495e+00 ; -1.432321e+00 ];
Tc_6r  = [ -1.070610e+02 ; 7.122283e+01 ; 3.277358e+03 ];
omc_error_6 = [ 8.288576e-03 ; 1.967770e-02 ; 2.079232e-02 ];
Tc_error_6  = [ 6.035625e+01 ; 5.206333e+01 ; 3.915872e+01 ];
rot6r = rodrigues(omc_6);

%-- Image #7:
omc_7 = [ -1.867988e+00 ; -2.240828e+00 ; 1.041776e+00 ];
Tc_7r  = [ -3.357409e+02 ; -1.415234e+02 ; 3.083960e+03 ];
omc_error_7 = [ 1.882891e-02 ; 1.213869e-02 ; 2.444948e-02 ];
Tc_error_7  = [ 5.695097e+01 ; 4.925576e+01 ; 3.766287e+01 ];
rot7r = rodrigues(omc_7);

%-- Image #8:
omc_8 = [ 1.892098e+00 ; 2.229875e+00 ; -7.977637e-01 ];
Tc_8r  = [ -1.561014e+02 ; -1.821175e+02 ; 3.143531e+03 ];
omc_error_8 = [ 7.407824e-03 ; 1.616889e-02 ; 2.688724e-02 ];
Tc_error_8  = [ 5.797567e+01 ; 4.981956e+01 ; 4.120427e+01 ];
rot8r = rodrigues(omc_8);
