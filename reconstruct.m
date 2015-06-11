function [X, xR, xL, xColor] = reconstruct(dir,setnumber,threshold,rgb_threshold)

% load camera calibration
load('camera_mann_stereo');
 
scanset = sprintf('set_0%d',setnumber);
scandir = [dir scanset '\\'];

threshold = 0.001;
rgb_threshold = 0.055;
[R_h,R_h_good] = decode([scandir 'r_'],1,10,threshold,rgb_threshold);
[R_v,R_v_good] = decode([scandir 'r_'],11,20,threshold,rgb_threshold);
[L_h,L_h_good] = decode([scandir 'l_'],1,20,threshold,rgb_threshold);
[L_v,L_v_good] = decode([scandir 'l_'],11,20,threshold,rgb_threshold);
%
% combine horizontal and vertical codes
% into a single code and mask.
%
Rmask = R_h_good & R_v_good;
R_code = R_h + 1024*R_v;
Lmask = L_h_good & L_v_good;
L_code = L_h + 1024*L_v;
%
% now find those pixels which had matching codes
% and were visible in both the left and right images
%
% only consider good pixels
Rsub = find(Rmask(:));
Lsub = find(Lmask(:));
% find matching pixels 
[matched,iR,iL] = intersect(R_code(Rsub),L_code(Lsub));
indR = Rsub(iR);
indL = Lsub(iL);
% indR,indL now contain the indices of the pixels whose 
% code value matched

% pull out the pixel coordinates of the matched pixels
[h,w] = size(Rmask);
[xx,yy] = meshgrid(1:w,1:h);
xL = []; xR = [];
xR(1,:) = xx(indR);
xR(2,:) = yy(indR);
xL(1,:) = xx(indL);
xL(2,:) = yy(indL);

%
% while we are at it, we can use the same indices (indR,indL) to
% pull out the colors of the matched pixels
%

% array to store the (R,G,B) color values of the matched pixels
xColor = zeros(3,size(xR,2));

% load in the images and seperate out the red, green, blue
% color channels into separate matrices
rgbL = imread([scandir 'l_rgb.jpg']);
rgbL_R = rgbL(:,:,1); 
rgbL_G = rgbL(:,:,2);
rgbL_B = rgbL(:,:,3);

rgbR = imread([scandir 'r_rgb.jpg']);
rgbR_R = rgbR(:,:,1);
rgbR_G = rgbR(:,:,2);
rgbR_B = rgbR(:,:,3);

% use the average of the color in the left and 
% right image.  depending on the scan, it may
% be better to just use one or the other.
xColor(1,:) = 0.5*(rgbR_R(indR) + rgbL_R(indL));
xColor(2,:) = 0.5*(rgbR_G(indR) + rgbL_G(indL));
xColor(3,:) = 0.5*(rgbR_B(indR) + rgbL_B(indL));


%
% now triangulate the matching pixels using the calibrated cameras
%
[Xa, Xb] =  stereo_triangulation(xL,xR,om,T,fc_left,cc_left,kc_left,alpha_c_left,fc_right,cc_right,kc_right,alpha_c_right);
X = 0.5*(Xa+Xb);
% X = triangulate(xL,xR,camL,camR);
Xold = X;
xRold = xR;
xLold = xL;
xColorold = xColor;
%
% save the results of all our hard work
%
% save([scanset '.mat'],'X','xColor','xL','xR','om','T','fc_left','cc_left','kc_left','alpha_c_left','fc_right','cc_right','kc_right','alpha_c_right');
% fprintf(' ============ reconstruct.M DONE! ============\n');
% mesh
% part3
%
%plot3(X(1,:), X(2,:), X(3,:))

 