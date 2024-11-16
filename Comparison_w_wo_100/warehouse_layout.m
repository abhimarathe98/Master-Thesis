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

unloading_x = [10, 25, 40, 77.5, 77.5];
unloading_y = [72.5, 72.5, 72.5, 80, 95];

% Plot the unloading stations
plot(unloading_x, unloading_y, 'r^', 'MarkerSize', 3, 'MarkerFaceColor', 'r');

% Define the robot start positions
robot_positions = [5, 5; 5, 10; 5, 15; 5, 20; 5, 25];

% Plot the robot start positions
hold on;
plot(robot_positions(:,1), robot_positions(:,2), 'mo', 'MarkerSize', 2, 'MarkerFaceColor', 'm');
 

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

% Define the unloading areas

unloading_x = [130, 145, 160, 175, 190, 130, 145, 160, 175, 190];
unloading_y = [32.5, 32.5, 32.5, 32.5, 32.5, 72.5, 72.5, 72.5, 72.5, 72.5];

% Plot the unloading stations
plot(unloading_x, unloading_y, 'r^', 'MarkerSize', 3, 'MarkerFaceColor', 'r');

% Define the robot start positions
robot_positions = [105, 95; 105, 90; 105, 85; 195, 95; 195, 90];

% Plot the robot start positions
hold on;
plot(robot_positions(:,1), robot_positions(:,2), 'mo', 'MarkerSize', 2, 'MarkerFaceColor', 'm');

%% 

%%%%% ROOM 3 LAYOUT %%%%%

% Define the outer boundary for Room 3 (100x100 meters)
plot([100 200 200 100 100], [100 100 200 200 100], 'k', 'LineWidth', 2);

% Conveyors to load into delivery trucks

fill([105 105 130 130], [105 120 120 105], 'k'); % Unloading Rack 1

fill([105 105 130 130], [125 140 140 125], 'k'); % Unloading Rack 2

fill([105 105 130 130], [170 195 195 170], 'k'); % Unloading Rack 3

fill([170 170 200 200], [140 150 150 140], 'k'); % Unloading Rack 4

fill([170 170 200 200], [155 165 165 155], 'k'); % Unloading Rack 5

fill([170 170 200 200], [170 180 180 170], 'k'); % Unloading Rack 6

fill([170 170 200 200], [185 195 195 185], 'k'); % Unloading Rack 7

unloading_x = [132.5, 132.5, 132.5, 167.5, 167.5, 167.5, 167.5];
unloading_y = [112.5, 132.5, 182.5, 145, 160, 175, 190];

% Plot the unloading stations
plot(unloading_x, unloading_y, 'r^', 'MarkerSize', 3, 'MarkerFaceColor', 'r');

% Define the robot start positions
robot_positions = [195, 105; 195, 110; 195, 115; 195, 120; 195, 125];

% Plot the robot start positions
hold on;
plot(robot_positions(:,1), robot_positions(:,2), 'mo', 'MarkerSize', 2, 'MarkerFaceColor', 'm');

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
unloading_x = [10, 25, 40, 55, 10, 25, 40, 10, 25, 40];
unloading_y = [167.5, 167.5, 167.5, 167.5, 142.5, 142.5, 142.5, 117.5, 117.5, 117.5];


% Plot the unloading stations
plot(unloading_x, unloading_y, 'r^', 'MarkerSize', 3, 'MarkerFaceColor', 'r');

text(85, 120, 'Office', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7.5);

% Define the robot start positions
robot_positions = [75, 195; 80, 195; 85, 195; 90, 195; 95, 195];

% Plot the robot start positions
hold on;
plot(robot_positions(:,1), robot_positions(:,2), 'mo', 'MarkerSize', 2, 'MarkerFaceColor', 'm');
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

% Plot the access points (APs)
ap_positions = [
    50, 50;    % AP1 in Room 1
    150, 50;   % AP2 in Room 2
    150, 150;  % AP3 in Room 3
    50, 150;   % AP4 in Room 4
];

for i = 1:size(ap_positions, 1)
    plot(ap_positions(i, 1), ap_positions(i, 2), 'mx', 'MarkerSize', 5, 'LineWidth', 2);
    text(ap_positions(i, 1), ap_positions(i, 2), sprintf('AP%d', i), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7.5, 'Color', 'magenta');
end
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