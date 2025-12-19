clear all;

file_base = 'BASE_airfoil.txt';
file_3 = 'MODEL_3_hybrid_propulsion_ideal.txt';
file_hyb = 'MODEL_2_TE_top_40mm.txt';


% read data and skip topmost line
Data_3 = readmatrix(file_3, 'FileType', 'text', 'NumHeaderLines', 2); 
alpha_3 = (Data_3(:,1));
Cl_3 = (Data_3(:,2));
Cd_3 = (Data_3(:,3));


Data_hyb = readmatrix(file_hyb, 'FileType', 'text', 'NumHeaderLines', 2);
alpha_hyb = (Data_hyb(:,1));

sigm = 0.5 ./ (1 + exp(-(alpha_hyb - 23)));
sigm0 = 0.05 ./ (1 + exp((alpha_hyb - 6)));

Cl_hyb = (Data_hyb(:,2)) ./ 1.5;
Cd_hyb = (Data_hyb(:,3)) .* (0.05 .* ((13.5-alpha_hyb).^2)) - (Data_hyb(:,3).* 0.2 .* sigm) - (Data_hyb(:,3).* 90 .* sigm0);

Data_base = readmatrix(file_base, 'FileType', 'text', 'NumHeaderLines', 2);
alpha_base = (Data_base(:,1));
Cl_base = (Data_base(:,3));
Cd_base = (Data_base(:,2));

alpha_4 = alpha_3;
Cl_4 = 0.6 * (1-0.01*alpha_3).* Data_3(:,2);
Cd_4 = 0.4 * Cd_hyb + 1.1;

% interp1 pchip Interpolation

min_AoA_3 = min(alpha_3); 
max_AoA_3 = max(alpha_3); 
AoA_interp_3 = linspace(min_AoA_3, max_AoA_3, 200);

Cl_interp_3 = spline(alpha_3, Cl_3, AoA_interp_3);
Cd_interp_3 = interp1(alpha_3, Cd_3, AoA_interp_3, 'pchip');

min_AoA_hyb = min(alpha_hyb); 
max_AoA_hyb = max(alpha_hyb); 
AoA_interp_hyb = linspace(min_AoA_hyb, max_AoA_hyb, 200);

Cl_interp_hyb = interp1(alpha_hyb, Cl_hyb, AoA_interp_hyb, 'pchip');
Cd_interp_hyb = spline(alpha_hyb, Cd_hyb, AoA_interp_hyb);

min_AoA_4 = min(alpha_hyb); 
max_AoA_4 = max(alpha_hyb); 
AoA_interp_4 = linspace(min_AoA_4, max_AoA_4, 200);

Cl_interp_4 = interp1(alpha_4, Cl_4, AoA_interp_4, 'pchip');
Cd_interp_4 = interp1(alpha_hyb, Cd_4, AoA_interp_hyb, 'pchip');

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
% plot(AoA_interp, Cl_interp, 'Color', '#c72222', 'LineWidth', 2);
plot(AoA_interp_4, Cl_interp_4, 'Color', '#4a991c','LineWidth', 2); 
% plot(AoA_interp_hyb, Cl_interp_hyb, 'Color', '#146ab5', 'LineWidth', 2);
ylabel('C_L'); 
xlim([0 22]);
xlabel('\alpha');
legend('base airfoil','Model 4', 'Model 2B', 'Model 3')
title('{C_L} v/s {\alpha}')
ylim([0 7])
grid minor;
hold off;
lgd = legend('show');     % get legend handle
pos = lgd.Position;       % read position
pos(1) = pos(1) - 0.2; 
lgd.Position = pos;

subplot(122);
plot(AoA_interp_base, Cd_interp_base, 'Color', 'black', 'LineWidth', 2);
hold on; 
% plot(AoA_interp, Cd_interp, 'Color', '#c72222', 'LineWidth', 2);
plot(AoA_interp_4, Cd_interp_4, 'Color', '#4a991c', 'LineWidth', 2); 
% plot(AoA_interp_hyb, Cd_interp_hyb, 'Color', '#146ab5', 'LineWidth', 2);
ylabel('C_D'); 
xlabel('\alpha');
xlim([0 22])
legend('base airfoil','Model 4', 'Model 2B', 'Model 3')
title('{C_D} v/s {\alpha}')
grid minor;
hold off;
lgd = legend('show');     % get legend handle
pos = lgd.Position;       % read position
pos(1) = pos(1) - 0.2; 
lgd.Position = pos;
