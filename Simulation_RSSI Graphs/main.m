% Main script to perform A* path planning and animate robot trajectories
% and Wi-Fi communication-based motion planning

robot = importrobot('robomaster.urdf');

% Define the grid size based on the warehouse layout (200x200)
grid_size = [210, 210];

% Generate obstacles from the warehouse layout
obstacles = obstacle_map(grid_size);  % Generate the obstacle map using obstacle_map function

% Define the starting positions of the robots in all four rooms
robot_positions = [
    % Room 1
    15, 5;
    15, 10;
    15, 15;
    15, 20;
    15, 25;
    % Room 2
    115, 95;
    115, 90;
    115, 85;
    205, 95;
    205, 90;
    % Room 3
    205, 115;
    205, 120;
    205, 125;
    205, 130;
    205, 135;
    % Room 4
    75, 205;
    80, 205;
    85, 205;
    90, 205;
    95, 205
];

% Define AP positions in the rooms
ap_positions = [
    50, 50;    % AP1 in Room 1
    160, 50;   % AP2 in Room 2
    160, 160;  % AP3 in Room 3
    50, 160;   % AP4 in Room 4
];

% Wi-Fi channel assignment
ap_channels = [1, 6, 11, 1];  % Channel allocation to avoid interference

% Number of time steps
time_steps = 100;

% Plan paths for each robot using A* with obstacle avoidance
goal_positions = [];  % Store goal positions for all robots
paths = {};  % Initialize paths for all robots
room_labels = ["Room 1", "Room 2", "Room 3", "Room 4"];  % Room labels for graph titles

% Determine the room for each robot based on starting positions
robot_rooms = [
    repmat("Room 1", 5, 1);
    repmat("Room 2", 5, 1);
    repmat("Room 3", 5, 1);
    repmat("Room 4", 5, 1)
];

for i = 1:size(robot_positions, 1)
    start_pos = robot_positions(i, :);
    
    % Select a valid random unloading station for each robot
    goal_pos = random_unloading_station(obstacles);
    goal_positions = [goal_positions; goal_pos];  % Store goal position for each robot
    
    % Compute the path using A* for each robot
    path = astar_path(start_pos, goal_pos, grid_size, obstacles);
    paths{i} = path;
    
    % Determine the room of the goal position
    goal_room = room_labels(determine_room(goal_pos, ap_positions));  % Function to determine room
    robot_rooms(i, 2) = goal_room;  % Store destination room
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
[rssi_log, ap_interactions] = wifi_communication(squeeze(robot_positions_over_time), ap_positions, time_steps);

% Define the time step duration in seconds
time_step_duration = 0.1;  % Each time step is 0.1 seconds

% Time array in seconds
time_in_seconds = time_step_duration * (1:time_steps);

% Create folders for saving graphs if they don't exist
if ~exist('RSSI graphs', 'dir')
    mkdir('RSSI graphs');
end
if ~exist('Channel Interaction', 'dir')
    mkdir('Channel Interaction');
end
if ~exist('AP Interaction', 'dir')
    mkdir('AP Interaction');
end

% Plot RSSI vs Time, Channel Interaction, and AP Interaction for each robot
for r = 1:size(robot_positions, 1)
    % Plot RSSI graph
    figure;
    hold on;
    for ap = 1:size(ap_positions, 1)
        plot(time_in_seconds, squeeze(rssi_log(r, ap, :)), 'DisplayName', sprintf('AP %d (Channel %d)', ap, ap_channels(ap)));
    end
    xlabel('Time (seconds)');
    ylabel('RSSI (dBm)');
    legend;
    hold off;
    
    % Save the RSSI graph as a PDF
    saveas(gcf, fullfile('RSSI graphs', sprintf('Robot_%d_RSSI.pdf', r)));

    % Plot Channel Interaction graph
    figure;
    hold on;
    plot(time_in_seconds, ap_channels(ap_interactions(r, :)), 'o-');
    xlabel('Time (seconds)');
    ylabel('Wi-Fi Channel');
    ylim([0, 12]);  % Channels range from 1 to 11, setting the Y-axis limits
    
    % Mark where the AP handovers happen
    ap_changes = find(diff(ap_interactions(r, :)) ~= 0);
    plot(time_in_seconds(ap_changes), ap_channels(ap_interactions(r, ap_changes)), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
    legend('Interacting Channel', 'Handover Points');
    hold off;
    
    % Save the Channel Interaction graph as a PDF
    saveas(gcf, fullfile('Channel Interaction', sprintf('Robot_%d_Channel_Interaction.pdf', r)));

    % Plot AP Interaction graph
    figure;
    hold on;
    plot(time_in_seconds, ap_interactions(r, :), 'o-');
    xlabel('Time (seconds)');
    ylabel('AP Number');
    ylim([0, max(ap_interactions(r, :)) + 1]);  % Setting the Y-axis limits based on AP numbers
    
    % Mark where the AP handovers happen
    plot(time_in_seconds(ap_changes), ap_interactions(r, ap_changes), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
    legend('Interacting AP', 'Handover Points');
    hold off;
    
    % Save the AP Interaction graph as a PDF
    saveas(gcf, fullfile('AP Interaction', sprintf('Robot_%d_AP_Interaction.pdf', r)));
end

% Helper function to determine the room based on goal position
function room = determine_room(position, ap_positions)
    distances = vecnorm(ap_positions - position, 2, 2);
    [~, room] = min(distances);
end
