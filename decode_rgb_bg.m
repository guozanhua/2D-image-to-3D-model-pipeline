
scandir = 'C:\\Users\\Yuki\\Documents\\MATLAB\\117\\proj\\mann\\set_07\\'
% scandir = 'C:\\Users\\Yuki\\Documents\\MATLAB\\117\\proj\\teapot\\set_4\\'

I = imread(sprintf('%sl_rgb.jpg',scandir));
In = imread(sprintf('%sl_rgb_bg.jpg',scandir));
I = im2double(rgb2gray(I));
In = im2double(rgb2gray(In));
diff = abs(I-In);
diff2 = abs(I-In)./abs(In);
thresh = [0.01:0.01:0.3];
for i = 1:size(thresh,2)
    thresh(i)
    goodpixels = (diff > thresh(i));
    goodpixels2 = (diff2 > thresh(i));
    figure(1);
    subplot(1,2,1); imagesc(goodpixels); axis image;
    subplot(1,2,2); imagesc(goodpixels2); axis image; 
    drawnow;
    pause;
end

% goodpixels1 = (diff>0.04);
% goodpixels2 = (diff>0.239);
% goodpixels3 = (diff>0.06);\
% goodpixels4 = (diff>0.08);
% figure(1);
% imagesc(goodpixels1);
% % % figure(2);
%  imagesc(goodpixels2);
% figure(3);
% imagesc(goodpixels3);
% figure(4);
% imagesc(goodpixels4);

%% Write to PLY file using PLY IO
plyfile = 'teapot_set9.ply';
ply_data = tri_mesh_to_ply(Y,tri')
ply_write( ply_data, plyfile, 'ascii');
%%
% trisurf ( Y, tri(1,:), tri(2,:), tri(3,:) );
trisurf(tri,Y(1,:),Y(2,:),Y(3,:));
axis equal;
%%

      node_xyz = [ 0,0,0; 1,0,0; 1,1,0; 0,1,0; 0.5,0.5,1.6 ]';
%
     triangle_node = [ 2,1,4; 2,4,3; 1,2,5; 1,5,4; 4,5,3; 2,3,5 ]';
%
%    It can be viewed with these MATLAB commands:
%
      trisurf ( triangle_node', node_xyz(1,:), node_xyz(2,:), node_xyz(3,:) );
      axis equal;
%
%    The TRI_MESH data can be converted to PLY format:
%
      ply_data = tri_mesh_to_ply ( node_xyz, triangle_node );
%
%    The PLY data can be written to a PLY file.
%
      ply_write ( ply_data, 'pyramid.ply', 'ascii' );