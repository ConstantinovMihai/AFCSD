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

K_gains_sched = place(A_g, B_g, p_g);
K_red2 = [-162.1154  -47.3365];

alts = [20000, 20000];
vel = [300, 400];

K_alpha_int = [ -185.2580 , -162.1154];
K_q_int = [-38.6269, -47.3365];

Thetas_num = [0.486, 0.365];
Thetas_den = [3.1335, 2.397];
K_fw_values = [2.698, 2.077];

kq1 = interp1(vel, K_q_int, 340);
kal2 = interp1(vel, K_alpha_int, 340);

the_num = interp1(vel, Thetas_num, 340)
the_den = interp1(vel, Thetas_den, 340)
% k_fw_int = interp1(vel, K, 340)


K_int_matrix = [-176.001, -42.11];

s = tf('s');
sys = ss(A_g, B_g, C_g, D_g);
sys2 = ss(A_g - B_g*K_int_matrix, B_g, C_g, D_g)
pole(sys2)

