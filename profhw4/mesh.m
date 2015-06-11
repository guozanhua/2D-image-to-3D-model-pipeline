
% scan we are working on
scandir = '/home/fowlkes/cs117/hwk/hwk4b/scan2/'

% threshold for pruning neighbors
nbrthresh = 0.25;
trithresh = 1;

% load in results of reconstruct 
% load([scandir 'scandata.mat']);


%
% cleaning step 1: remove points outside known bounding box
%
goodpoints = find( (X(1,:)>0) & (X(1,:)<20) & (X(2,:)>0) & (X(2,:)<25) & (X(3,:)>0) & (X(3,:)<20) );
fprintf('dropping %2.2f %% of points from scan',100*(1 - (length(goodpoints)/size(X,2))));
X = X(:,goodpoints);
xR = xR(:,goodpoints);
xL = xL(:,goodpoints);
xColor = xColor(:,goodpoints);

%%
%% cleaning step 2: remove points whose neighbors are far away
%%
fprintf('filtering right image neighbors\n');
[tri,pterrR] = nbr_error(xR,X);

fprintf('filtering left image neighbors\n');
[tri,pterrL] = nbr_error(xL,X);

goodpoints = find((pterrR<nbrthresh) & (pterrL<nbrthresh));
fprintf('dropping %2.2f %% of points from scan\n',100*(1-(length(goodpoints)/size(X,2))));
X = X(:,goodpoints);
xR = xR(:,goodpoints);
xL = xL(:,goodpoints);
xColor = xColor(:,goodpoints);
%%
%
% cleaning step 3: remove triangles which have long edges
%
[tri,terr] = tri_error(xL,X);
subt = find(terr<trithresh);
tri = tri(subt,:);

%
% render intermediate results
%
figure(1); clf;
h = trisurf(tri,X(1,:),X(2,:),X(3,:));
set(h,'edgecolor','none')
axis image; axis vis3d;
camorbit(120,0); camlight left;
camorbit(120,0); camlight left;
lighting phong;
set(gca,'projection','perspective')
set(gcf,'renderer','opengl')
set(h,'facevertexcdata',xColor'/255);

%
% cleaning step 4: simple smoothing
%
Y = nbr_smooth(tri,X,3);

% visualize results of smooth with
% mesh edges visible
figure(2); clf;
h = trisurf(tri,Y(1,:),Y(2,:),Y(3,:));
set(h,'edgecolor','flat')
axis image; axis vis3d;
camorbit(120,0); camlight left;
camorbit(120,0); camlight left;
lighting flat;
set(gca,'projection','perspective')
set(gcf,'renderer','opengl')
set(h,'facevertexcdata',xColor'/255);
material dull

