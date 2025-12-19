% --- Simple Airfoil Profile Plotter ---
% This script reads and plots just two specified airfoil .dat files
% on the same figure.

clear;
clc;
close all; % Closes all existing plot windows

%% 1. SETUP - Define your .dat files

% --- IMPORTANT ---
% Set the number of header lines to skip in your .dat files.
% It's usually 1.
numHeaderLines = 1; 

% The two files you want to plot
airfoil_1_Name = 'GA(W)-1 17%.dat';
airfoil_2_Name = 'GA(W)-2 13%.dat';

%% 2. READ AND PLOT AIRFOILS

disp('Plotting GA(W)-1 17% and GA(W)-2 13%...');
figure; % Create ONE new window for the plot
hold on; % Tell MATLAB to draw all plots on this same figure

% --- Plot Airfoil 1 ---
try
    coords1 = readmatrix(airfoil_1_Name, 'FileType', 'text', 'NumHeaderLines', numHeaderLines);
    X1 = coords1(:, 1);
    Y1 = coords1(:, 2);
    
    plot(X1, Y1, 'b-', 'LineWidth', 1.5, 'DisplayName', 'GA(W)-1 17% [root]');
         
catch ME
    disp(['ERROR reading file: ', airfoil_1_Name]);
    disp(ME.message);
end

% --- Plot Airfoil 2 ---
try
    coords2 = readmatrix(airfoil_2_Name, 'FileType', 'text', 'NumHeaderLines', numHeaderLines);
    X2 = coords2(:, 1);
    Y2 = coords2(:, 2);
    
    plot(X2, Y2, 'r--', 'LineWidth', 1.5, 'DisplayName', 'GA(W)-2 13% [tip]');
         
catch ME
    disp(['ERROR reading file: ', airfoil_2_Name]);
    disp(ME.message);
end

%% 3. FORMAT THE PLOT

hold off; % Stop drawing on this figure
grid on;
axis equal; % CRITICAL: Keeps the airfoil shape correct
title('Airfoil Profile Comparison');
xlabel('Chord (x/c)');
ylabel('Thickness (y/c)');
legend('show', 'Location', 'best'); % Show the legend

disp('Airfoil plotting complete.');