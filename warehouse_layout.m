function warehouse_layout()

% Define the figure
figure;
hold on;
%% 

%%%%% ROOM 1 LAYOUT %%%%%

% Define the outer boundary for Room 1 (100x100 meters)
plot([0 100 100 0 0], [0 0 100 100 0], 'k', 'LineWidth', 2);

% Define the walls (black areas) as filled polygons
% Draw obstacles (partitions and blocks)

% Conveyor for arriving packages
fill([35 35 40 40], [30 45 45 30], 'k'); % Vertical conveyor

fill([35 35 60 60], [25 30 30 25], 'k'); % Horizontal conveyor 1

fill([0 0 40 40], [40 45 45 40], 'k'); % Horizontal conveyor 2

% Block 1
fill([60 60 70 70], [20 35 35 20], 'k'); % Small block near loading station

% Rack 1
fill([5 5 15 15], [75 100 100 75], 'k'); % Unloading rack 1

% Rack 2
fill([20 20 30 30], [75 100 100 75], 'k'); % Unloading rack 2

% Rack 3
fill([35 35 45 45], [75 100 100 75], 'k'); % Unloading rack 3

% Rack 4
fill([80 80 100 100], [90 100 100 90], 'k'); % Unloading rack 4

% Rack 5
fill([80 80 100 100], [75 85 85 75], 'k'); % Unloading rack 5

% Obstacle 1
fill([60 60 65 65], [65 70 70 65], 'k'); % Obstacle 1

% Obstacle 2
fill([60 60 65 65], [55 60 60 55], 'k'); % Obstacle 2

% Define the charging and loading/unloading areas
charging_x = [5, 5, 5, 5, 5];
charging_y = [5, 10, 15, 20, 25];

loading_x = 75;
loading_y = 27.5;

unloading_x = [10, 25, 40, 77.5, 77.5];
unloading_y = [72.5, 72.5, 72.5, 80, 95];

% Plot the charging stations
plot(charging_x, charging_y, 'b^', 'MarkerSize', 5, 'MarkerFaceColor', 'b');
text(17.5, 5, 'Charging', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7.5);

% Plot the loading stations
plot(loading_x, loading_y, 'g^', 'MarkerSize', 5, 'MarkerFaceColor', 'g');
text(75, 25, 'Loading', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 7.5);

% Plot the unloading stations
plot(unloading_x, unloading_y, 'r^', 'MarkerSize', 5, 'MarkerFaceColor', 'r');
text(25, 67.5, 'Unloading', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7.5);
text(70, 87.5, 'Unloading', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7.5);


%% 

%%%%% ROOM 2 LAYOUT %%%%%

% Define the outer boundary for Room 2 (100x100 meters)
plot([100 200 200 100 100], [0 0 100 100 0], 'k', 'LineWidth', 2);

% Rack 1
fill([125 125 135 135], [0 30 30 0], 'k'); % Unloading rack 1

% Rack 2
fill([140 140 150 150], [0 30 30 0], 'k'); % Unloading rack 2

% Rack 3
fill([155 155 165 165], [0 30 30 0], 'k'); % Unloading rack 3

% Rack 4
fill([170 170 180 180], [0 30 30 0], 'k'); % Unloading rack 4

% Rack 5
fill([185 185 195 195], [0 30 30 0], 'k'); % Unloading rack 5

% Rack 6
fill([125 125 135 135], [40 70 70 40], 'k'); % Unloading rack 6

% Rack 7
fill([140 140 150 150], [40 70 70 40], 'k'); % Unloading rack 7

% Rack 8
fill([155 155 165 165], [40 70 70 40], 'k'); % Unloading rack 8

% Rack 9
fill([170 170 180 180], [40 70 70 40], 'k'); % Unloading rack 9

% Rack 10
fill([185 185 195 195], [40 70 70 40], 'k'); % Unloading rack 10

% Define the charging and unloading areas
charging_x = [110, 110];
charging_y = [90, 95];

unloading_x = [130, 145, 160, 175, 190, 130, 145, 160, 175, 190];
unloading_y = [32.5, 32.5, 32.5, 32.5, 32.5, 72.5, 72.5, 72.5, 72.5, 72.5];

% Plot the charging stations
plot(charging_x, charging_y, 'b^', 'MarkerSize', 5, 'MarkerFaceColor', 'b');
text(110, 85, 'Charging', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7.5);

% Plot the unloading stations
plot(unloading_x, unloading_y, 'r^', 'MarkerSize', 5, 'MarkerFaceColor', 'r');
text(160, 32.5, 'Unloading', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7.5);
text(160, 72.5, 'Unloading', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7.5);

%% 

%%%%% ROOM 3 LAYOUT %%%%%

% Define the outer boundary for Room 3 (100x100 meters)
plot([100 200 200 100 100], [100 100 200 200 100], 'k', 'LineWidth', 2);

