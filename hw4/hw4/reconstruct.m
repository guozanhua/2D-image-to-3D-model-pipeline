%% Problem 2 (30pts): 
% Write a MATLAB script called reconstruct.m that takes a set of images from the pair of cameras and produces the 3D coordinates
% decode the horizontal and vertical test images
[Lv_C, Lv_goodpixels] = decode('left/left_',1,20,0.02);
[Lh_C, Lh_goodpixels] = decode('left/left_',21,40,0.02);
[Rv_C, Rv_goodpixels] = decode('right/right_',1,20,0.02);
[Rh_C, Rh_goodpixels] = decode('right/right_',21,40,0.02);

% load the left and riggt camera calibrations for the images
load scan0_calibration.mat

%% For each pixel in the left image which was succesfully decoded, find the match in the right image.
w = size(Lv_C,2); h = size(Lv_C,1);
[xx,yy] = meshgrid(1:w,1:h); %create arrays containing the pixel coordinates
R_C = Rh_C + 1024*Rv_C;    %turn the horizontal and vertical coordinates into a unique per-pixel index
L_C = Lh_C + 1024*Lv_C;
R_goodpixels = Rh_goodpixels & Rv_goodpixels; %identify pixels which have both good horiztonal and vertical codes
L_goodpixels = Lh_goodpixels & Lv_goodpixels;
R_sub = find(R_goodpixels);     % find the indicies of pixels which were succesfully decoded
L_sub = find(L_goodpixels);

%intersect these sets to find those of pixels that were good in both the left and right images
[matched,iR,iL] = intersect(R_C(R_sub),L_C(L_sub));  

xR(1,:) = xx(R_sub(iR(:)));  % pull out the x,y coordinates of those matched pixels
xR(2,:) = yy(R_sub(iR(:)));
xL(1,:) = xx(L_sub(iL(:)));
xL(2,:) = yy(L_sub(iL(:)));

%% use triangluate to get the 3D coordinates for the set of pixels

X = triangulate(xL,xR,camL,camR);
% save workspace;