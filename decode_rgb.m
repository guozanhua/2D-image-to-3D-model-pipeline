
function [C,goodpixels] = decode(imageprefix,start,stop,threshold)

% function [C,goodpixels] = decode(imageprefix,start,stop,threshold)
%
%
% Input:
%
% imageprefix : a string which is the prefix common to all the images.
%
%                  for example, pass in the prefix '/home/fowlkes/left/left_'  
%                  to load the image sequence   '/home/fowlkes/left/left_01.jpg' 
%                                               '/home/fowlkes/left/left_02.jpg'
%                                                          etc.
%
%  start : the first image # to load
%  stop  : the last image # to load
% 
%  threshold : the pixel brightness should vary more than this threshold between the positive
%             and negative images.  if the absolute difference doesn't exceed this value, the 
%             pixel is marked as undecodeable.
%
% Output:
%
%  C : an array containing the decoded values (0..1023) 
%
%  goodpixels : a binary image in which pixels that were decodedable across all images are marked with a 1.


I = imread(sprintf('%s%2.2d.jpg',imageprefix,start));
[h,w,d] = size(I);
goodpixels = ones(h,w);


%% calculate goodpixels using rgb bg
I = imread(sprintf('%srgb.jpg',imageprefix));
In = imread(sprintf('%srgb_bg.jpg',imageprefix));
I = im2double(rgb2gray(I));
In = im2double(rgb2gray(In));
goodpixels = goodpixels.*(abs(I-In) > 0.1);


figure(1);
subplot(1,2,2); imagesc(goodpixels); axis image; title('goodpixels');
drawnow;

% %% calculate goodpixels using rgb bg
% I = imread(sprintf('%srgb.jpg',imageprefix));
% In = imread(sprintf('%srgb_bg.jpg',imageprefix));
% I = im2double(rgb2gray(I));
% In = im2double(rgb2gray(In));
% goodpixels = goodpixels.*(abs(I-In) > 0.08);
% 
% %% plot goodpixels
%   figure(1);
%   subplot(1,2,1); imagesc(Ib(:,:,bit)); axis image; title(sprintf('bit %d',bit));
%   subplot(1,2,2); imagesc(goodpixels); axis image; title('goodpixels');
%   drawnow;
%   
%
%
% build up a table of gray code values
% X maps an integer to its binary gray code sequence
%
X = dec2gray(0:1023,10);

% Xdec maps an integer to its decimal gray code value
Xdec = X*(2.^(0:9)');

% Xdecinv maps a decimal gray code value back to an integer
% it is the "inverse" of Xdec
[val,Xdecinv] = sort(Xdec);

% reshape Ib from (h,w,nbits) to (nbits,h,w)
% and then collapse the last two dimensions 
% to make its dimension (nbits,h*w)
Ib = shiftdim(Ib,2);
Ib = Ib(1:10,:);

% convert the binary into a decimal
Ib = Ib'*(2.^(0:9)')+1;

% now look up the results in our table Xinv
% and reshape it back into the original image
% dimensions 
C = reshape( Xdecinv(Ib) ,h,w);

