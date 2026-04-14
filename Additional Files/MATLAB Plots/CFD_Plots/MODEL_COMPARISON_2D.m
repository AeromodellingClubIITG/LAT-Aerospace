clear all;

file_base = 'BASE_airfoil.txt';
file_TE_40 = 'MODEL_2_TE_top_40mm.txt';
file_hyb = 'MODEL_3_hybrid_propulsion.txt';

% read data and skip topmost line
Data_TE_40 = readmatrix(file_TE_40, 'FileType', 'text', 'NumHeaderLines', 2); 
alpha_TE_40 = (Data_TE_40(:,1));
Cl_TE_40 = (Data_TE_40(:,2));
Cd_TE_40 = (Data_TE_40(:,3));

Data_hyb = readmatrix(file_hyb, 'FileType', 'text', 'NumHeaderLines', 2);
alpha_hyb = (Data_hyb(:,1));
Cl_hyb = (Data_hyb(:,2));
Cd_hyb = (Data_hyb(:,3));

Data_base = readmatrix(file_base, 'FileType', 'text', 'NumHeaderLines', 2);
alpha_base = (Data_base(:,1));
Cl_base = (Data_base(:,3));
Cd_base = (Data_base(:,2));

% interp1 pchip Interpolation

min_AoA_TE_40 = min(alpha_TE_40); 
max_AoA_TE_40 = max(alpha_TE_40); 
AoA_interp_TE_40 = linspace(min_AoA_TE_40, max_AoA_TE_40, 200);

Cl_interp_TE_40 = interp1(alpha_TE_40, Cl_TE_40, AoA_interp_TE_40, 'pchip');
Cd_interp_TE_40 = interp1(alpha_TE_40, Cd_TE_40, AoA_interp_TE_40, 'pchip');

min_AoA_hyb = min(alpha_hyb); 
max_AoA_hyb = max(alpha_hyb); 
AoA_interp_hyb = linspace(min_AoA_hyb, max_AoA_hyb, 200);

Cl_interp_hyb = interp1(alpha_hyb, Cl_hyb, AoA_interp_hyb, 'pchip');
Cd_interp_hyb = interp1(alpha_hyb, Cd_hyb, AoA_interp_hyb, 'pchip');

min_AoA_base = min(alpha_base); 
max_AoA_base = max(alpha_base); 
AoA_interp_base = linspace(min_AoA_base, max_AoA_base, 200);

Cl_interp_base = interp1(alpha_base, Cl_base, AoA_interp_base, 'pchip');
Cd_interp_base = interp1(alpha_base, Cd_base, AoA_interp_base, 'pchip');

% Mid-eval data:
dataFileName = 'MODEL_1_propeller_polars.txt'; 

data = readmatrix(dataFileName, 'FileType', 'text', 'NumHeaderLines', 2); 

AoA = data(:, 1); 
CL = data(:, 2); 
CD = data(:, 3);

min_AoA_data = min(AoA); 
max_AoA_data = max(AoA); 
AoA_interp = linspace(min_AoA_data, max_AoA_data, 200);
Cl_interp = interp1(AoA, CL, AoA_interp, 'pchip');
Cd_interp = interp1(AoA, CD, AoA_interp, 'pchip');

% Plotting
subplot(121); % 1 row, 2 columns, first plot
plot(AoA_interp_base, Cl_interp_base, 'Color', 'black', 'LineWidth', 2);
hold on; 
plot(AoA_interp, Cl_interp, 'Color', '#c72222', 'LineWidth', 2);
plot(AoA_interp_TE_40, Cl_interp_TE_40, 'blue','LineWidth', 2); 
plot(AoA_interp_hyb, Cl_interp_hyb, 'Color', '#980aad', 'LineWidth', 2);
ylabel('C_L'); 
xlabel('\alpha');
legend('base airfoil','Model 1', 'Model 2B', 'Model 3')
title('{C_L} v/s {\alpha}')

grid minor;
hold off;
lgd = legend('show');     % get legend handle
pos = lgd.Position;       % read position
pos(1) = pos(1) - 0.2; 
lgd.Position = pos;

subplot(122);
plot(AoA_interp_base, Cd_interp_base, 'Color', 'black', 'LineWidth', 2);
hold on; 
plot(AoA_interp, Cd_interp, 'Color', '#c72222', 'LineWidth', 2);
plot(AoA_interp_TE_40, Cd_interp_TE_40, 'blue','LineWidth', 2); 
plot(AoA_interp_hyb, Cd_interp_hyb, 'Color', '#980aad', 'LineWidth', 2);
ylabel('C_D'); 
xlabel('\alpha');
legend('base airfoil','Model 1', 'Model 2B', 'Model 3')
title('{C_D} v/s {\alpha}')
grid minor;
hold off;
lgd = legend('show');     % get legend handle
pos = lgd.Position;       % read position
pos(1) = pos(1) - 0.2; 
lgd.Position = pos;
