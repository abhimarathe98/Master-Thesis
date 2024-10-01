% Main script to perform A* path planning and animate robot trajectories
% and Wi-Fi communication-based motion planning

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

% Number of time steps
time_steps = 100;

% Plan paths for each robot using A* with obstacle avoidance
goal_positions = [];  % Store goal positions for all robots
paths = {};  % Initialize paths for all robots
for i = 1:size(robot_positions, 1)
    start_pos = robot_positions(i, :);
    
    % Select a valid random unloading station for each robot
    goal_pos = random_unloading_station(obstacles);
    goal_positions = [goal_positions; goal_pos];  % Store goal position for each robot
    
    % Compute the path using A* for each robot
    path = astar_path(start_pos, goal_pos, grid_size, obstacles);
    paths{i} = path;
    
    % Visualize the path
    visualize_paths(obstacles, start_pos, goal_pos, path);
end

% Animation and Wi-Fi communication
trajectory_animation(robot_positions, goal_positions, paths);

% Number of time steps based on the longest path
time_steps = max(cellfun(@(p) size(p, 1), paths));

% Extract robot positions at each time step
robot_positions_over_time = zeros(time_steps, size(robot_positions, 1), 2);
for t = 1:time_steps
    for r = 1:size(paths, 2)
        if t <= size(paths{r}, 1)
            robot_positions_over_time(t, r, :) = paths{r}(t, :);
        else
            % If the path is shorter than the total time steps, keep robot at final position
            robot_positions_over_time(t, r, :) = paths{r}(end, :);
        end
    end
end

% Call Wi-Fi communication function to track RSSI for all robots
rssi_log = wifi_communication(squeeze(robot_positions_over_time), ap_positions, time_steps);

% Define the time step duration in seconds
time_step_duration = 0.1;  % Each time step is 0.1 seconds

% Time array in seconds
time_in_seconds = time_step_duration * (1:time_steps);

% Plot RSSI vs Time (in seconds) for each robot separately
for r = 1:size(robot_positions, 1)
    figure;
    hold on;
    for ap = 1:size(ap_positions, 1)
        plot(time_in_seconds, squeeze(rssi_log(r, ap, :)), 'DisplayName', sprintf('AP %d', ap));
    end
    xlabel('Time (seconds)');
    ylabel('RSSI (dBm)');
    title(sprintf('RSSI vs Time for Robot %d', r));
    legend;
    hold off;
    
    % Determine which AP the robot is interacting with at each time step
    [~, interacting_ap] = max(squeeze(rssi_log(r, :, :)), [], 1);
    
    % Plot interaction with AP over time
    figure;
    plot(time_in_seconds, interacting_ap, 'o-');
    xlabel('Time (seconds)');
    ylabel('Interacting AP');
    title(sprintf('Robot %d - Interacting AP Over Time', r));
    ylim([1, size(ap_positions, 1)]);
    
    % Mark where the AP handovers happen
    hold on;
    ap_changes = find(diff(interacting_ap) ~= 0);
    plot(time_in_seconds(ap_changes), interacting_ap(ap_changes), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
    legend('Interacting AP', 'Handover Points');
    hold off;
end

