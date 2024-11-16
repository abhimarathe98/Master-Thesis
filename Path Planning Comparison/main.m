% Main script to perform path planning and generate comparison results

% Define a constant speed for robots (e.g., 1 unit per second)
robot_speed = 1;

% Define grid size and load warehouse layout
grid_size = [200, 200];
warehouse_layout();  % Display warehouse layout

% Define robot start positions and unloading stations across rooms
start_positions = [
    repmat([5, 5; 5, 10; 5, 15; 5, 20; 5, 25], 100, 1); % Room 1
    repmat([105, 95; 105, 90; 105, 85; 195, 95; 195, 90], 100, 1); % Room 2
    repmat([195, 105; 195, 110; 195, 115; 195, 120; 195, 125], 100, 1); % Room 3
    repmat([75, 195; 80, 195; 85, 195; 90, 195; 95, 195], 100, 1) % Room 4
];
num_robots_cases = [10, 20, 50, 100, 200, 300, 500];
results = struct();

% Initialize scalability error rate storage
scalability_error_astar = [];
scalability_error_dijkstra = [];
scalability_error_rrt = [];
scalability_error_prm = [];

for case_idx = 1:length(num_robots_cases)
    num_robots = num_robots_cases(case_idx);
    disp(['Running simulations for ', num2str(num_robots), ' robots...']);
    
    % Initialize metrics
    travel_times_astar = zeros(num_robots, 1);
    comp_times_astar = zeros(num_robots, 1);
    memory_usage_astar = zeros(num_robots, 1);
    
    travel_times_dijkstra = zeros(num_robots, 1);
    comp_times_dijkstra = zeros(num_robots, 1);
    memory_usage_dijkstra = zeros(num_robots, 1);
    
    travel_times_rrt = zeros(num_robots, 1);
    comp_times_rrt = zeros(num_robots, 1);
    memory_usage_rrt = zeros(num_robots, 1);
    
    travel_times_prm = zeros(num_robots, 1);
    comp_times_prm = zeros(num_robots, 1);
    memory_usage_prm = zeros(num_robots, 1);

    % Run A* algorithm for all robots
    parfor i = 1:num_robots
        start_pos = start_positions(i, :);
        goal_pos = random_unloading_station(zeros(grid_size));
        
        tic;
        path = astar_path(start_pos, goal_pos, grid_size, zeros(grid_size));
        comp_times_astar(i) = toc;
        travel_times_astar(i) = length(path) / robot_speed;  % Calculate travel time
        memory_usage_astar(i) = numel(path);
    end

    % Run Dijkstra algorithm for all robots
    parfor i = 1:num_robots
        start_pos = start_positions(i, :);
        goal_pos = random_unloading_station(zeros(grid_size));
        
        tic;
        path = dijkstra_path(start_pos, goal_pos, grid_size, zeros(grid_size));
        comp_times_dijkstra(i) = toc;
        travel_times_dijkstra(i) = length(path) / robot_speed;  % Calculate travel time
        memory_usage_dijkstra(i) = numel(path);
    end

    % Run RRT algorithm for all robots
    parfor i = 1:num_robots
        start_pos = start_positions(i, :);
        goal_pos = random_unloading_station(zeros(grid_size));
        
        tic;
        path = rrt_path(start_pos, goal_pos, grid_size, zeros(grid_size));
        comp_times_rrt(i) = toc;
        travel_times_rrt(i) = length(path) / robot_speed;  % Calculate travel time
        memory_usage_rrt(i) = numel(path);
    end

    % Run PRM algorithm for all robots
    parfor i = 1:num_robots
        start_pos = start_positions(i, :);
        goal_pos = random_unloading_station(zeros(grid_size));
        
        tic;
        path = prm_path(start_pos, goal_pos, grid_size, zeros(grid_size));
        comp_times_prm(i) = toc;
        travel_times_prm(i) = length(path) / robot_speed;  % Calculate travel time
        memory_usage_prm(i) = numel(path);
    end

    % Store mean results for this case
    results(case_idx).num_robots = num_robots;
    results(case_idx).mean_travel_times = [
        mean(travel_times_astar), mean(travel_times_dijkstra), mean(travel_times_rrt), mean(travel_times_prm)
    ];
    results(case_idx).mean_comp_times = [
        mean(comp_times_astar), mean(comp_times_dijkstra), mean(comp_times_rrt), mean(comp_times_prm)
    ];
    results(case_idx).mean_memory_usage = [
        mean(memory_usage_astar), mean(memory_usage_dijkstra), mean(memory_usage_rrt), mean(memory_usage_prm)
    ];

    % Compute scalability error rate based on growth in computation time and nodes explored
    if case_idx > 1
        scalability_error_astar = [scalability_error_astar; ...
            (results(case_idx).mean_comp_times(1) - results(case_idx-1).mean_comp_times(1))];
        scalability_error_dijkstra = [scalability_error_dijkstra; ...
            (results(case_idx).mean_comp_times(2) - results(case_idx-1).mean_comp_times(2))];
        scalability_error_rrt = [scalability_error_rrt; ...
            (results(case_idx).mean_comp_times(3) - results(case_idx-1).mean_comp_times(3))];
        scalability_error_prm = [scalability_error_prm; ...
            (results(case_idx).mean_comp_times(4) - results(case_idx-1).mean_comp_times(4))];
    end
end

