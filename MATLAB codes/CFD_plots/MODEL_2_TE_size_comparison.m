clear all;

file_TE_40 = 'MODEL_2_TE_top_40mm.txt';
file_TE_55 = 'MODEL_2_TE_top_55mm.txt';

smoothingFactor = 9;

% read data and skip topmost line
Data_TE_40 = readmatrix(file_TE_40, 'FileType', 'text', 'NumHeaderLines', 2); 
alpha_TE_40 = (Data_TE_40(:,1));
Cl_TE_40 = (Data_TE_40(:,2));


Data_TE_55 = readmatrix(file_TE_55, 'FileType', 'text', 'NumHeaderLines', 2);
alpha_TE_55 = (Data_TE_55(:,1));
Cl_TE_55 = (Data_TE_55(:,2));


%Interpolation

min_AoA_TE_40 = min(alpha_TE_40); % Renamed to avoid conflict with max_AoA from spline
max_AoA_TE_40 = max(alpha_TE_40); % Renamed to avoid conflict with max_AoA from spline
AoA_interp_TE_40 = linspace(min_AoA_TE_40, max_AoA_TE_40, 200);

Cl_interp_TE_40 = spline(alpha_TE_40, Cl_TE_40, AoA_interp_TE_40);

min_AoA_TE_55 = min(alpha_TE_55); % Renamed to avoid conflict with max_AoA from spline
max_AoA_TE_55 = max(alpha_TE_55); % Renamed to avoid conflict with max_AoA from spline
AoA_interp_TE_55 = linspace(min_AoA_TE_55, max_AoA_TE_55, 200);

Cl_interp_TE_55 = spline(alpha_TE_55, Cl_TE_55, AoA_interp_TE_55);


%Plotting

plot(AoA_interp_TE_40, Cl_interp_TE_40, 'Color', '#087849', 'Linewidth', 2); 
hold on; 
plot(AoA_interp_TE_55, Cl_interp_TE_55, 'Color', '#9d22ab', 'LineWidth', 2);
ylabel('C_L'); 
xlabel('\alpha');
title('{C_L} comparison for varying EDF diameters in Model 2')
legend('40 mm diameter', '55 mm diameter');
grid minor;
hold off;

