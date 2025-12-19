clear all;

file_base = 'BASE_airfoil.txt';

file_pf_40 = 'BASE_Plain_Flap_40.txt';
file_pf_30 = 'BASE_Plain_Flap_30.txt';
file_pf_50 = 'BASE_Plain_Flap_50.txt';

Data_base = readmatrix(file_base, 'FileType', 'text', 'NumHeaderLines', 2); 

Data_30 = readmatrix(file_pf_30, 'FileType', 'text', 'NumHeaderLines', 2); 
Data_40 = readmatrix(file_pf_40, 'FileType', 'text', 'NumHeaderLines', 2);
Data_50 = readmatrix(file_pf_50, 'FileType', 'text', 'NumHeaderLines', 2);

% Base airfoil polars
alpha_base = (Data_base(:,1));
Cl_base = (Data_base(:,3));
Cd_base = (Data_base(:,2));

% Plain Flap polars

alpha_30 = Data_30(:,1);
Cl_30 = Data_30(:,2);
Cd_30 = Data_30(:,3);

alpha_40 = Data_40(:,1);
Cl_40 = Data_40(:,2);
Cd_40 = Data_40(:,3);

alpha_50 = Data_50(:,1);
Cl_50 = Data_50(:,2);
Cd_50 = Data_50(:,3);

%Interpolation

min_AoA_base = min(alpha_base); % Renamed to avoid conflict with max_AoA from spline
max_AoA_base = max(alpha_base); % Renamed to avoid conflict with max_AoA from spline
AoA_interp_base = linspace(min_AoA_base, max_AoA_base, 200);

Cl_interp_base = spline(alpha_base, Cl_base, AoA_interp_base);
Cd_interp_base = spline(alpha_base, Cd_base, AoA_interp_base);

%30
min_AoA_30 = min(alpha_30); % Renamed to avoid conflict with max_AoA from spline
max_AoA_30 = max(alpha_30); % Renamed to avoid conflict with max_AoA from spline
AoA_interp_30 = linspace(min_AoA_30, max_AoA_30, 200);

Cl_interp_30 = spline(alpha_30, Cl_30, AoA_interp_30);
Cd_interp_30 = spline(alpha_30, Cd_30, AoA_interp_30);

%40
min_AoA_40 = min(alpha_40); % Renamed to avoid conflict with max_AoA from spline
max_AoA_40 = max(alpha_40); % Renamed to avoid conflict with max_AoA from spline
AoA_interp_40 = linspace(min_AoA_40, max_AoA_40, 200);

Cl_interp_40 = spline(alpha_40, Cl_40, AoA_interp_40);
Cd_interp_40 = spline(alpha_40, Cd_40, AoA_interp_40);

%50
min_AoA_50 = min(alpha_50); % Renamed to avoid conflict with max_AoA from spline
max_AoA_50 = max(alpha_50); % Renamed to avoid conflict with max_AoA from spline
AoA_interp_50 = linspace(min_AoA_50, max_AoA_50, 200);

Cl_interp_50 = spline(alpha_50, Cl_50, AoA_interp_50);
Cd_interp_50 = spline(alpha_50, Cd_50, AoA_interp_50);


%Plotting

subplot(121);

plot(AoA_interp_base, Cl_interp_base,'black', 'LineWidth', 2); 
hold on;
plot(AoA_interp_30, Cl_interp_30,'Color','#cf1332', 'LineWidth', 2);
plot(AoA_interp_40, Cl_interp_40,'Color','#1276b8', 'LineWidth', 2);
plot(AoA_interp_50, Cl_interp_50,'Color','#afbd13', 'LineWidth', 2);
ylabel('C_L'); 
xlabel('\alpha');
title('{C_L} v/s {\alpha}')
legend('base airfoil', "{\delta_f} = 30{^\circ}", "{\delta_f} = 40{^\circ}", "{\delta_f} = 50{^\circ}")
grid minor;
hold off;

subplot(122);
plot(AoA_interp_base, Cd_interp_base,'black', 'LineWidth', 2); 
hold on; 
plot(AoA_interp_30, Cd_interp_30,'Color','#cf1332', 'LineWidth', 2);
plot(AoA_interp_40, Cd_interp_40,'Color','#1276b8', 'LineWidth', 2);
plot(AoA_interp_50, Cd_interp_50,'Color','#afbd13', 'LineWidth', 2);
ylabel('C_D'); 
xlabel('\alpha');
title('{C_D} v/s {\alpha}')
legend('base airfoil', "{\delta_f} = 30{^\circ}", "{\delta_f} = 40{^\circ}", "{\delta_f} = 50{^\circ}")
grid minor;
hold off;
lgd = legend('show');     % get legend handle
pos = lgd.Position;       % read position
pos(1) = pos(1) - 0.21; 
lgd.Position = pos;
