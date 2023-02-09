% gain scheduling task

% short period model 
A_g = [    -0.4340     , 0.9473;
        -1.1621 ,  -0.6620];

B_g =  [ -0.0009;
            -0.0620];

C_g = [57.2958, 0; 0, 57.2958];
D_g = [0; 0];

%  desired pole locations
p_g = [-1.8288 + 3.1676*1i, -1.8288 - 3.1676*1i];

K = place(A_g, B_g, p_g)



