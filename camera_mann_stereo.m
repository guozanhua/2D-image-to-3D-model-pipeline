% Stereo calibration parameters after loading the individual calibration files:
% MANNEQUIN

% Intrinsic parameters of left camera:

%          
fc_left = [ 1843.46296   1831.05933 ];
% ± [ 33.34960   29.52549 ]
%        
cc_left = [ 1457.18240   907.72981 ];
% ± [ 55.83387   48.79968 ]
%Skew:            
alpha_c_left = [ 0.00000 ] ;
% ± [ 0.00000  ]   => angle of pixel axes = 90.00000 ± 0.00000 degrees
%Distortion:          
kc_left = [ -0.06766   0.04253   0.00487   0.01396  0.00000 ];
% ± [ 0.09025   0.41110   0.00751   0.01018  0.00000 ]
camL.f  = mean([ 1843.463722950638200 ; 1831.060188472588600 ]);
camL.c = [ 1457.180947340274300 ; 907.728368229318560 ]';
%Intrinsic parameters of right camera:

%Focal Length:         
fc_right = [ 1834.98258   1840.12641 ] ;
% ± [ 25.59413   21.45949 ]
%Principal point:       
cc_right = [ 1463.78849   991.79014 ];
% ± [ 33.84495   29.26491 ]
%Skew:             
alpha_c_right = [ 0.00000 ];
% ± [ 0.00000  ]
% => angle of pixel axes = 90.00000 ± 0.00000 degrees
%Distortion:           
kc_right = [ -0.07478   -0.52281   0.01469   0.02332  0.00000 ] ;
% ± [ 0.08773   1.07657   0.00471   0.00545  0.00000 ]
camR.f = mean([ 1834.982566594790100 ; 1840.126401445344300 ]);
camR.c  = [ 1463.788543422015700 ; 991.790475398290940 ]';
%Extrinsic parameters (position of right camera wrt left camera):

%Rotation vector:             
om = [ 0.03876   0.74250  0.02364 ];
camR.R = rodrigues(om);
%Translation vector:          
T = [ -476.62914   -15.05662  182.24336 ]';
camR.t = T';
camL.R = eye(3);
camL.t = zeros(3,1);