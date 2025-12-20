d = 0: 0.1 : 15;
kV1 = 1500;
kV2 = 580; %kV rating of motor (assumed)

RPM1 = 19536.1; %motor connected to 4S battery
RPM2 = 8863; %motor connected to 4S battery

pitch1 = 4; %inches
pitch2 = 7;

rho = 1.225; %sea-level air density

V_e1 = RPM1 * pitch1 * 0.0254 * (1/60); %m/s
V_e2 = RPM2 * pitch2 * 0.0254 * (1/60); %m/s
V_01 = 20;
V_02 = 80;%m/s

F_theoretical1 = 0.25 * (rho * pi * (0.0254 * d).^2) * V_e1 * (V_e1 - V_01); %theoretical dynamic thrust force
F_theoretical2 = -0.25 * (rho * pi * (0.0254 * d).^2) * V_e2 * (V_e2 - V_02);

k1 = 1/3.29546;
k2 = 1.5;
EF1 = (k1 * (d/pitch1)).^k2;
EF2 = (k1 * (d/pitch2)).^k2;

F_per_prop1 = (F_theoretical1 .* EF1);
F_per_prop2 = (F_theoretical2 .* EF2);

F_final1 = F_per_prop1 * 8;
F_final2 = F_per_prop2 * 2;
% T = 4.392399 * 1e-8 * RPM * d.^(3.5) * (pitch^-0.5) * ((4.23333 * 1e-4 * RPM * pitch) - V_0) * 8

plot(d,F_final1, 'black');
hold on;
plot(d,F_final2, 'blue');
hold off;

ylabel('Net Thrust(in N)');
xlabel('Propeller Diameter (inches)');
title('Thrust vs Prop Diameter');


% since T/W should lie within [0.5,0.65] 


