clear all;

file_plop = 'Validation_Data.txt';

smoothingFactor = 9;

% read data and skip topmost line
Data_prop = readmatrix(file_plop, 'FileType', 'text', 'NumHeaderLines', 2); 
alpha_prop = (Data_prop(:,1));
Cl_prop = (Data_prop(:,2));
Cd_prop = (Data_prop(:,3));




%Plotting
subplot(121);
plot(alpha_prop, Cl_prop, 'Color', '#1276b8', 'Linewidth', 2); 

ylabel('C_L'); 
xlabel('n');
ylim([7.5 8])
title('{C_L}')
grid minor;

subplot(122);
plot(alpha_prop, Cd_prop, 'Color', '#1276b8', 'Linewidth', 2); 
ylabel('C_D'); 
xlabel('n');
title('{C_D}')

grid minor;