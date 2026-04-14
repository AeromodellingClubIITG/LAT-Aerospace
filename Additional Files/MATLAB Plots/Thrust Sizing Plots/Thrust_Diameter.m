
clear; close all; clc;
gamma = 1.4;
R = 287;              % J/kg/K
p1 = 101325;          % Pa
T1 = 288.15;          % K
V1 = 20;              % m/s

lambda_p = 1.0358717552282897;   
eta_fan  = 0.85;                  

a1   = sqrt(gamma * R * T1);
M1   = V1 / a1;
T0_1 = T1 * (1 + (gamma-1)/2 * M1^2);
p0_1 = p1 * (1 + (gamma-1)/2 * M1^2)^(gamma/(gamma-1));

mass_from_M = @(p0,T0,A,M) sqrt(gamma/(R*T0)) .* p0 .* A .* M .* ...
    (1 + (gamma-1)/2 .* M.^2).^(-(gamma+1)/(2*(gamma-1)));

function T = thrust_for_d(diameter_m)

    gamma = 1.4; R = 287; p1 = 101325; T1 = 288.15; 
    V1 = 20; lambda_p = 1.0358717552282897; eta_fan = 0.85;

    a1   = sqrt(gamma * R * T1);
    M1   = V1 / a1;
    T0_1 = T1 * (1 + (gamma-1)/2 * M1^2);
    p0_1 = p1 * (1 + (gamma-1)/2 * M1^2)^(gamma/(gamma-1));

    A = pi * (diameter_m/2)^2;

    T0_2 = T0_1 * (1 + (lambda_p^((gamma-1)/gamma) - 1) / eta_fan);
    p0_2 = lambda_p * p0_1;

    mass_from_M = @(p0,T0,A,M) sqrt(gamma/(R*T0)) .* p0 .* A .* M .* ...
        (1 + (gamma-1)/2 .* M.^2).^(-(gamma+1)/(2*(gamma-1)));

    mdot_in = mass_from_M(p0_1, T0_1, A, M1);

    resid = @(M2) mass_from_M(p0_2, T0_2, A, M2) - mdot_in;

    guess = max(0.05, min(0.9, M1));
    M2 = fzero(resid, guess);

    mdot = 0.5 * (mdot_in + mass_from_M(p0_2, T0_2, A, M2));

    T2 = T0_2 / (1 + (gamma-1)/2 * M2^2);
    a2 = sqrt(gamma * R * T2);
    V2 = M2 * a2;

    p2 = p0_2 / (1 + (gamma-1)/2 * M2^2)^(gamma/(gamma-1));

    T = (p2 - p1)*A + mdot*(V2 - V1);
end

diameters = linspace(0.03, 0.12, 200);   
ThrustVals = arrayfun(@thrust_for_d, diameters);

figure('Position',[100 100 900 450]);
plot(diameters*1000, ThrustVals, 'LineWidth', 2);

xlabel('EDF diameter (mm)', 'FontSize', 12);
ylabel('Thrust (N)', 'FontSize', 12);
title('Thrust vs diameter', 'FontSize', 14);

ylim([0 20]);     
grid on;

