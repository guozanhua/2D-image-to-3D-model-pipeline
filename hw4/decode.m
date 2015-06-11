function [C,goodpixels] = decode(imageprefix,start,stop,threshold)
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

images = [];
badpixels = [];
% load the images and check if first image is greater than the second. 
% also check for undecodable pixels, using the threshold parameter 
if start == 21
    for i=10:19
        imfile1 = sprintf('%s%d.jpg',imageprefix,2*i + 1);
        imfile2 = sprintf('%s%d.jpg',imageprefix,2*i + 2);
        I1 = im2double(rgb2gray(imread(imfile1)));
        I2 = im2double(rgb2gray(imread(imfile2)));
        images{i-9} = I1 > I2;
        badpixels{i-9} = (abs(I1-I2) < threshold);
    end
end

if start == 1
    for i=0:9
        if (i <= 3)
            imfile1 = sprintf('%s0%d.jpg',imageprefix,2*i + 1);
            imfile2 = sprintf('%s0%d.jpg',imageprefix,2*i + 2);
        elseif (i == 4)
            imfile1 = sprintf('%s0%d.jpg',imageprefix,2*i + 1);
            imfile2 = sprintf('%s%d.jpg',imageprefix,2*i + 2);
        else
            imfile1 = sprintf('%s%d.jpg',imageprefix,2*i + 1);
            imfile2 = sprintf('%s%d.jpg',imageprefix,2*i + 2);
        end

        I1 = im2double(rgb2gray(imread(imfile1)));
        I2 = im2double(rgb2gray(imread(imfile2)));

        images{i+1} = I1 > I2;
        badpixels{i+1} = (abs(I1-I2) < threshold);
    end
end

% find the undecodable pixels
totalbadpixels = zeros(size(badpixels{1},1),size(badpixels{1},2));
for i=1:10
    totalbadpixels = totalbadpixels + badpixels{i};
end
goodpixels = (totalbadpixels == 0);


% convert bits to decimals
BCD = zeros(size(badpixels{1},1),size(badpixels{1},2));
for i=1:10
    BCD = BCD + (2^(i-1))*images{i};
end

%% make gray code table using binary2gray function
grayCodeTable = zeros(1,1023);
for i=1:1023
    grayCodeTable(binary2gray(i)) = i;
end

%% turn gray code decimal into true decimals
C = zeros(size(BCD,1),size(BCD,2));
for i=1:size(BCD,1)
    for j=1:size(BCD,2)
        if(BCD(i,j) == 0)
            C(i,j) = 0;
        else
            C(i,j) = grayCodeTable(BCD(i,j));
        end
    end
end
