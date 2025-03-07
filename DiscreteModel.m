clc; clear; close all;

% Define Continuous State-Space Matrices
R1 = 0.0042;  % Resistance (Ohm)
R2 = 0.0024;   % Resistance (Ohm)
C1 = 17111; % Capacitance (Farad)
C2 = 440.57; % Capacitance (Farad)
eta = 0.99; % Efficiency factor

A = [-1/(R1*C1), 0, 0;
      0, -1/(R2*C2), 0;
      0, 0, 0];

B = [1/C1;
     1/C2;
     -eta];

C = eye(3);  % Measuring all state variables
D = zeros(3,1);  % No direct feedthrough

% Define Sampling Time
Ts = 0.1;  % Sampling time in seconds

% Compute Discrete Matrices using Zero-Order Hold
sys_cont = ss(A, B, C, D);   % Continuous system
sys_disc = c2d(sys_cont, Ts, 'zoh'); % Discretize using ZOH

% Display Results
disp('A_d (Discrete A):');
disp(sys_disc.A);
disp('B_d (Discrete B):');
disp(sys_disc.B);
disp('C_d (Discrete C):');
disp(sys_disc.C);
disp('D_d (Discrete D):');
disp(sys_disc.D);