% Conveyors to load into delivery trucks
fill([160 160 165 165], [122.5, 187.5, 187.5, 122.5], 'k'); % Vertical conveyor

fill([165 165 190 190], [122.5 127.5 127.5 122.5], 'k'); % Horizontal conveyor 1

fill([165 165 190 190], [142.5 147.5 147.5 142.5], 'k'); % Horizontal conveyor 2

fill([165 165 190 190], [162.5 167.5 167.5 162.5], 'k'); % Horizontal conveyor 3

fill([165 165 190 190], [182.5 187.5 187.5 182.5], 'k'); % Horizontal conveyor 4

fill([140 140 160 160], [152.5 157.5 157.5 152.5], 'k'); % Horizontal conveyor 4

% Obstacle 1
fill([110 110 120 120], [110 120 120 110], 'k'); % Obstacle 1

% Obstacle 2
fill([110 110 120 120], [130 140 140 130], 'k'); % Obstacle 2

% Define the charging and loading areas
charging_x = [110, 110];
charging_y = [190, 195];

loading_x = 137.5;
loading_y = 155;

% Plot the charging stations
plot(charging_x, charging_y, 'b^', 'MarkerSize', 5, 'MarkerFaceColor', 'b');
text(110, 185, 'Charging', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7.5);

% Plot the loading stations
plot(loading_x, loading_y, 'g^', 'MarkerSize', 5, 'MarkerFaceColor', 'g');
text(130, 155, 'Loading', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 7.5);

% Door for the truck in Room 3
plot([200, 200], [120, 130], 'w', 'LineWidth', 2);
plot([200, 200], [140, 150], 'w', 'LineWidth', 2);
plot([200, 200], [160, 170], 'w', 'LineWidth', 2);
plot([200, 200], [180, 190], 'w', 'LineWidth', 2);

%% 

%%%%% ROOM 4 LAYOUT %%%%%

% Define the outer boundary for Room 4 (100x100 meters)
plot([0 100 100 0 0], [100 100 200 200 100], 'k', 'LineWidth', 2);

% Rack 1
fill([5 5 15 15], [170 200 200 170], 'k'); % Unloading rack 1

% Rack 2
fill([20 20 30 30], [170 200 200 170], 'k'); % Unloading rack 2

% Rack 3
fill([35 35 45 45], [170 200 200 170], 'k'); % Unloading rack 3

% Rack 4
fill([50 50 60 60], [170 200 200 170], 'k'); % Unloading rack 4

% Block 1
fill([5 5 15 15], [105 115 115 105], 'k');

% Block 2
fill([20 20 30 30], [105 115 115 105], 'k');

% Block 3
fill([35 35 45 45], [105 115 115 105], 'k');

% Block 4
fill([5 5 15 15], [130 140 140 130], 'k');

% Block 5
fill([20 20 30 30], [130 140 140 130], 'k');

% Block 6
fill([35 35 45 45], [130 140 140 130], 'k');

% Office
plot([70 70 100 100 70], [100 140 140 100 100], 'k', 'LineWidth', 2);
plot([70 70], [117.5 122.5], 'w', 'LineWidth', 2);

% Define the charging and unloading areas
charging_x = [90, 90];
charging_y = [190, 195];

unloading_x = [10, 25, 40, 55, 10, 25, 40, 10, 25, 40];
unloading_y = [167.5, 167.5, 167.5, 167.5, 142.5, 142.5, 142.5, 117.5, 117.5, 117.5];

% Plot the charging stations
plot(charging_x, charging_y, 'b^', 'MarkerSize', 5, 'MarkerFaceColor', 'b');
text(90, 185, 'Charging', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7.5);

% Plot the unloading stations
plot(unloading_x, unloading_y, 'r^', 'MarkerSize', 5, 'MarkerFaceColor', 'r');
text(32.5, 162.5, 'Unloading', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7.5);
text(25, 147.5, 'Unloading', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7.5);
text(25, 122.5, 'Unloading', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7.5);


text(85, 120, 'Office', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7.5);
%% 

%%%%% DOORS BETWEEN ROOMS %%%%%
% Door between Room 1 and Room 2
plot([100 100], [50 60], 'w', 'LineWidth', 2);

% Door between Room 2 and Room 3
plot([150 160], [100 100], 'w', 'LineWidth', 2);

% Door between Room 3 and Room 4
plot([100 100], [150 160], 'w', 'LineWidth', 2);

% Door between Room 4 and Room 1
plot([50 60], [100 100], 'w', 'LineWidth', 2);
%% 

% Set the axis limits and labels
axis([0 200 0 200]);
xlabel('X [meters]');
ylabel('Y [meters]');
title('Warehouse Layout');
grid on;
hold off;

% Adjust the aspect ratio
axis equal;