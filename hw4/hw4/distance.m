function d = distance(a,b)
% find the euclidean distance between points a, b
% points are in 3D
d = sqrt((a(1) - b(1))^2 + (a(2) - b(2))^2 + (a(3) - b(3))^2);