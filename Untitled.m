


[tri,pts] = ply_read('complete-mann.ply','tri')

% For each point in pts, find the closest point in
% your original set of points X
T = delaunayn(X)
nearest = dsearchn(X,T,pts)
%Use color of nearest point
set(h,'FaceVertexCdata',color(nearest,:))