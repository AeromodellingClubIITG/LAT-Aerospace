
data = readtable('aeo40vasa55thrVrpm.txt', 'FileType','text', ...
                 'CommentStyle','%','Delimiter','\t','ReadVariableNames',false);

data.Properties.VariableNames = {'RPM_AEO','Thrust_AEO','RPM_VASA','Thrust_VASA'};

rpm_aeo = data.RPM_AEO;
thrust_aeo = data.Thrust_AEO;
validA = ~isnan(rpm_aeo) & ~isnan(thrust_aeo);
rpm_aeo = rpm_aeo(validA);
thrust_aeo = thrust_aeo(validA);

rpm_vasa = data.RPM_VASA;
thrust_vasa = data.Thrust_VASA;
validV = ~isnan(rpm_vasa) & ~isnan(thrust_vasa);
rpm_vasa = rpm_vasa(validV);
thrust_vasa = thrust_vasa(validV);

figure('Color','w','Units','pixels','Position',[200 200 1100 650]);
hold on;
grid on;

sz = 80;                            
scatter(rpm_aeo, thrust_aeo, sz, 'o', ...
    'MarkerEdgeColor','blue', ...
    'MarkerFaceColor','blue', ...
    'LineWidth',0.9, ...
    'DisplayName','AEO 40mm');


scatter(rpm_vasa, thrust_vasa, sz, '^', ...
    'MarkerEdgeColor',[0 0 0], ...        
    'MarkerFaceColor',[1.0 0.55 0.20], ...
    'LineWidth',0.7, ...
    'DisplayName','Vasafan 55mm');

xlabel('RPM');
ylabel('Thrust (g)');
title('Thrust vs RPM');
legend('Location','northwest');

xticks([35000 45000 55000 65000 75000 85000 95000]);
xlim([32000 96000]);
ax = gca;
ax.XAxis.Exponent = 4;    
ax.FontSize = 12;

ax.GridAlpha = 0.18;
ax.LineWidth = 0.8;

hold off;
