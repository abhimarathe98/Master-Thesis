% Main script to generate distribution curves for different robot counts

robot_counts = [20, 100, 200, 500];  % Array of different robot counts to simulate

for count_index = 1:length(robot_counts)
    num_robots = robot_counts(count_index);
    disp(['Simulating for ', num2str(num_robots), ' robots...']);

    % Setup and Initialization
    robot = importrobot('robomaster.urdf');
    grid_size = [200, 200];
    obstacles = obstacle_map(grid_size);

    % Define the 5 main start positions (without offsets) for plotting
    room1_main_positions = [5, 5; 5, 10; 5, 15; 5, 20; 5, 25];
    room2_main_positions = [115, 95; 115, 90; 115, 85; 205, 95; 205, 90];
    room3_main_positions = [205, 115; 205, 120; 205, 125; 205, 130; 205, 135];
    room4_main_positions = [75, 205; 80, 205; 85, 205; 90, 205; 95, 205];

    % Calculate the number of robots per room
    robots_per_room = num_robots / 4;

    % Generate starting positions with random offsets for the number of robots per room
    room1_positions = repmat(room1_main_positions, ceil(robots_per_room / 5), 1);
    room1_positions = room1_positions(1:robots_per_room, :) + randn(robots_per_room, 2) * 2;

    room2_positions = repmat(room2_main_positions, ceil(robots_per_room / 5), 1);
    room2_positions = room2_positions(1:robots_per_room, :) + randn(robots_per_room, 2) * 2;

    room3_positions = repmat(room3_main_positions, ceil(robots_per_room / 5), 1);
    room3_positions = room3_positions(1:robots_per_room, :) + randn(robots_per_room, 2) * 2;

    room4_positions = repmat(room4_main_positions, ceil(robots_per_room / 5), 1);
    room4_positions = room4_positions(1:robots_per_room, :) + randn(robots_per_room, 2) * 2;

    % Combine all robot positions
    robot_positions = [room1_positions; room2_positions; room3_positions; room4_positions];

    % Round and clamp positions to grid size
    robot_positions = max(min(round(robot_positions), grid_size), 1);

    % Define AP positions in the rooms
    ap_positions = [50, 50; 160, 50; 160, 160; 50, 160];

    % Initialize goal positions using random_unloading_station
    goal_positions = zeros(size(robot_positions));
    for i = 1:size(robot_positions, 1)
        goal_positions(i, :) = random_unloading_station(obstacles);
    end

    % Store robot positions over time
    time_steps = 100;  % Number of time steps
    robot_positions_over_time = zeros(time_steps, num_robots, 2);

    for i = 1:num_robots
        start_pos = robot_positions(i, :);
        goal_pos_with_comm = goal_positions(i, :);

        % Compute the path using adaptive A* with optimized signal handling
        path_with_comm = adaptive_astar_path(start_pos, goal_pos_with_comm, grid_size, obstacles, ap_positions, i);

        % Store robot positions over time for Wi-Fi analysis
        for t = 1:min(time_steps, size(path_with_comm, 1))
            robot_positions_over_time(t, i, :) = path_with_comm(t, :);
        end
    end

    % Use the wifi_communication function to calculate RSSI and AP handover data
    rssi_log = wifi_communication(robot_positions_over_time, ap_positions, time_steps);

    % Variables to store RSSI values and AP handover events for all robots
    all_rssi_values = [];
    all_ap_handover_times = [];

    for i = 1:num_robots
        previous_ap = 0;
        for t = 1:time_steps
            % Collect RSSI values
            rssi_values = squeeze(rssi_log(i, :, t));
            all_rssi_values = [all_rssi_values, rssi_values];

            % Determine which AP the robot is interacting with
            [~, interacting_ap] = max(rssi_values);
            if t > 1 && interacting_ap ~= previous_ap
                all_ap_handover_times = [all_ap_handover_times, t];  % Record handover time
            end
            previous_ap = interacting_ap;
        end
    end

    %% Generate and Save Smooth Distribution Curves
    % RSSI Distribution Curve using Kernel Density Estimation (KDE)
    figure;
    [rssi_density, rssi_x] = ksdensity(all_rssi_values);
    plot(rssi_x, rssi_density, 'LineWidth', 2);
    xlabel('RSSI (dBm)');
    ylabel('Probability Density');
    title(['Smooth Distribution of RSSI Values for ', num2str(num_robots), ' Robots']);
    grid on;
    saveas(gcf, ['RSSI_Distribution_', num2str(num_robots), '_Robots.pdf']);  % Save as PDF

    % AP Handover Distribution Curve using Kernel Density Estimation (KDE)
    figure;
    [handover_density, handover_x] = ksdensity(all_ap_handover_times);
    plot(handover_x, handover_density, 'LineWidth', 2);
    xlabel('Time (seconds)');
    ylabel('Probability Density');
    title(['Smooth Distribution of AP Handover Times for ', num2str(num_robots), ' Robots']);
    grid on;
    saveas(gcf, ['AP_Handover_Distribution_', num2str(num_robots), '_Robots.pdf']);  % Save as PDF
end
