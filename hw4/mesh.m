%% Problem 3 (40pts): To display the reconstructed scan as a surface, we need to generate triangular faces of the mesh which connect up 
% the points. Write a script mesh.m that  the output of reconstruct.m and produces a triangulated mesh. 
% Your mesh should be represented by a list of points (vertices) and a list of triplets of points (triangular faces).

% To find the faces of your mesh, we will use the 2D coordinates of the points as they were visible in the left image (xL).
% Use the MATLAB function delaunay on these 2D coordinates to get the list of triangles.  

%% do delaunay on 2D coordinates to create list of triangles to connect the 3D points into meshes
xpts = xL(1,:);
ypts = xL(2,:);
tri = delaunay(xpts,ypts);

% %% UNUSED CODE
% angle = @(v,n) atan2(norm(cross(v,n)), dot(v,n)).*(180/pi);
% angle([1 2 0],[1 0 0])
% %% find wide angles
% 
% angle = @(v,n) atan2(norm(cross(v,n)), dot(v,n)).*(180/pi);
% angle([1 2 0]',[1 0 0]')
% ang = zeros(3,size(Xpruned,2));
% pause
% for i=1:size(Xpruned,2)
%     a = Xpruned(:,tri(i,1))
%     b = Xpruned(:,tri(i,2))
%     c = Xpruned(:,tri(i,3))
%     ang(:,i) = [angle(a,b),angle(b,c),angle(c,a)];
%     pause;
% end
% tri = delaunay(xLpruned(1,:), xLpruned(2,:));

%% prune long edges

Xpruned = X;
xLpruned = xL;
% find the 3 distances between the 3 points consisting of a triangle
d = zeros(3,size(Xpruned,2));
for i=1:size(Xpruned,2)
    a = Xpruned(:,tri(i,1));
    b = Xpruned(:,tri(i,2));
    c = Xpruned(:,tri(i,3));
    d(:,i) = [distance(a,b),distance(b,c),distance(c,a)];
end
% mean(mean(d)) = 0.0990

% prune the points with edges that are longer than 0.01
discardThreshold = 0.01;
xd = find(d(1,:) < discardThreshold); yd = find(d(2,:) < discardThreshold); zd = find(d(3,:) < discardThreshold);
commond = union(xd,yd);
commond = union(zd,commond);
Xpruned = Xpruned(:,commond);
xLpruned = xLpruned(:,commond);
cleantri = delaunay(xLpruned(1,:), xLpruned(2,:));

%% prune the points with x,y, or z coordinates that are smaller than 0 or larger than 30

for i=1:3
    coords = find((Xpruned(i,:) > 0));
    Xpruned = Xpruned(:,coords);
    xLpruned = xLpruned(:,coords);
end
for i=1:3
    coords = find((Xpruned(i,:) < 30));
    Xpruned = Xpruned(:,coords);
    xLpruned = xLpruned(:,coords);
end

%% do delaunay again on the cleaned points to make a cleaner mesh
xpts = xLpruned(1,:);
ypts = xLpruned(2,:);
cleantri = delaunay(xpts,ypts);

%% Draw the cleaned mesh
figure(1); clf;
h = trisurf(cleantri,Xpruned(1,:),Xpruned(2,:),Xpruned(3,:));
set(h,'edgecolor','none')
set(gca,'projection','perspective')
set(gcf,'renderer','opengl')
axis image; axis vis3d;
camorbit(120,0); camlight left;
camorbit(120,0); camlight left;
lighting phong;
material dull;
% colormap('gray');
% print(h,'-dmeta')

% Draw uncleaned mesh
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