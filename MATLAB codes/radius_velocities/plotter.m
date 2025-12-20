%% MATLAB Script to Plot Wake and Swirl Velocity from a Data File
clear;
close all;
clc;

%% 1. Load Data from File
% Define the name of your data file
filename = 'the_text.txt';

% Use readmatrix to load the numeric data.
% This function automatically handles text headers and detects delimiters (like tabs).
try
    data = readmatrix(filename);
catch ME
    % Error handling in case the file isn't found
    fprintf('Error loading file: %s\n', filename);
    fprintf('Please make sure ''%s'' is in the same directory as this script.\n', filename);
    fprintf('Error message: %s\n', ME.message);
    return; % Stop the script if the file can't be read
end

%% 2. Extract Variables for Plotting
% Column 1: Radius (m)
% Column 5: Wake Velocity (m/s)
% Column 6: Swirl Velocity (m/s)
radius = data(:, 1);          % X-Axis
wake_velocity = data(:, 5);   % Y1-Axis (Left)
swirl_velocity = data(:, 6);  % Y2-Axis (Right)

%% 3. Create the Plot
figure; % Create a new figure window
ax = gca; % Get current axes
ax.FontName = 'Times New Roman'; % Set main font to a serif font
ax.FontSize = 12; % Slightly increase font size for readability

% --- Plot Wake Velocity on the LEFT Y-axis ---
yyaxis left;
plot(radius, wake_velocity, '-r', 'LineWidth', 2); % Solid red line
ylabel('Wake Velocity (m/s)', 'FontName', 'Times New Roman', 'FontSize', 12);
% Set the color of the left axis to match the line
ax.YColor = 'r';

% --- Plot Swirl Velocity on the RIGHT Y-axis ---
yyaxis right;
% Change plot color from black ('k') to blue ('b')
plot(radius, swirl_velocity, 'o--b', 'LineWidth', 1.5, 'MarkerFaceColor', 'b', 'MarkerEdgeColor', 'b'); % Blue dashed line with markers
ylabel('Swirl Velocity (m/s)', 'FontName', 'Times New Roman', 'FontSize', 12);
% Set the color of the right axis to match the line
ax.YColor = 'b';

%% 4. Add Final Touches (Labels, Title, Legend)
xlabel('Radius (m)', 'FontName', 'Times New Roman', 'FontSize', 12); % Common X-axis label
title('Radius vs. Wake and Swirl Velocity', 'FontName', 'Times New Roman', 'FontSize', 14);
lgd = legend('Wake Velocity', 'Swirl Velocity', 'Location', 'northeast');
lgd.FontName = 'Times New Roman'; % Set legend font
lgd.FontSize = 11;
grid on; % Add a grid
box on;  % Show a box around the plot

fprintf('Plot created successfully from %s.\n', filename);