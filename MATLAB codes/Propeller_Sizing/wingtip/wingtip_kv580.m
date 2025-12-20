clc; clear; close all;

file_13 = '/Users/rranjan/Desktop/Aero/Inter IIT/Wingtip/AT3530_kV580_13_tab (1).txt';
file_14 = '/Users/rranjan/Desktop/Aero/Inter IIT/Wingtip/AT3530_kV580_14_tab (1).txt';

% read data and skip topmost line
APC13_8 = readmatrix(file_13, 'FileType', 'text', 'NumHeaderLines', 1); 
APC14_7 = readmatrix(file_14, 'FileType', 'text', 'NumHeaderLines', 1); 

disp(size(APC13_8));

RPM_13 = APC13_8(:,5);
RPM_14 = APC14_7(:,5);

Thrust_13 = APC13_8(:,7);
Thrust_14 = APC14_7(:,7);

scatter (RPM_13, Thrust_13, 'black', 'filled', 'v');
hold on;
scatter (RPM_14, Thrust_14, 'blue', 'filled', 'o');
legend('APC13*8', 'APC14*7');
xlabel('RPM');
ylabel('Thrust per propeller (g)');
title(['Plot for kV 580']);







