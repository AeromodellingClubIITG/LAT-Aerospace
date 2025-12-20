% --- XFLR5 Multi-File 2x2 Plotter (Publication Style + Median Smoothing) ---
clear;
clc;
close all; % Closes all existing plot windows

%% 1. SETUP - Define your files and settings

% --- DATA SMOOTHING ---
% Set the strength of the smoothing. Must be an ODD number.
% 3 or 5 is a good starting point. Use 1 to turn off smoothing.
smoothingFactor = 9; % (e.g., 9-point moving median)

% We assume ALL files have exactly 11 lines of text to skip.
numHeaderLinesToSkip = 11;

% Airfoil names from your script
airfoilNames = {
%    'NACA 64(2)-415';
%    'NACA 63A-516';
%    'NACA 63-415';
    'NASA SC(2)-0714';
    'NASA SC(2)-0712';
    'NASA SC(2)-0610';
    'NASA SC(2)-0410';
    'GAW-2 13%';
    'GAW-1 15%';
    'GAW-1 12%';
    'GAW-1 17%'
};

% Suffixes from your screenshot
regimeSuffixes = {
    '_T3_Re0.060_M0.24_N9.0.txt'; % This is Cruise
    '_T3_Re0.019_M0.06_N9.0.txt'  % This is Take-off
};

% Legends - Updated as requested
regimeLegends = {
    'Cruise (Rn = 0.6e5, M = 0.24)'; 
    'Take-off (Rn = 0.19e5, M = 0.06)'
};

% Get a set of colors for the airfoil plots
plotColors = lines(length(airfoilNames));

%% 2. GENERATE PLOTS 1 & 2 (Grouped by Regime)
% Each figure will be a 2x2 grid showing all 8 airfoils
disp('Generating plots 1 & 2 (Grouped by Regime)...');
for i = 1:length(regimeSuffixes)
    figure('Position', [100, 100, 800, 700]); % Create a new figure window (width, height)
    sgtitle(['All Airfoils - ', regimeLegends{i}], 'FontWeight', 'bold', 'FontName', 'Times New Roman', 'FontSize', 16);
    
    % --- Setup the 4 subplots ---
    ax1 = subplot(2, 2, 1);
    formatAxes(ax1, '{\it C_L} vs {\it \alpha}', 'Angle of Attack, {\it \alpha} (degrees)', 'Lift Coefficient ({\it C_L})');
    
    ax2 = subplot(2, 2, 2);
    formatAxes(ax2, '{\it C_D} vs {\it \alpha}', 'Angle of Attack, {\it \alpha} (degrees)', 'Drag Coefficient ({\it C_D})');
    
    ax3 = subplot(2, 2, 3);
    formatAxes(ax3, '{\it C_L}/{\it C_D} vs {\it \alpha}', 'Angle of Attack, {\it \alpha} (degrees)', 'Lift-to-Drag Ratio ({\it C_L}/{\it C_D})');
    
    ax4 = subplot(2, 2, 4);
    formatAxes(ax4, '{\it C_L} vs {\it C_D} (Drag Polar)', 'Drag Coefficient ({\it C_D})', 'Lift Coefficient ({\it C_L})');
    
    % --- Loop through airfoils and plot on all 4 subplots ---
    for j = 1:length(airfoilNames)
        fileName = [airfoilNames{j}, regimeSuffixes{i}];
        
        try
            dataMatrix = readmatrix(fileName, 'FileType', 'text', 'NumHeaderLines', numHeaderLinesToSkip);
            alpha = dataMatrix(:, 1); % Column 1
            CL = dataMatrix(:, 2);    % Column 2
            CD = dataMatrix(:, 3);    % Column 3
            
            % --- Apply smoothing with MOVING MEDIAN ---
            CL_smooth = smoothdata(CL, 'movmedian', smoothingFactor);
            CD_smooth = smoothdata(CD, 'movmedian', smoothingFactor);
            % Calculate L/D *after* smoothing to prevent 0/0 errors
            CL_over_CD_smooth = CL_smooth ./ CD_smooth;
            
            % Plot on all 4 axes using SMOOTHED data
            plot(ax1, alpha, CL_smooth, 'LineWidth', 1.5, 'Color', plotColors(j,:), 'DisplayName', airfoilNames{j});
            plot(ax2, alpha, CD_smooth, 'LineWidth', 1.5, 'Color', plotColors(j,:), 'DisplayName', airfoilNames{j});
            plot(ax3, alpha, CL_over_CD_smooth, 'LineWidth', 1.5, 'Color', plotColors(j,:), 'DisplayName', airfoilNames{j});
            plot(ax4, CD_smooth, CL_smooth, 'LineWidth', 1.5, 'Color', plotColors(j,:), 'DisplayName', airfoilNames{j});
                 
        catch ME
            disp(['ERROR reading file: ', fileName]);
            disp(ME.message);
        end
    end
    % Add a single legend to the first plot
    lgd = legend(ax1, 'show', 'Location', 'best');
    set(lgd, 'FontName', 'Times New Roman', 'FontSize', 10);
end

