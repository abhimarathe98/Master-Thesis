% Main script to perform A* path planning and Wi-Fi communication analysis (300 Robots)

% Setup and Initialization
robot = importrobot('robomaster.urdf');
grid_size = [200, 200];
obstacles = obstacle_map(grid_size);  % Generate the obstacle map using obstacle_map function

% Define the 5 main start positions (without offsets) for plotting
room1_main_positions = [5, 5; 5, 10; 5, 15; 5, 20; 5, 25];
room2_main_positions = [105, 95; 105, 90; 105, 85; 195, 95; 195, 90];
room3_main_positions = [195, 105; 195, 110; 195, 115; 195, 120; 195, 125];
room4_main_positions = [75, 195; 80, 195; 85, 195; 90, 195; 95, 195];

% Generate starting positions with random offsets for 300 robots (75 per room)
room1_positions = repmat(room1_main_positions, 15, 1) + randn(75, 2) * 2;
room2_positions = repmat(room2_main_positions, 15, 1) + randn(75, 2) * 2;
room3_positions = repmat(room3_main_positions, 15, 1) + randn(75, 2) * 2;
room4_positions = repmat(room4_main_positions, 15, 1) + randn(75, 2) * 2;

% Combine all robot positions (300 robots total)
robot_positions = [room1_positions; room2_positions; room3_positions; room4_positions];

% Round and clamp positions to grid size
robot_positions = max(min(round(robot_positions), grid_size), 1);

% Define AP positions in the rooms
ap_positions = [50, 50; 150, 50; 150, 150; 50, 150];  % 4 APs for 4 rooms

% Number of time steps
time_steps = 100;

%% Path Planning (Without Communication)
goal_positions = [];
paths = {};
computation_times_no_comm = zeros(size(robot_positions, 1), 1);
travel_times_no_comm = zeros(size(robot_positions, 1), 1);

for i = 1:size(robot_positions, 1)
    start_pos = robot_positions(i, :);
    goal_pos = random_unloading_station(obstacles);
    goal_positions = [goal_positions; goal_pos];

    % Compute the path using A* for each robot
    tic;
    path = astar_path(start_pos, goal_pos, grid_size, obstacles);
    computation_times_no_comm(i) = toc;
    travel_times_no_comm(i) = size(path, 1);  % Keep travel time as a floating-point number

    paths{i} = path;
end

% Calculate and display the average computation and travel time without communication
avg_computation_time_no_comm = mean(computation_times_no_comm);
avg_travel_time_no_comm = mean(travel_times_no_comm);
fprintf('Average Computation Time without Communication: %.5f seconds\n', avg_computation_time_no_comm);
fprintf('Average Travel Time without Communication: %.5f seconds\n\n', avg_travel_time_no_comm);

% Animation for robots without communication
trajectory_animation([room1_main_positions; room2_main_positions; room3_main_positions; room4_main_positions], goal_positions, paths, 'robot_animation_no_comm_300.mp4');

%% Communication-Aware Path Planning (With Wi-Fi Adjustment)
paths_with_comm = {};
computation_times_with_comm = zeros(size(robot_positions, 1), 1);
travel_times_with_comm = zeros(size(robot_positions, 1), 1);

% Adaptive path planning with communication
for i = 1:size(robot_positions, 1)
    start_pos = robot_positions(i, :);
    goal_pos_with_comm = goal_positions(i, :);

    % Replan the path periodically based on signal strength
    tic;
    path_with_comm = adaptive_astar_path(start_pos, goal_pos_with_comm, grid_size, obstacles, ap_positions, i);
    computation_times_with_comm(i) = toc;
    travel_times_with_comm(i) = size(path_with_comm, 1);  % Keep travel time as a floating-point number

    paths_with_comm{i} = path_with_comm;
end

% Calculate and display the average computation and travel time with communication
avg_computation_time_with_comm = mean(computation_times_with_comm);
avg_travel_time_with_comm = mean(travel_times_with_comm);
fprintf('Average Computation Time with Communication: %.5f seconds\n', avg_computation_time_with_comm);
fprintf('Average Travel Time with Communication: %.5f seconds\n\n', avg_travel_time_with_comm);

% Animation for robots with communication
trajectory_animation([room1_main_positions; room2_main_positions; room3_main_positions; room4_main_positions], goal_positions, paths_with_comm, 'robot_animation_with_comm_300.mp4');

%% Old Graphs (Restored)

% 1. Path Length Comparison
figure;
boxplot([travel_times_no_comm, travel_times_with_comm], 'Labels', {'W/o Communication', 'W/ Communication'});
ylabel('Path Length (Number of Steps)');
%title('Comparison of Path Lengths: With vs. Without Communication (300 Robots)');
grid on;
saveas(gcf, 'Path_Length_Comparison.pdf');

% 2. Computation Time Comparison
figure;
boxplot([computation_times_no_comm, computation_times_with_comm], 'Labels', {'W/o Communication', 'W/ Communication'});
ylabel('Computation Time (Seconds)');
%title('Comparison of Computation Times: With vs. Without Communication (300 Robots)');
grid on;
saveas(gcf, 'Computation_Time_Comparison.pdf');

% 3. Travel Time Comparison
figure;
boxplot([travel_times_no_comm, travel_times_with_comm], 'Labels', {'W/o Communication', 'W/ Communication'});
ylabel('Travel Time (Number of Steps)');
%title('Comparison of Travel Times: With vs. Without Communication (300 Robots)');
grid on;
saveas(gcf, 'Travel_Time_Comparison.pdf');