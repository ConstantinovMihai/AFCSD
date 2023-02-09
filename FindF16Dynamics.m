%================================================
%     Matlab Script File used to linearize the 
%     non-linear F-16 model. The program will 
%     Extract the longitudal and lateral 
%     direction matrices.  These system matrices 
%     will be used to create pole-zero mapping
%     and the bode plots of each to each control
%     input.
% Author: Richard S. Russell
% 
% Edit: Ewoud Smeur (2021)
%================================================
clear;

global fi_flag_Simulink

newline;

%% Trim aircraft to desired altitude and velocity
%%
altitude = input('Enter the altitude for the simulation (ft)  :  ');
velocity = input('Enter the velocity for the simulation (ft/s):  ');

disp('At what flight condition would you like to trim the F-16?');
disp('1.  Steady Wings-Level Flight.');
disp('2.  Steady Turning Flight.');
disp('3.  Steady Pull-Up Flight.');
disp('4.  Steady Roll Flight.');
FC_flag = input('Your Selection:  ');

%% Initial guess for trim
%%
thrust = 5000;          % thrust, lbs
elevator = -0.09;       % elevator, degrees
alpha = 8.49;              % AOA, degrees
rudder = -0.01;             % rudder angle, degrees
aileron = 0.01;            % aileron, degrees

%% Find trim for Hifi model at desired altitude and velocity
%%
disp('Trimming High Fidelity Model:');
fi_flag_Simulink = 1;
[trim_state_hi, trim_thrust_hi, trim_control_hi, dLEF, xu_hi] = trim_F16(thrust, elevator, alpha, aileron, rudder, velocity, altitude, FC_flag);

%% Find the state space model for the hifi model at the desired alt and vel.
trim_state_lin = trim_state_hi; trim_thrust_lin = trim_thrust_hi; trim_control_lin = trim_control_hi;
operating_point = operpoint('LIN_F16Block'); % retrieves initial conditions from integrators
operating_point.Inputs(1).u = trim_thrust_lin; operating_point.Inputs(2).u = trim_control_lin(1);
operating_point.Inputs(3).u = trim_control_lin(2); operating_point.Inputs(4).u = trim_control_lin(3);

SS_hi = linearize('LIN_F16Block');

disp(' ');
%% Find trim for lofi model at desired altitude and velocity
%%
disp('Trimming Low Fidelity Model:');
fi_flag_Simulink = 0;
[trim_state_lo, trim_thrust_lo, trim_control_lo, dLEF, xu_lo] = trim_F16(thrust, elevator, alpha, aileron, rudder, velocity, altitude, FC_flag);

%% Find the state space model for the lofi model at the desired alt and vel.
%%
trim_state_lin = trim_state_lo; trim_thrust_lin = trim_thrust_lo; trim_control_lin = trim_control_lo;
operating_point = operpoint('LIN_F16Block'); % retrieves initial conditions from integrators
operating_point.Inputs(1).u = trim_thrust_lin; operating_point.Inputs(2).u = trim_control_lin(1);
operating_point.Inputs(3).u = trim_control_lin(2); operating_point.Inputs(4).u = trim_control_lin(3);

SS_lo = linearize('LIN_F16Block');


%%%%%%%%%%%%%%%%%%%%%%%
%% Longitudal Direction
%%%%%%%%%%%%%%%%%%%%%%%

long_states = [3 5 7 8 11 13 14];
long_inputs = [1 2];
long_outputs = [3 5 7 8 11];

SS_long_lo = ss(SS_lo.A(long_states,long_states), SS_lo.B(long_states,long_inputs), SS_lo.C(long_outputs,long_states), SS_lo.D(long_outputs,long_inputs));
SS_long_hi = ss(SS_hi.A(long_states,long_states), SS_hi.B(long_states,long_inputs), SS_hi.C(long_outputs,long_states), SS_hi.D(long_outputs,long_inputs));

SS_long_lo.StateName = SS_lo.StateName(long_states);
SS_long_hi.StateName = SS_hi.StateName(long_states);

SS_long_lo.InputName= SS_lo.InputName(long_inputs);
SS_long_hi.InputName= SS_hi.InputName(long_inputs);

%%%%%%%%%%%%%%%%%%%%%%%
%% Chapter 5 answers
%%%%%%%%%%%%%%%%%%%%%%%

an_states = [3 5 7 8 11 13 14];
an_inputs = [1 2];
an_out = [19];
% answer to question 5.3 - 5.4
SS_long_lo_an = ss(SS_lo.A(long_states,long_states), SS_lo.B(long_states,long_inputs), SS_lo.C(an_out,long_states), SS_lo.D(an_out,long_inputs));

SS_long_lo_an.StateName = SS_lo.StateName(long_states);
SS_long_lo_an.InputName = SS_lo.InputName(long_inputs);
SS_long_lo_an.OutputName = "normal acceleration";

% Obtain transfer function from inputs to normal acceleration 
% and trim the pole zero cancellations
H = minreal(tf(SS_long_lo_an), 10e-5);
% get the transfer function from elevator input to normal acceleration
% answer to question 5.5
el_to_an = H(2);
% get the system response to a negative step input (nose up) in the elevator
opt = stepDataOptions("StepAmplitude", -1);

t = 0:0.01:3;

% UNCOMMENT THIS TO GET CHAPTER 5 ANSWERS 

[y, t] = step(el_to_an, t, opt);
figure(1)
% answer to question 5.6
plot(t, y)
grid on
xlabel('Time (s)') 
ylabel('Normal acceleration (g)') 
figure(2)
pzmap(el_to_an)
% answer to qestion 5.7
pzmap(el_to_an)

