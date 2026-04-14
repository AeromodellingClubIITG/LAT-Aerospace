
data = readtable('vasa65thrVrpm.txt', ...
                 'FileType','text', ...
                 'CommentStyle','%', ...
                 'Delimiter','\t', ...
                 'ReadVariableNames',false);
data.Properties.VariableNames = {'RPM','Thrust_g'};

rpm = data.RPM;
thrust = data.Thrust_g;

fig = figure('Color','w','Units','pixels','Position',[100 100 1035 600]);
ax = axes('Parent',fig);
hold(ax,'on');

sz = 90;
scatter(ax, rpm, thrust, sz, 'MarkerFaceColor',[1 0.6 0], ...
                         'MarkerEdgeColor','k', 'LineWidth',0.5);

title(ax,'Thrust vs RPM','FontWeight','bold','FontSize',16);
xlabel(ax,'RPM','FontSize',14);
ylabel(ax,'Thrust (g)','FontSize',14);

xticks([38000 42000 46000 50000 54000 58000 62000]);
xlim([36000 64000]);
ax.XAxis.Exponent = 4;

grid(ax,'on');
ax.GridAlpha = 0.15;
ax.LineWidth = 0.8;
ax.FontSize = 12;
ax.Color = [1 1 1];
box(ax,'off');

hold(ax,'off');
