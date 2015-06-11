%% make gray code table
for i=1:1023
    grayCodeTable(binary2gray(i)) = i;
end

%% PART 1
[Lv_C, Lv_goodpixels] = decode('left/left_',1,20,0.02);
[Lh_C, Lh_goodpixels] = decode('left/left_',21,40,0.02);
[Rv_C, Rv_goodpixels] = decode('right/right_',1,20,0.02);
[Rh_C, Rh_goodpixels] = decode('right/right_',21,40,0.02);
%%
w = 1632; h = 1224;
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
%% do triangulation
Xrecov = triangulate(xL,xR,camL,camR);figure(3); clf;
X = Xrecov;
plot3(Xrecov(1,:),Xrecov(2,:),Xrecov(3,:),'ro');
axis image;
axis vis3d;
grid on;
legend('original points','recovered points')

%
%display results as a surface
%
figure(4);
trisurf(tri,X(1,:),X(2,:),X(3,:));
axis equal; axis vis3d; grid on;
title('original shape');
subplot(2,1,2);
tri = delaunay(Xrecov(1,:),Xrecov(2,:));
trisurf(tri,Xrecov(1,:),Xrecov(2,:),Xrecov(3,:));
axis equal; axis vis3d; grid on;
title('recovered shape');
%% delaunay
xpts = xL(1,:);
ypts = xL(2,:);
tri = delaunay(xpts,ypts);
% trisurf(tri,X(1,:),X(2,:),X(3,:),'ro') 
%% prune long edges
d = zeros(3,size(X,2));
for i=1:size(X,2)
    a = X(:,tri(i,1));
    b = X(:,tri(i,2));
    c = X(:,tri(i,3));
    d(:,i) = [dist(a,b),dist(b,c),dist(c,a)];
end
% mean(mean(d)) = 0.0990

xd = find(d(1,:)<0.0101);
yd = find(d(2,:)<0.0101);
zd = find(d(3,:)<0.0101);
commond = union(xd,yd);
commond = union(zd,commond);
out = X(:,commond);
out2 = xL(:,commond);
%  prune out of bound edges

for i=1:3
    coords = find((out(i,:) > 0));
    out = out(:,coords);
    out2 = out2(:,coords);
end
for i=1:3
    coords = find((out(i,:) < 20));
    out = out(:,coords);
    out2 = out2(:,coords);
end
% plot3(out(1,:), out(2,:), out(3,:),'ro');
xpts = out2(1,:);
ypts = out2(2,:);
cleantri = delaunay(xpts,ypts);

figure(1); clf;
h = trisurf(cleantri,out(1,:),out(2,:),out(3,:));
set(h,'edgecolor','none')
set(gca,'projection','perspective')
set(gcf,'renderer','opengl')
axis image; axis vis3d;
camorbit(120,0); camlight left;
camorbit(120,0); camlight left;
lighting phong;
material dull;
% %% draw uncleaned pretty graph
figure(2); clf;
h = trisurf(tri,X(1,:),X(2,:),X(3,:));
set(h,'edgecolor','none')
set(gca,'projection','perspective')
set(gcf,'renderer','opengl')
axis image; axis vis3d;
camorbit(120,0); camlight left;
camorbit(120,0); camlight left;
lighting phong;
material dull;


%%
imagesc(goodpixels);
colormap('gray');
%% conver 1 to 01, 5 to 05, for string processing file names
for i=1:9
    if i <= 9
        str = sprintf('0%d',i)
    else
        str = sprintf('%d',i)
    end
end

sprintf('%s%d.jpg',imageprefix,2*i + 1);

    

%%
imfile = 'left/left_01.jpg';
I1 = im2double(rgb2gray(imread(imfile)));
figure(1);  clf;
imagesc(I1); axis image; colormap ('gray');
imfile = 'left/left_02.jpg';
I2 = im2double(rgb2gray(imread(imfile)));
figure(2);  clf;
imagesc(I2); axis image; colormap ('gray');

I = I1 > I2;
figure(3);
imagesc(I);
colormap ('gray');

diff = abs(I1-I2);

bad = (diff < 0.02);

figure(4)
imagesc(bad); colormap ('gray');
%%
disp('--------------------------------------------------')
images = [];
for i=0:9
%     imagestr1 = sprintf('left_%d',2*i+1);
%     imagestr2 = sprintf('left_%d',2*i+2);
%     str = strcat(imagestr1,'/',imagestr2);
    if (i <= 3)
        imfile1 = sprintf('left/left_0%d.jpg',2*i + 1);
        imfile2 = sprintf('left/left_0%d.jpg',2*i + 2);
        str = strcat(imfile1,'/',imfile2)
    elseif (i == 4)
        imfile1 = sprintf('left/left_0%d.jpg',2*i + 1);
        imfile2 = sprintf('left/left_%d.jpg',2*i + 2);
        str = strcat(imfile1,'/',imfile2)
    else
        imfile1 = sprintf('left/left_%d.jpg',2*i + 1);
        imfile2 = sprintf('left/left_%d.jpg',2*i + 2);
        str = strcat(imfile1,'/',imfile2)
    end
    
    I1 = im2double(rgb2gray(imread(imfile1)));
    I2 = im2double(rgb2gray(imread(imfile2)));
    I = I1 > I2;
    images{i+1} = I;
    bad{i+1} = (abs(I1-I2) < 0.02);
end

totalbad = [];
totalbad = bad{1};
for i=2:10
    totalbad = totalbad + bad{i};
end
goodpixels = (totalbad < 1);
BCD = [];
% convert bits to decimals
BCD = images{1};
for i=2:10
    BCD = BCD + (2^(i-1))*images{i};
end
% images{1} + 2*images{2} + 4*images{3}
%% turn gray code decimal into true decimals
trueBCD = zeros(size(BCD,1),size(BCD,2));
for i=1:size(BCD,1)
    for j=1:size(BCD,2)
        trueBCD(i,j) = gray2int(BCD(i,j));
    end
end

%%
for i=0:20
    imagestr1 = sprintf('left_%d',2*i+1);
    imagestr2 = sprintf('left_%d',2*i+2);
    imfile = sprintf('left/%s.jpg',imagestr1);
    I = im2double(rgb2gray(imread(imfile)));
    figure(1);  clf;
    imagesc(I); axis image; colormap ('gray');
end