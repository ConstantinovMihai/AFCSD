% rltool(Copy_of_pitchratecommand)

A_red = [  -0.3190      0.9509;
            -0.9356  -0.5072];

B_red =  [ -0.0007;
            -0.0381];

C_red = [57.2958, 0; 0, 57.2958];
D_red = [0; 0];

sys = ss(A_red, B_red, C_red, D_red);-0.86825

tfs = tf(sys)
% 
% rltool(-tfs(1))

k1 = -3.0807;

K_alpha_mat = [-3.0807, 0];
K_q_mat = [0, -0.86825];

A_g2 = A_red - B_red * C_red(1,:) * k1

sys2 = ss(A_g2, B_red, C_red, D_red);

tfs2 = tf(sys2);
k2 = -0.86825

sys3 = feedback(sys2, [0, k2]);

damp(sys3)
