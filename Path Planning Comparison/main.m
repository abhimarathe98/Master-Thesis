% Main script to perform path planning using A*, Dijkstra, RRT, and PRM
% and generate various metrics and visualizations, using bar charts.

robot = importrobot('robomaster.urdf');

% Define the grid size based on the warehouse layout (200x200)
grid_size = [200, 200];

% Generate obstacles from the warehouse layout
obstacles = obstacle_map(grid_size);  % Generate the obstacle map using obstacle_map function

% Define the starting positions of the robots
robot_positions = [
    15, 5;
    15, 10;
    15, 15;
    15, 20;
    15, 25
];

% Define AP positions in the rooms
ap_positions = [
    50, 50;    % AP1 in Room 1
    150, 50;   % AP2 in Room 2
    150, 150;  % AP3 in Room 3
    50, 150;   % AP4 in Room 4
];

% Define final loading station in Room 3
loading_station = [137.5, 155];

% Number of time steps
time_steps = 100;

% Initialize algorithms
algorithms = {'A*', 'Dijkstra', 'RRT', 'PRM'};

% Initialize arrays for storing path lengths, process times, and smoothness
path_lengths = NaN(length(algorithms), size(robot_positions, 1));  % NaN for uncomputed paths
process_times = NaN(length(algorithms), size(robot_positions, 1));
smoothness_values = NaN(length(algorithms), size(robot_positions, 1));

% Use the same goal positions for each algorithm
goal_positions = [];
for i = 1:size(robot_positions, 1)
    goal_positions(i, :) = random_unloading_station(obstacles);  % Random unloading station
end

% Loop over each algorithm and compute paths
for alg_idx = 1:length(algorithms)
    path_planning_algorithm = algorithms{alg_idx};
    fprintf('Running algorithm: %s\n', path_planning_algorithm);
    
    for i = 1:size(robot_positions, 1)
        start_pos = robot_positions(i, :);
        goal_pos = goal_positions(i, :);

        % Display start and goal positions
        fprintf('Robot %d: Start [%d, %d] -> Goal [%d, %d]\n', i, start_pos(1), start_pos(2), goal_pos(1), goal_pos(2));

        % Measure computation time and compute path
        tic;
        switch path_planning_algorithm
            case 'A*'
                [path, ~] = astar_path(start_pos, goal_pos, grid_size, obstacles);
            case 'Dijkstra'
                [path, ~] = dijkstra_path(start_pos, goal_pos, grid_size, obstacles);
            case 'RRT'
                [path, ~] = rrt_path(start_pos, goal_pos, grid_size, obstacles);
            case 'PRM'
                [path, ~] = prm_path(start_pos, goal_pos, grid_size, obstacles);
        end
        process_time = toc;

        % Check if path is empty before calculating length or smoothness
        if isempty(path)
            fprintf('No valid path found for Robot %d using %s.\n', i, path_planning_algorithm);
        else
            % Calculate path length and store metrics
            path_length = calculate_path_length(path);
            path_lengths(alg_idx, i) = path_length;
            process_times(alg_idx, i) = process_time;

            % Calculate and store smoothness (direction changes)
            smoothness = calculate_smoothness(path);
            smoothness_values(alg_idx, i) = smoothness;
        end
    end
end

