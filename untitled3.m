rltool(Copy_of_pitchratecommand)

A_red = [  -0.3190      0.9509;
            -0.9356  -0.5072];

B_red =  [ -0.0007;
            -0.0381];

C_red = [57.2958, 0; 0, 57.2958];
D_red = [0; 0];

sys = ss(A_red, B_red, C_red, D_red);

tfs = tf(sys)

% rltool(-tfs(1))

k1 = -1262.7;

sys2 = ss(A_red + B_red*k1, B_red, C_red, D_red);

tfs2 = tf(sys2);

rltool(-tfs(2))
