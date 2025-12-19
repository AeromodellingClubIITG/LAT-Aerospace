clc; clear; close all;

% ---- File name ----
filename = 'GA(W)-1 (no flap)_T1_Re0.197_M0.06_N9.0.txt';

% Skip header lines (first 11 lines are not numeric)
data = readmatrix(filename, 'FileType', 'text', 'NumHeaderLines', 11);
% print (data);


alpha = data(:,1);   % Angle of attack (deg)
n = length(alpha);

Cl = data(:,2);

CJ = linspace(0.4,0.9,n);

[X, Y] = meshgrid(alpha, CJ);

Cl_base = interp1(alpha, Cl, X);

eta_b = 0.8; %momentum transfer efficiency. Assumed to be 0.8
CL = Cl_base + eta_b*(Y.*sind(X));

% ---- Plot CL vs alpha ----
figure;
surf(X, Y, CL);
xlabel('\alpha (deg)');
ylabel('C_J');
zlabel('C_L');
title('Lift Coefficient vs Angle of Attack (no flaps, no slats)');
grid on;