% answer to question 5.9
z = zero(el_to_an);

%%%%%%%%%%%%%%%%%%%%
%% Chapter 6 answers %%
%%%%%%%%%%%%%%%%%%%%

% longitudinal state space model
long_ol_states = [7, 8, 5, 11, 14, 13];
long_ol_inputs = [1, 2];
long_ol_outputs = [7, 8, 5, 11];

SS_long_ol = ss(SS_lo.A(long_ol_states,long_ol_states), SS_lo.B(long_ol_states,long_ol_inputs), SS_lo.C(long_ol_outputs,long_ol_states), SS_lo.D(long_ol_outputs,long_ol_inputs));

% these are the reduced matrices
A_long_ac = SS_long_ol.A(1:4,1:4);
B_long_ac = SS_long_ol.A(1:4,5:6);

C_long_ac = SS_long_ol.C(1:4,1:4);
D_long_ac = SS_long_ol.C(1:4,5:6);


% lateral state space model
lat_ol_states = [9, 4, 10, 12, 15, 16]; 
lat_ol_inputs = [3, 4];
lat_ol_outputs = [9, 4, 10, 12];

SS_lat_ol = ss(SS_lo.A(lat_ol_states,lat_ol_states), SS_lo.B(lat_ol_states,lat_ol_inputs), SS_lo.C(lat_ol_outputs,lat_ol_states), SS_lo.D(lat_ol_outputs,lat_ol_inputs));

A_lat_ac = SS_lat_ol.A(1:4, 1:4);
B_lat_ac = SS_lat_ol.A(1:4, 5:6);

e = eig(A_lat_ac);



%%%%%%%%%%%%%%%%%%%%
%% Chapter 8 answers %%
%%%%%%%%%%%%%%%%%%%%

GS_states = [3 7 8 5 11 13 14];
GS_inputs = [1 2];
GS_outputs = [3 7 8 5 11];

SS_long_lo_GS = ss(SS_lo.A(GS_states,GS_states), SS_lo.B(GS_states,GS_inputs), SS_lo.C(GS_outputs,GS_states), SS_lo.D(GS_outputs,GS_inputs));

A_long_ac_GS = SS_long_lo_GS.A(1:5, 1:5);
B_long_ac_GS = SS_long_lo_GS.A(1:5,6:7);

SS_long_lo_GS_red = ss(A_long_ac_GS, B_long_ac_GS, SS_lo.C(GS_outputs,GS_states(1:5)), SS_lo.D(GS_outputs,GS_inputs));

SS_long_lo_GS_red.StateName = SS_lo.StateName(GS_states(1:5));
SS_long_lo_GS_red.InputName= SS_lo.InputName(GS_inputs);

gs_angle_deg = 3;
gs_ref_angle = gs_angle_deg/180*pi;
start_pos = 2000/tan(gs_ref_angle) + 10*velocity;

h_flare = 19.2;
tau = 1.22;




%%%%%%%%%%%%%%%%%%%%
%% Lateral Direction
%%%%%%%%%%%%%%%%%%%%

lat_states = [4 6 7 9 10 12 13 15 16];
lat_inputs = [1 3 4];
lat_outputs = [4 6 7 9 10 12];

SS_lat_lo = ss(SS_lo.A(lat_states,lat_states), SS_lo.B(lat_states,lat_inputs), SS_lo.C(lat_outputs,lat_states), SS_lo.D(lat_outputs,lat_inputs));
SS_lat_hi = ss(SS_hi.A(lat_states,lat_states), SS_hi.B(lat_states,lat_inputs), SS_hi.C(lat_outputs,lat_states), SS_hi.D(lat_outputs,lat_inputs));

SS_lat_lo.StateName = SS_lo.StateName(lat_states);
SS_lat_hi.StateName = SS_hi.StateName(lat_states);

SS_lat_lo.InputName= SS_lo.InputName(lat_inputs);
SS_lat_hi.InputName= SS_hi.InputName(lat_inputs);


%% All Poles
% figure(2); 
% pzmap(SS_hi, 'r', SS_lo, 'b');
title_string = sprintf('Altitude = %.2f ft Velocity = %.2f ft/s\nAll Poles\n Blue = lofi Red = hifi.', altitude, velocity);
title(title_string);
sgrid;

%% Longitudinal Poles
%%
figure(3); 
pzmap(SS_long_hi, 'r', SS_long_lo, 'b');
title_string = sprintf('Altitude = %.2f ft Velocity = %.2f ft/s\nLongitudal Directional Poles\n Blue = lofi Red = hifi.', altitude, velocity);
title(title_string);
sgrid;

%% Lateral Poles
%%
figure(4); 
pzmap(SS_lat_hi, 'r', SS_lat_lo, 'b');
title_string = sprintf('Altitude = %.2f ft Velocity = %.2f ft/s\nLateral Directional Poles\n Blue = lofi Red = hifi.', altitude, velocity);
title(title_string);
sgrid;

%% Bode plot longitudinal 

% Choose an input and output
input = 2;
output = 3;

omega = logspace(-2,2,100);

% figure
% bode(SS_long_hi(output,input),omega);
% hold on;
% bode(SS_long_lo(output,input),omega);
% legend('hifi','lofi')

%% Bode plot lateral 

% Choose an input and output
input = 2;
output = 3;

omega = logspace(-2,2,100);

% figure;
% bode(SS_lat_hi(output,input),omega);
% hold on;
% bode(SS_lat_lo(output,input),omega);
% legend('hifi','lofi')