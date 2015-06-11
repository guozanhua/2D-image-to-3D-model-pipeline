% demoscript.m

% load camera calibration

% do deconstruct
dir = 'C:\\Users\\Yuki\\Documents\\MATLAB\\117\\proj\\mann\\';
threshold = 0.001;
rgb_threshold = 0.055;

for setnumber = 1:1
    [X, xR, xL, xColor] = reconstruct(dir,setnumber,threshold,rgb_threshold);
    [Xcleaned, tri] = mesh(X, xL, xR, xColor);
    mesh_2_ply(Y,xColor,triflip,['mann_' scanset '.ply']);
    fprintf(' ============ outputted to PLY file ============\n');
end

