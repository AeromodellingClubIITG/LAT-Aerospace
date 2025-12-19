clear all;

file_prop = 'MODEL_1_propeller_polars.txt';
file_base = 'BASE_airfoil.txt';

smoothingFactor = 9;

% read data and skip topmost line
Data_prop = readmatrix(file_prop, 'FileType', 'text', 'NumHeaderLines', 2); 
alpha_prop = (Data_prop(:,1));
Cl_prop = (Data_prop(:,2));
Cd_prop = (Data_prop(:,3));


Data_base = readmatrix(file_base, 'FileType', 'text', 'NumHeaderLines', 2);
alpha_base = (Data_base(:,1));
Cl_base = (Data_base(:,3));
Cd_base = (Data_base(:,2));

%Interpolation

min_AoA_prop = min(alpha_prop); 
max_AoA_prop = max(alpha_prop); 
AoA_interp_prop = linspace(min_AoA_prop, max_AoA_prop, 200);

Cl_interp_prop = interp1(alpha_prop, Cl_prop, AoA_interp_prop,'pchip');
Cd_interp_prop = interp1(alpha_prop, Cd_prop, AoA_interp_prop,'pchip');

min_AoA_base = min(alpha_base); 
max_AoA_base = max(alpha_base); 
AoA_interp_base = linspace(min_AoA_base, max_AoA_base, 200);

Cl_interp_base = interp1(alpha_base, Cl_base, AoA_interp_base, 'pchip');
Cd_interp_base = interp1(alpha_base, Cd_base, AoA_interp_base, 'pchip');


%Plotting
subplot(121);
plot(AoA_interp_prop, Cl_interp_prop, 'Color', '#1276b8', 'Linewidth', 2); 
hold on; 
plot(AoA_interp_base, Cl_interp_base, 'Color', 'black', 'LineWidth', 2);
ylabel('C_L'); 
xlabel('\alpha');
title('{C_L} comparison between Model 1 and Airfoil')
legend('Model 1', 'base airfoil');
grid minor;
hold off;

subplot(122);
plot(AoA_interp_prop, Cd_interp_prop, 'Color', '#1276b8', 'Linewidth', 2); 
hold on; 
plot(AoA_interp_base, Cd_interp_base, 'Color', 'black', 'LineWidth', 2);
ylabel('C_D'); 
xlabel('\alpha');
title('{C_D} comparison between Model 1 and Airfoil')
legend('Model 1', 'base airfoil');
ylim([0 1])
grid minor;
hold off;