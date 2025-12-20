clear all;
WS = 100: 0.5 : 2000; % starting range of values (in Pa)

% starting constants:

s_g = 30; % takeoff distance 

rho_0 = 1.225; % ground air density
rho_10k = 0.908; % air density at 10,000 feet altitude
g = 9.81; % in m/s^2
mu = 0.04;
V_TO = 20; % takeoff velocity (in m/s)
V_cr = 80; % cruising velocity (in m/s)

% reference polar values
CL_max = 6.5; % reference value
CD_min = 0.022; % for L/D = 20
CD_TO = 0.45; % takeoff drag polar
CL_TO = 0.694 * CL_max; % takeoff lift polar
LD = 20; % desired lift to drag ratio 

% relations
q_0 = 0.5 * rho_0 * (V_TO^2);
q = 0.5 * rho_10k * (V_cr^2);
V_stall = V_TO/1.2;

% Takeoff ground run
TW1 = (1.21 * WS)/(rho_0 * g * CL_max * s_g) + (0.605 / CL_max) * (CD_TO - (mu * CL_TO)) + mu;

% Rate of Climb
AR = 15;
e = 0.75;
k = 1 / (pi * AR * e);

V_v = 5.08; % vertical climb velocity
V_inf = 1.3 * V_stall;

TW2 = (V_v / V_inf) + (q ./ WS) * CD_min + (k/q) * WS;

% TW for max angle of climb:
TW3 = (V_v / V_inf) + sqrt(4 * k * CD_min);

% Level constant velocity turn
n_turn = sqrt(2); % defined as (T/W)(L/D), but in our case we assume phi = 45 degrees
n_cr = 1;

TW4 = q * ( (CD_min ./ (WS)) + (k * (WS) * (n_turn/q)^2));
TW5 = q * ( (CD_min ./ (WS)) + (k * (WS) * (n_cr/q)^2));

% TW for Desired Lift-to-Drag Ratio

TW6 = 1/LD;

% Stall characterstic wing-loading

WS_stall = 0.5 * rho_0 * CL_max * V_stall^2;

% plotting
plot(WS, TW1, 'Color', '#b02525',LineWidth = 2);

hold on;
title("Constraint Diagram")
plot(WS, TW2, 'Color', '#9d22ab', LineWidth = 1.5);
yline(TW3, 'Color', '#196909', Linewidth = 1.5);
plot (WS, TW4, 'Color','#2d6ba6', LineWidth= 1.5);
plot (WS, TW5, 'Color','#27a8c4', LineWidth= 1.5);
yline(TW6, 'Color', '#95bf0b', Linewidth = 1.5);
xline(WS_stall, 'Color', '#d67627', Linewidth = 2)
yregion(0.5, 0.65, 'FaceColor', '#f2e81f', 'EdgeColor','#454212');

xlabel("W/S ($N/m^2$)", 'Interpreter', 'latex');
ylabel("T/W", 'Interpreter', 'latex');

xlim([0 1200]);
hold off;

% Calculating intersection points with Takeoff Ground Run (for Optimal
% Points)

% difference between curves
diffY = TW1 - TW2;

% find crossing index (sign change)
sign = diffY(1:end-1).*diffY(2:end);
idx = find(sign < 0);  % crossing point

WS_int = interp1(diffY(idx:idx+1), WS(idx:idx+1), 0);
TW_int = interp1(WS(idx:idx+1), TW1(idx:idx+1), WS_int);

hold on;
plot(WS_int, 0.5, 'ro', 'MarkerSize',8, 'LineWidth',2);
text(WS_int, 0.5, sprintf('(%.1f, %.1f)', WS_int, 0.5), ...
     'VerticalAlignment','top', 'FontWeight', 'Bold');

plot(WS_int, TW_int, 'bo', 'MarkerSize',8, 'LineWidth',2);
text(WS_int, TW_int, sprintf('(%.1f, %.2f)', WS_int, TW_int), ...
     'VerticalAlignment','top', 'FontWeight', 'Bold');

hold off;

diff2 = TW1 - TW4;
sign2 = diff2(1:end - 1) .* diff2(2: end);
idx2 = find(sign2 < 0);

WS_int2 = interp1( diff2(idx2 : idx2 + 1), WS(idx2 : idx2 + 1), 0);
TW_int2 = interp1(WS(idx2 : idx2 + 1), TW1(idx2 : idx2 + 1), WS_int2);

hold on;
plot(WS_int2, 0.5, 'ro', 'MarkerSize',8, 'LineWidth',2);
text(WS_int2, 0.5, sprintf('(%.1f, %.1f)', WS_int2, 0.5), ...
     'VerticalAlignment','top', 'FontWeight', 'Bold');

plot(WS_int2, TW_int2, 'bo', 'MarkerSize',8, 'LineWidth',2);
text(WS_int2, TW_int2, sprintf('(%.1f, %.2f)', WS_int2, TW_int2), ...
     'VerticalAlignment','top', 'FontWeight', 'Bold');

hold off;

xline(WS_int, 'black', LineStyle= '--', LineWidth=1);
xline(WS_int2, 'black', LineStyle= '--', LineWidth=1);

legend('Takeoff Ground Run', ...
    'Rate of Climb', ...
    'Max. angle of climb', ...
    'Constant velocity turn at 45{^\circ}', ...
    'Constant velocity cruise',...
    'Desired L/D', ...
    'Stall Wing Loading', ...
    'Constraint region of T/W');

grid minor;