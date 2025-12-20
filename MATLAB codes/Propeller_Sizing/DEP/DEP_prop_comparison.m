clc; clear; close all;

file_7 = '/Users/rranjan/Desktop/Aero/Inter IIT/Prop/GF7040-3_1500KV.txt';
file_6 = '/Users/rranjan/Desktop/Aero/Inter IIT/Prop/T6143-3_1500KV.txt';
file_5 = '/Users/rranjan/Desktop/Aero/Inter IIT/Prop/HQ5040-6_1500KV.txt';

% read data and skip topmost line
GF7040 = readmatrix(file_7, 'FileType', 'text', 'NumHeaderLines', 1); 
T6143 = readmatrix(file_6, 'FileType', 'text', 'NumHeaderLines', 1);
HQ5040 = readmatrix(file_5, 'FileType', 'text', 'NumHeaderLines', 1);


RPM_7 = GF7040(:,6);
RPM_6 = T6143(:,6);
RPM_5 = HQ5040(:,6);

Thrust_7 = GF7040(:,7);
Thrust_6 = T6143(:,7);
Thrust_5 = HQ5040(:,7);

scatter (RPM_5, Thrust_5, 'black', 'filled', 'v');
hold on
scatter (RPM_6, Thrust_6, 'blue', 'filled', 'o');
scatter (RPM_7, Thrust_7, 'red', 'filled', 'square');
legend('GF7040-3', 'T6143-3', 'HQ5040-6');
xlabel('RPM')
ylabel('Thrust per propeller (g)')







