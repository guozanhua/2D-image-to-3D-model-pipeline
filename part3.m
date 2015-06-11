%%

mesh_2_ply(Y,xColor,triflip,['mann_' scanset '.ply']);
save(['part3_' scanset '.mat'],'Y','xColor','triflip','Xold','xColorold','xLold','xRold','om','T','fc_left','cc_left','kc_left','alpha_c_left','fc_right','cc_right','kc_right','alpha_c_right');

fprintf(' ============ PLY.M DONE! ============\n');