% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% this file contains the plotting        %%
% %% routines for the step inputs responses %%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % actuator and engine free dynamics
% 
% A_long = [-0.0420 , -17.0638 , -32.1700 ,  -2.9953;
%    -0.0007  , -0.3190  ,  0.0000  ,  0.9509;
%          0    ,     0      ,   0   , 1.0000;
%    -0.0000  , -0.9356   ,      0   ,-0.5072];
% 
% B_long = [-0.0448
%        -0.0007 
%              0
%        -0.0381];
% 
% % analyse only the reponse on pitch rate q
% C = [0, 0 ,0 , 57.2958];
% D = [0; 0];
% 
% short period model 
A_red = [  -0.3190      0.9509;
            -0.9356  -0.5072]
B_red =  [ -0.0007;
            -0.0381];
C_red = [57.2958, 0; 0, 57.2958];
D_red = [0; 0];
% 
% % state space models
% ss_red = ss(A_red, B_red, C_red, D_red);
% 
% tf2= tf(ss_red);
% zr = zero(tf2(2));
% 
% % desired pole location
p = [-1.3716 + 2.376*1i, -1.3716 - 2.376*1i];
% 
K_red = place(A_red, B_red, p);

sys = ss(A_red, B_red, C_red, D_red);
sys2 = ss(A_red-B_red*K_red, B_red, C_red, D_red);
pole(sys2)
damp(sys2)

% out = sim(out);
% 
% t = out.tout;
% pitch_angle = out.pitch_angle.Data;
% pitch_rate = out.pitch_rate.Data;
% stepr = out.square_signal.Data;
% 
% hold on;
% grid on;
% 
% plot(t, pitch_angle, 'LineWidth', 1.5);
% plot(t, pitch_rate,  'LineWidth', 1.5);
% plot(t, stepr,  'LineWidth', 1.5)
% 
% xlabel('Time (s)') 
% ylabel('Response magnitude')
% hold off;
% 
% legend('Pitch angle','Pitch rate', 'Input', 'Location','best')
% 
% hold off;
% ss_red = linearize('pitchratecommand');
% tf2= tf(ss_red);

% t = 0:0.01:6;
% % y_red = step(ss_red, t);

% 
% % y_long = step(ss_long, t);
% % y_red = step(ss_red, t);
% hold on;
% grid on;
% out = sim('pitchratecommand.slx');
% load('out')
% pitch_angle = out.pitch_angle.Data;
% 
% % plot(t, y_long);
% plot(t, y_red(:,2));
% xlabel('Time (s)') 
% ylabel('Pitch rate (deg/s)')
% hold off;
% % legend('4 state system','2 state system', 'Location','best')