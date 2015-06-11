% color the mesh
[tri, pts] = ply_read('mann1.ply','tri');
T = delaunayn(Xold);
nearest = dsearchn(X,T,pts);

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