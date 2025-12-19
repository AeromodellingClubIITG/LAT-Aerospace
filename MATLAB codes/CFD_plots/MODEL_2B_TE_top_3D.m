clear all;

file_TE = 'MODEL_2B_TE_top_3D.txt';

Data_TE = readmatrix(file_TE, 'FileType', 'text', 'NumHeaderLines', 2); 

% TE polars

alpha_TE = Data_TE(:,1);
Cl_TE = Data_TE(:,2);
Cd_TE = Data_TE(:,3);


% Interpolation

min_AoA_TE = min(alpha_TE); 
max_AoA_TE = max(alpha_TE); 
AoA_interp_TE = linspace(min_AoA_TE, max_AoA_TE, 200);

Cl_interp_TE = interp1(alpha_TE, Cl_TE, AoA_interp_TE, 'pchip');
Cd_interp_TE = interp1(alpha_TE, Cd_TE, AoA_interp_TE, 'pchip');

%Plotting
% 
plot(AoA_interp_TE, Cd_interp_TE, 'Color','#980aad','LineWidth', 2); 
hold on;
plot(AoA_interp_TE, Cl_interp_TE,'Color','#1276b8', 'LineWidth', 2);
% % 
title('MODEL-2B 3D analysis')
ylabel('Polar'); 
xlabel('\alpha');
legend('C_D', 'C_L');
grid minor;
hold off;
lgd = legend('show');     % get legend handle
pos = lgd.Position;       % read position
pos(2) = pos(2) - 0.3; 
lgd.Position = pos;

% Pick first N points close to stall-free linear region

