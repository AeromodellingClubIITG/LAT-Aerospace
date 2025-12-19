d = 0: 0.2 : 10;
kV = 1500; %kV rating of motor (assumed)
RPM = kV * 3.7 * 4; %motor connected to 4S battery

pitch = 4; %inches
rho = 1.225; %sea-level air density

V_e = RPM * pitch * 0.0254 * (1/60); %m/s
V_0 = 20; %m/s

F_theoretical = 0.25 * (rho * pi * (0.0254 * d).^2) * V_e * (V_e - V_0); %theoretical dynamic thrust force

k1 = 1/3.29546;
k2 = 1.5;
EF = (k1 * (d/pitch)).^k2;

F_final = (F_theoretical .* EF) * 8;

% ----------------------------------- %
S = 0.306;
C_T = F_final / (0.5 * rho * (V_0)^2 * S);

n = RPM / 60;
J = V_0 ./ (n * 0.0254 * d);

plot(J, C_T, 'r', 'LineWidth', 1.4);
xlim([0 2]);

ylabel('$C_T$', 'Interpreter', 'latex');
xlabel('Advance ratio');
title('Coefficient of Thrust vs Advance Ratio');
