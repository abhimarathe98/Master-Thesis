% Main script to perform A* path planning and animate robot trajectories

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

% Plan paths for each robot using A* with obstacle avoidance
goal_positions = [];  % Store goal positions for all robots
paths = {};  % Initialize paths for all robots
for i = 1:size(robot_positions, 1)
    start_pos = robot_positions(i, :);
    
    % Select a valid random unloading station for each robot
    goal_pos = random_unloading_station(obstacles);
    goal_positions = [goal_positions; goal_pos];  % Store goal position for each robot
    
    % Round start and goal positions to integers
    start_pos = round(start_pos);
    goal_pos = round(goal_pos);
    
    % Check if the start and goal positions are valid (not on obstacles)
    if obstacles(start_pos(1), start_pos(2)) == 1
        fprintf('Start position [%d, %d] is on an obstacle.\n', start_pos(1), start_pos(2));
        continue;
    end
    if obstacles(goal_pos(1), goal_pos(2)) == 1
        fprintf('Goal position [%d, %d] is on an obstacle.\n', goal_pos(1), goal_pos(2));
        continue;
    end
    
    % Compute the path using A* for each robot
    path = astar_path(start_pos, goal_pos, grid_size, obstacles);  % Pass obstacles to A*
    
    % Store the path
    paths{i} = path;
    
    % Display the path if it was found
    if ~isempty(path)
        fprintf('Path for Robot %d:\n', i);
        disp(path);
    else
        fprintf('No path found for Robot %d from [%d, %d] to [%d, %d]\n', i, start_pos(1), start_pos(2), goal_pos(1), goal_pos(2));
    end
    
    % Visualize the path
    visualize_paths(obstacles, start_pos, goal_pos, path);
end

% Call the animation function (trajectory_animation.m) to animate the robots
trajectory_animation(robot_positions, goal_positions, paths);
