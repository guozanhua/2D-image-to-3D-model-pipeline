for i = 1:10
    load(sprintf('reconstruct_%d.mat',i));%mat filefrom reconstruction containg X,xColor,
    filePath = sprintf('meshes\\tea_%d.ply',i);
    tri = delaunay(X(1,:),X(2,:));
    mesh_2_ply(X,xColor,tri,filePath);
end