%% Display Summary Results in Command Window
fprintf('\nSummary Results for Path Planning Algorithms (Mean Values):\n');
for case_idx = 1:length(num_robots_cases)
    fprintf('\nNumber of Robots: %d\n', results(case_idx).num_robots);
    
    fprintf('\nA* Algorithm:\n');
    fprintf('Mean Travel Time (s): %.5f\n', results(case_idx).mean_travel_times(1));
    fprintf('Mean Computation Time (s): %.5f\n', results(case_idx).mean_comp_times(1));
    fprintf('Mean Nodes Explored: %.5f\n', results(case_idx).mean_memory_usage(1));
    
    fprintf('\nDijkstra Algorithm:\n');
    fprintf('Mean Travel Time (s): %.5f\n', results(case_idx).mean_travel_times(2));
    fprintf('Mean Computation Time (s): %.5f\n', results(case_idx).mean_comp_times(2));
    fprintf('Mean Nodes Explored: %.5f\n', results(case_idx).mean_memory_usage(2));
    
    fprintf('\nRRT Algorithm:\n');
    fprintf('Mean Travel Time (s): %.5f\n', results(case_idx).mean_travel_times(3));
    fprintf('Mean Computation Time (s): %.5f\n', results(case_idx).mean_comp_times(3));
    fprintf('Mean Nodes Explored: %.5f\n', results(case_idx).mean_memory_usage(3));
    
    fprintf('\nPRM Algorithm:\n');
    fprintf('Mean Travel Time (s): %.5f\n', results(case_idx).mean_travel_times(4));
    fprintf('Mean Computation Time (s): %.5f\n', results(case_idx).mean_comp_times(4));
    fprintf('Mean Nodes Explored: %.5f\n', results(case_idx).mean_memory_usage(4));
end

%% Plotting Updated Results

% Extract mean values from results struct array for plotting
mean_comp_times_astar = arrayfun(@(x) x.mean_comp_times(1), results);
mean_comp_times_dijkstra = arrayfun(@(x) x.mean_comp_times(2), results);
mean_comp_times_rrt = arrayfun(@(x) x.mean_comp_times(3), results);
mean_comp_times_prm = arrayfun(@(x) x.mean_comp_times(4), results);

mean_memory_usage_astar = arrayfun(@(x) x.mean_memory_usage(1), results);
mean_memory_usage_dijkstra = arrayfun(@(x) x.mean_memory_usage(2), results);
mean_memory_usage_rrt = arrayfun(@(x) x.mean_memory_usage(3), results);
mean_memory_usage_prm = arrayfun(@(x) x.mean_memory_usage(4), results);

% Extract mean travel times from results struct array for plotting
mean_travel_times_astar = arrayfun(@(x) x.mean_travel_times(1), results);
mean_travel_times_dijkstra = arrayfun(@(x) x.mean_travel_times(2), results);
mean_travel_times_rrt = arrayfun(@(x) x.mean_travel_times(3), results);
mean_travel_times_prm = arrayfun(@(x) x.mean_travel_times(4), results);

% Travel Time Comparison
figure;
plot(num_robots_cases, mean_travel_times_astar, '-o', 'DisplayName', 'A*');
hold on;
plot(num_robots_cases, mean_travel_times_dijkstra, '-o', 'DisplayName', 'Dijkstra');
plot(num_robots_cases, mean_travel_times_rrt, '-o', 'DisplayName', 'RRT');
plot(num_robots_cases, mean_travel_times_prm, '-o', 'DisplayName', 'PRM');
xlabel('Number of Robots');
ylabel('Average Travel Time (s)');
legend('show');
grid on;
saveas(gcf, 'Travel_Time.pdf');

% Computation Time Comparison
figure;
plot(num_robots_cases, mean_comp_times_astar, '-o', 'DisplayName', 'A*');
hold on;
plot(num_robots_cases, mean_comp_times_dijkstra, '-o', 'DisplayName', 'Dijkstra');
plot(num_robots_cases, mean_comp_times_rrt, '-o', 'DisplayName', 'RRT');
plot(num_robots_cases, mean_comp_times_prm, '-o', 'DisplayName', 'PRM');
xlabel('Number of Robots');
ylabel('Average Computation Time (s)');
legend('show');
grid on;
saveas(gcf, 'Computation_Time.pdf');

% Nodes Explored Comparison
figure;
plot(num_robots_cases, mean_memory_usage_astar, '-o', 'DisplayName', 'A*');
hold on;
plot(num_robots_cases, mean_memory_usage_dijkstra, '-o', 'DisplayName', 'Dijkstra');
plot(num_robots_cases, mean_memory_usage_rrt, '-o', 'DisplayName', 'RRT');
plot(num_robots_cases, mean_memory_usage_prm, '-o', 'DisplayName', 'PRM');
xlabel('Number of Robots');
ylabel('Average Nodes Explored');
legend('show');
grid on;
saveas(gcf, 'Nodes_Explored.pdf');

% Scalability Error Comparison
figure;
plot(num_robots_cases(2:end), scalability_error_astar, '-o', 'DisplayName', 'A*');
hold on;
plot(num_robots_cases(2:end), scalability_error_dijkstra, '-o', 'DisplayName', 'Dijkstra');
plot(num_robots_cases(2:end), scalability_error_rrt, '-o', 'DisplayName', 'RRT');
plot(num_robots_cases(2:end), scalability_error_prm, '-o', 'DisplayName', 'PRM');
xlabel('Number of Robots');
ylabel('Scalability Error (Increase in Computation Time)');
legend('show');
grid on;
saveas(gcf, 'Scalability.pdf');