%% 3. GENERATE PLOTS 3-10 (Grouped by Airfoil)
% Each figure will be a 2x2 grid showing both regimes
disp(['Generating plots 3-', num2str(length(airfoilNames) + 2), ' (Grouped by Airfoil)...']);
for j = 1:length(airfoilNames)
    figure('Position', [100, 100, 800, 700]); % Create a new figure window (width, height)
    sgtitle(['Airfoil: ', airfoilNames{j}], 'FontWeight', 'bold', 'FontName', 'Times New Roman', 'FontSize', 16);
    
    % --- Setup the 4 subplots ---
    ax1 = subplot(2, 2, 1);
    formatAxes(ax1, '{\it C_L} vs {\it \alpha}', 'Angle of Attack, {\it \alpha} (degrees)', 'Lift Coefficient ({\it C_L})');
    ax2 = subplot(2, 2, 2);
    formatAxes(ax2, '{\it C_D} vs {\it \alpha}', 'Angle of Attack, {\it \alpha} (degrees)', 'Drag Coefficient ({\it C_D})');
    ax3 = subplot(2, 2, 3);
    formatAxes(ax3, '{\it C_L}/{\it C_D} vs {\it \alpha}', 'Angle of Attack, {\it \alpha} (degrees)', 'Lift-to-Drag Ratio ({\it C_L}/{\it C_D})');
    ax4 = subplot(2, 2, 4);
    formatAxes(ax4, '{\it C_L} vs {\it C_D} (Drag Polar)', 'Drag Coefficient ({\it C_D})', 'Lift Coefficient ({\it C_L})');
    
    % Get file names for both regimes
    fileName1 = [airfoilNames{j}, regimeSuffixes{1}]; % Cruise
    fileName2 = [airfoilNames{j}, regimeSuffixes{2}]; % Take-off
    
    % --- Plot Regime 1 (Cruise) - Solid Line ---
    try
        dataMatrix1 = readmatrix(fileName1, 'FileType', 'text', 'NumHeaderLines', numHeaderLinesToSkip);
        alpha1 = dataMatrix1(:, 1);
        CL1 = dataMatrix1(:, 2);
        CD1 = dataMatrix1(:, 3);
        
        % --- Apply smoothing with MOVING MEDIAN ---
        CL1_smooth = smoothdata(CL1, 'movmedian', smoothingFactor);
        CD1_smooth = smoothdata(CD1, 'movmedian', smoothingFactor);
        CL_over_CD1_smooth = CL1_smooth ./ CD1_smooth;
        
        plot(ax1, alpha1, CL1_smooth, 'b-', 'LineWidth', 1.5, 'DisplayName', regimeLegends{1});
        plot(ax2, alpha1, CD1_smooth, 'b-', 'LineWidth', 1.5, 'DisplayName', regimeLegends{1});
        plot(ax3, alpha1, CL_over_CD1_smooth, 'b-', 'LineWidth', 1.5, 'DisplayName', regimeLegends{1});
        plot(ax4, CD1_smooth, CL1_smooth, 'b-', 'LineWidth', 1.5, 'DisplayName', regimeLegends{1});
    catch ME
        disp(['ERROR reading file: ', fileName1]);
        disp(ME.message);
    end
    
    % --- Plot Regime 2 (Take-off) - Dashed Line ---
    try
        dataMatrix2 = readmatrix(fileName2, 'FileType', 'text', 'NumHeaderLines', numHeaderLinesToSkip);
        alpha2 = dataMatrix2(:, 1);
        CL2 = dataMatrix2(:, 2);
        CD2 = dataMatrix2(:, 3);
        
        % --- Apply smoothing with MOVING MEDIAN ---
        CL2_smooth = smoothdata(CL2, 'movmedian', smoothingFactor);
        CD2_smooth = smoothdata(CD2, 'movmedian', smoothingFactor);
        CL_over_CD2_smooth = CL2_smooth ./ CD2_smooth;
        
        plot(ax1, alpha2, CL2_smooth, 'r--', 'LineWidth', 1.5, 'DisplayName', regimeLegends{2});
        plot(ax2, alpha2, CD2_smooth, 'r--', 'LineWidth', 1.5, 'DisplayName', regimeLegends{2});
        plot(ax3, alpha2, CL_over_CD2_smooth, 'r--', 'LineWidth', 1.5, 'DisplayName', regimeLegends{2});
        plot(ax4, CD2_smooth, CL2_smooth, 'r--', 'LineWidth', 1.5, 'DisplayName', regimeLegends{2});
    catch ME
        disp(['ERROR reading file: ', fileName2]);
        disp(ME.message);
    end
    
    % Add a single legend to the first plot
    lgd = legend(ax1, 'show', 'Location', 'best');
    set(lgd, 'FontName', 'Times New Roman', 'FontSize', 12);
end
disp(['All ', num2str(length(airfoilNames) + 2), ' four-pack plots generated successfully.']);

%% 5. HELPER FUNCTION TO FORMAT AXES
% This function applies the professional styling to each subplot
function formatAxes(ax, plotTitle, xLabel, yLabel)
    hold(ax, 'on'); % Ensure we can plot multiple lines
    
    % Set the font and size for a more professional look
    set(ax, ...
        'FontName', 'Times New Roman', ... % Use a serif font
        'FontSize', 12, ...               % Set axis font size
        'Box', 'on', ...                  % Ensure plot box is on
        'LineWidth', 1);                  % Set axis line width
    
    % Apply titles and labels
    title(ax, plotTitle, 'FontSize', 14, 'FontWeight', 'normal');
    xlabel(ax, xLabel, 'FontSize', 12);
    ylabel(ax, yLabel, 'FontSize', 12);
    
    grid(ax, 'on'); % Turn the grid on
end