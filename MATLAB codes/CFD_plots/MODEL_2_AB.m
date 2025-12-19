clear all;

file_base = 'BASE_airfoil.txt';

file_A = 'MODEL_2_TE_top_40mm.txt';
file_B = 'MODEL_2_LE_top.txt';

smoothingFactor = 9;

% read data and skip topmost line
Data_A = readmatrix(file_A, 'FileType', 'text', 'NumHeaderLines', 2); 
alpha_A = (Data_A(:,1));
Cl_A = (Data_A(:,2));
Cd_A = Data_A(:,3);

Data_B = readmatrix(file_B, 'FileType', 'text', 'NumHeaderLines', 2);
alpha_B = (Data_B(:,1));
Cl_B = (Data_B(:,2));
Cd_B = Data_B(:,3);

Data_base = readmatrix(file_base, 'FileType', 'text', 'NumHeaderLines', 2);
alpha_base = (Data_base(:,1));
Cl_base = (Data_base(:,3));
Cd_base = (Data_base(:,2));

%Interpolation

min_AoA_A = min(alpha_A); 
max_AoA_A = max(alpha_A); 
AoA_interp_A = linspace(min_AoA_A, max_AoA_A, 200);

Cl_interp_A = spline(alpha_A, Cl_A, AoA_interp_A);
Cd_interp_A = spline(alpha_A, Cd_A, AoA_interp_A);

min_AoA_B = min(alpha_B); 
max_AoA_B = max(alpha_B); 
AoA_interp_B = linspace(min_AoA_B, max_AoA_B, 200);

Cl_interp_B = spline(alpha_B, Cl_B, AoA_interp_B);
Cd_interp_B = spline(alpha_B, Cd_B, AoA_interp_B);

min_AoA_base = min(alpha_base); 
max_AoA_base = max(alpha_base); 
AoA_interp_base = linspace(min_AoA_base, max_AoA_base, 200);

Cl_interp_base = interp1(alpha_base, Cl_base, AoA_interp_base, 'pchip');
Cd_interp_base = interp1(alpha_base, Cd_base, AoA_interp_base, 'pchip');



%Plotting
subplot(121);
plot(AoA_interp_A, Cl_interp_A, 'Color', '#ab1524', 'Linewidth', 2); 
hold on; 
plot(AoA_interp_B, Cl_interp_B, 'Color', '#1276b8', 'LineWidth', 2);
plot(AoA_interp_base, Cl_interp_base, 'Color', 'black', 'LineWidth', 2);
ylabel('C_L'); 
xlabel('\alpha');
title('{C_L} comparison for Model 2A and Model 2B')
legend('Model 2A', 'Model 2B', 'base airfoil');
grid minor;
hold off;
lgd = legend('show');     % get legend handle
pos = lgd.Position;       % read position
pos(1) = pos(1) - 0.2; 
lgd.Position = pos;

subplot(122);
plot(AoA_interp_A, Cd_interp_A, 'Color', '#ab1524', 'Linewidth', 2); 
hold on; 
plot(AoA_interp_B, Cd_interp_B, 'Color', '#1276b8', 'LineWidth', 2);
plot(AoA_interp_base, Cd_interp_base, 'Color', 'black', 'LineWidth', 2);
ylabel('C_D'); 
xlabel('\alpha');
title('{C_D} comparison for Model 2A and Model 2B')
legend('Model 2A', 'Model 2B', 'base airfoil');
grid minor;
hold off;
lgd = legend('show');     % get legend handle
pos = lgd.Position;       % read position
pos(1) = pos(1) - 0.2; 
lgd.Position = pos;