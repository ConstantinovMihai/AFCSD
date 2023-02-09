re_eig = -0.0278
im_eig = 0
1.0177
omega_n = sqrt(re_eig^2 + im_eig^2) % rad/s
P = 2 * pi / im_eig % s 
T_half = log(0.5) / re_eig % s
zeta = - re_eig / omega_n % [-]
tau = -1 / re_eig % [-]