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
plot([110 210 210 110 110], [0 0 100 100 0], 'k', 'LineWidth', 2);

% Rack 1
fill([135 135 145 145], [0 30 30 0], 'k'); % Unloading rack 1

% Rack 2
fill([150 150 160 160], [0 30 30 0], 'k'); % Unloading rack 2

% Rack 3
fill([165 165 175 175], [0 30 30 0], 'k'); % Unloading rack 3

% Rack 4
fill([180 180 190 190], [0 30 30 0], 'k'); % Unloading rack 4

% Rack 5
fill([195 195 205 205], [0 30 30 0], 'k'); % Unloading rack 5

% Rack 6
fill([135 135 145 145], [40 70 70 40], 'k'); % Unloading rack 6

% Rack 7
fill([150 150 160 160], [40 70 70 40], 'k'); % Unloading rack 7

% Rack 8
fill([165 165 175 175], [40 70 70 40], 'k'); % Unloading rack 8

% Rack 9
fill([180 180 190 190], [40 70 70 40], 'k'); % Unloading rack 9

% Rack 10
fill([195 195 205 205], [40 70 70 40], 'k'); % Unloading rack 10

% Define the unloading areas

unloading_x = [140, 155, 170, 185, 200, 140, 155, 170, 185, 200];
unloading_y = [32.5, 32.5, 32.5, 32.5, 32.5, 72.5, 72.5, 72.5, 72.5, 72.5];

% Plot the unloading stations
plot(unloading_x, unloading_y, 'r^', 'MarkerSize', 3, 'MarkerFaceColor', 'r');

% Define the robot start positions
robot_positions = [115, 95; 115, 90; 115, 85; 205, 95; 205, 90];

% Plot the robot start positions
hold on;
plot(robot_positions(:,1), robot_positions(:,2), 'mo', 'MarkerSize', 2, 'MarkerFaceColor', 'm');

%% 

%%%%% ROOM 3 LAYOUT %%%%%

% Define the outer boundary for Room 3 (100x100 meters)
plot([110 210 210 110 110], [110 110 210 210 110], 'k', 'LineWidth', 2);

fill([110 110 135 135], [110 125 125 110], 'k'); % Unloading Rack 1

fill([110 110 135 135], [130 145 145 130], 'k'); % Unloading Rack 2

fill([110 110 135 135], [180 205 205 180], 'k'); % Unloading Rack 3

fill([175 175 205 205], [150 160 160 150], 'k'); % Unloading Rack 4

fill([175 175 205 205], [165 175 175 165], 'k'); % Unloading Rack 5

fill([175 175 205 205], [180 190 190 180], 'k'); % Unloading Rack 6

fill([175 175 205 205], [195 205 205 195], 'k'); % Unloading Rack 7

unloading_x = [137.5, 137.5, 137.5, 172.5, 172.5, 172.5, 172.5];
unloading_y = [117.5, 137.5, 192.5, 155, 170, 185, 200];

% Plot the unloading stations
plot(unloading_x, unloading_y, 'r^', 'MarkerSize', 3, 'MarkerFaceColor', 'r');

% Define the robot start positions
robot_positions = [205, 115; 205, 120; 205, 125; 205, 130; 205, 135];

% Plot the robot start positions
hold on;
plot(robot_positions(:,1), robot_positions(:,2), 'mo', 'MarkerSize', 2, 'MarkerFaceColor', 'm');

%% 

%%%%% ROOM 4 LAYOUT %%%%%

% Define the outer boundary for Room 4 (100x100 meters)
plot([0 100 100 0 0], [110 110 210 210 110], 'k', 'LineWidth', 2);

% Rack 1
fill([5 5 15 15], [170 210 210 170], 'k'); % Unloading rack 1

% Rack 2
fill([20 20 30 30], [170 210 210 170], 'k'); % Unloading rack 2

% Rack 3
fill([35 35 45 45], [170 210 210 170], 'k'); % Unloading rack 3

% Rack 4
fill([50 50 60 60], [170 210 210 170], 'k'); % Unloading rack 4

% Block 1
fill([5 5 15 15], [110 120 120 110], 'k');

% Block 2
fill([20 20 30 30], [110 120 120 110], 'k');

% Block 3
fill([35 35 45 45], [110 120 120 110], 'k');

% Block 4
fill([5 5 15 15], [130 140 140 130], 'k');

% Block 5
fill([20 20 30 30], [130 140 140 130], 'k');

% Block 6
fill([35 35 45 45], [130 140 140 130], 'k');

% Office
plot([70 70 100 100 70], [110 150 150 110 110], 'k', 'LineWidth', 2);
plot([70 70], [127.5 132.5], 'w', 'LineWidth', 2);

% Define the charging and unloading areas
unloading_x = [10, 25, 40, 55, 10, 25, 40, 10, 25, 40];
unloading_y = [167.5, 167.5, 167.5, 167.5, 142.5, 142.5, 142.5, 122.5, 122.5, 122.5];

% Plot the unloading stations
plot(unloading_x, unloading_y, 'r^', 'MarkerSize', 3, 'MarkerFaceColor', 'r');

text(85, 120, 'Office', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7.5);

% Define the robot start positions
robot_positions = [75, 205; 80, 205; 85, 205; 90, 205; 95, 205];

% Plot the robot start positions
hold on;
plot(robot_positions(:,1), robot_positions(:,2), 'mo', 'MarkerSize', 2, 'MarkerFaceColor', 'm');

%%

% Plot the access points (APs)
ap_positions = [
    50, 50;    % AP1 in Room 1
    160, 50;   % AP2 in Room 2
    160, 160;  % AP3 in Room 3
    50, 160;   % AP4 in Room 4
];

for i = 1:size(ap_positions, 1)
    plot(ap_positions(i, 1), ap_positions(i, 2), 'mx', 'MarkerSize', 5, 'LineWidth', 2);
    text(ap_positions(i, 1), ap_positions(i, 2), sprintf('AP%d', i), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7.5, 'Color', 'magenta');
end
%% 
% Corridors between rooms
% Between Room 1 and Room 2
plot([100 110 110 100 100], [45 45 55 55 45], 'k', 'LineWidth', 2);
plot([100 100], [45 55], 'w', 'LineWidth', 2);
plot([110 110], [45 55], 'w', 'LineWidth', 2);

% Between Room 2 and Room 3
plot([165 165 155 155 165], [100 110 110 100 100], 'k', 'LineWidth', 2);
plot([155 165], [100 100], 'w', 'LineWidth', 2);
plot([155 165], [110 110], 'w', 'LineWidth', 2);

% Between Room 3 and Room 4
plot([110 100 100 110 110], [165 165 155 155 165], 'k', 'LineWidth', 2);
plot([100 100], [155 165], 'w', 'LineWidth', 2);
plot([110 110], [155 165], 'w', 'LineWidth', 2);

%%
% Set the axis limits and labels
axis([0 210 0 210]);
xlabel('X [meters]');
ylabel('Y [meters]');
title('Warehouse Layout');
grid on;
hold off;

% Adjust the aspect ratio
axis equal;

saveas(gcf, 'warehouse_layout_function.pdf');
end