% Plot Path Length vs Number of Robots (Bar Graph)
figure;
bar(path_lengths');
title('Optimal Path Length vs Number of Robots');
xlabel('Robot');
ylabel('Path Length');
legend(algorithms, 'Location', 'best');
grid on;

% Plot Process Time vs Number of Robots (Bar Graph)
figure;
bar(process_times');
title('Process Time vs Number of Robots');
xlabel('Robot');
ylabel('Process Time (seconds)');
legend(algorithms, 'Location', 'best');
grid on;

% Plot Path Smoothness (Bar Graph)
figure;
bar(smoothness_values');
title('Path Smoothness (Direction Changes) for Each Algorithm');
xlabel('Robot');
ylabel('Number of Direction Changes');
legend(algorithms, 'Location', 'best');
grid on;

%% Path Optimality Deviation (Variance)

% Initialize path lengths storage across runs
num_runs = 10;  % Number of runs to check variability
path_length_runs = NaN(num_runs, size(robot_positions, 1), length(algorithms));

% Run each algorithm multiple times to calculate variance
for run = 1:num_runs
    for alg_idx = 1:length(algorithms)
        path_planning_algorithm = algorithms{alg_idx};
        for i = 1:size(robot_positions, 1)
            start_pos = robot_positions(i, :);
            goal_pos = goal_positions(i, :);  % Use the same goal positions
            switch path_planning_algorithm
                case 'A*'
                    [path, ~] = astar_path(start_pos, goal_pos, grid_size, obstacles);
                case 'Dijkstra'
                    [path, ~] = dijkstra_path(start_pos, goal_pos, grid_size, obstacles);
                case 'RRT'
                    [path, ~] = rrt_path(start_pos, goal_pos, grid_size, obstacles);
                case 'PRM'
                    [path, ~] = prm_path(start_pos, goal_pos, grid_size, obstacles);
            end
            % Store path lengths for variability analysis
            if ~isempty(path)
                path_length_runs(run, i, alg_idx) = calculate_path_length(path);
            end
        end
    end
end

% Calculate variance in path lengths across runs
path_length_variance = var(path_length_runs, 0, 1, 'omitnan');

% Plot Path Optimality Deviation (Variance) (Bar Graph)
figure;
bar(squeeze(path_length_variance));
title('Path Optimality Deviation (Variance)');
xlabel('Robot');
ylabel('Path Length Variance');
legend(algorithms, 'Location', 'best');
grid on;

%% Process Time vs Complexity (Bar Graph)

% Define regions with different obstacle complexities in your map
obstacle_counts = [10, 20, 30, 40, 50];  % Vary obstacle count for complexity
process_times_complexity = NaN(length(obstacle_counts), length(algorithms));

for obs_idx = 1:length(obstacle_counts)
    num_obstacles = obstacle_counts(obs_idx);
    region_obstacles = obstacle_map_with_density(grid_size, num_obstacles);  % Use custom obstacle map with varying densities
    for alg_idx = 1:length(algorithms)
                path_planning_algorithm = algorithms{alg_idx};
        tic;
        for i = 1:size(robot_positions, 1)
            start_pos = robot_positions(i, :);
            goal_pos = goal_positions(i, :);
            switch path_planning_algorithm
                case 'A*'
                    [path, ~] = astar_path(start_pos, goal_pos, grid_size, region_obstacles);
                case 'Dijkstra'
                    [path, ~] = dijkstra_path(start_pos, goal_pos, grid_size, region_obstacles);
                case 'RRT'
                    [path, ~] = rrt_path(start_pos, goal_pos, grid_size, region_obstacles);
                case 'PRM'
                    [path, ~] = prm_path(start_pos, goal_pos, grid_size, region_obstacles);
            end
        end
        process_times_complexity(obs_idx, alg_idx) = toc;  % Store process time for each region/complexity
    end
end

% Plot Process Time vs Complexity (Bar Graph)
figure;
bar(process_times_complexity);
title('Process Time vs Complexity (Number of Obstacles)');
xlabel('Number of Obstacles');
ylabel('Process Time (seconds)');
legend(algorithms, 'Location', 'best');
grid on;

%% Helper Functions

% Calculate path length (Euclidean distance)
function length = calculate_path_length(path)
    length = sum(sqrt(sum(diff(path).^2, 2)));
end

% Function to calculate number of direction changes (smoothness)
function smoothness = calculate_smoothness(path)
    smoothness = 0;
    for i = 2:size(path, 1) - 1
        vec1 = path(i, :) - path(i-1, :);   % Direction from (i-1) to (i)
        vec2 = path(i+1, :) - path(i, :);   % Direction from (i) to (i+1)
        if ~isequal(vec1, vec2)  % Check if direction changes
            smoothness = smoothness + 1;
        end
    end
end

% Custom obstacle map function with varying obstacle densities for complexity testing
function obstacles = obstacle_map_with_density(grid_size, num_obstacles)
    % Initialize obstacle grid with zeros (free space)
    obstacles = zeros(grid_size);

    % Randomly place obstacles
    for i = 1:num_obstacles
        x = randi([1, grid_size(2)]);
        y = randi([1, grid_size(1)]);
        obstacles(y, x) = 1;  % Mark obstacle position
    end
end

