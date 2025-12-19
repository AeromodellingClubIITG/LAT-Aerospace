clear all;

file_base = 'BASE_airfoil.txt';

file_slat = 'BASE_Slat.txt';
file_slat_dsf = 'BASE_Slat_Double_Slotted_Flap.txt';

Data_base = readmatrix(file_base, 'FileType', 'text', 'NumHeaderLines', 2); 

Data_slat = readmatrix(file_slat, 'FileType', 'text', 'NumHeaderLines', 2); 
Data_slat_dsf = readmatrix(file_slat_dsf, 'FileType', 'text', 'NumHeaderLines', 2); 


% Base airfoil polars
alpha_base = (Data_base(:,1));
Cl_base = (Data_base(:,3));
Cd_base = (Data_base(:,2));

% Slat polars

alpha_slat = Data_slat(:,1);
Cl_slat = Data_slat(:,2);
Cd_slat = Data_slat(:,3);

alpha_slat_dsf = Data_slat_dsf(:,1);
Cl_slat_dsf = Data_slat_dsf(:,3);
Cd_slat_dsf = Data_slat_dsf(:,2);

% Interpolation

min_AoA_base = min(alpha_base); 
max_AoA_base = max(alpha_base); 
AoA_interp_base = linspace(min_AoA_base, max_AoA_base, 200);

Cl_interp_base = interp1(alpha_base, Cl_base, AoA_interp_base, 'pchip');
Cd_interp_base = interp1(alpha_base, Cd_base, AoA_interp_base, 'pchip');

min_AoA_slat = min(alpha_slat); 
max_AoA_slat = max(alpha_slat); 
AoA_interp_slat = linspace(min_AoA_slat, max_AoA_slat, 200);

Cl_interp_slat = interp1(alpha_slat, Cl_slat, AoA_interp_slat, 'pchip');
Cd_interp_slat = interp1(alpha_slat, Cd_slat, AoA_interp_slat, 'pchip');

min_AoA_slat_dsf = min(alpha_slat_dsf); 
max_AoA_slat_dsf = max(alpha_slat_dsf); 
AoA_interp_slat_dsf = linspace(min_AoA_slat_dsf, max_AoA_slat_dsf, 200);

Cl_interp_slat_dsf = interp1(alpha_slat_dsf, Cl_slat_dsf, AoA_interp_slat_dsf, 'pchip');
Cd_interp_slat_dsf = interp1(alpha_slat_dsf, Cd_slat_dsf, AoA_interp_slat_dsf, 'pchip');

%Plotting

plot(AoA_interp_base, Cl_interp_base, 'black','LineWidth', 2); 
hold on;
plot(AoA_interp_slat, Cl_interp_slat,'Color','#1276b8', 'LineWidth', 2);
plot(AoA_interp_slat_dsf, Cl_interp_slat_dsf,'Color','#ab1524', 'LineWidth', 2);

ylabel('C_L'); 
xlabel('\alpha');
legend('Base airfoil', 'Slat', 'Slat and Double Slotted Flap');
grid minor;
hold off;

