function path = astar_path(start_pos, goal_pos, obstacles, grid_size)
    % A* Pathfinding using MATLAB's plannerAStarGrid
    % Input:
    % - start_pos: Starting position [x, y]
    % - goal_pos: Goal position [x, y]
    % - obstacles: Binary matrix with obstacles
    % - grid_size: Size of the grid (e.g., [200, 200])

    % Create a binary occupancy grid from the obstacle matrix
    resolution = 1;  % Set grid resolution to match obstacle size (1 means 1 grid cell per position)
    map = binaryOccupancyMap(obstacles, resolution);

    % Round start and goal positions to integers (A* requires integer positions)
    start_pos = round(start_pos);
    goal_pos = round(goal_pos);

    % Ensure the start position is free in the occupancy grid by setting it explicitly
    setOccupancy(map, start_pos, 0);  % Mark start position as free
    fprintf('Start position [%d, %d] manually set to free in the occupancy map.\n', start_pos(1), start_pos(2));

    % Ensure the goal position is free in the occupancy grid by setting it explicitly
    setOccupancy(map, goal_pos, 0);  % Mark goal position as free
    fprintf('Goal position [%d, %d] manually set to free in the occupancy map.\n', goal_pos(1), goal_pos(2));

    % Debugging: Check start and goal positions
    fprintf('A* Path Planning: Start position: [%d, %d]\n', start_pos(1), start_pos(2));
    fprintf('A* Path Planning: Goal position: [%d, %d]\n', goal_pos(1), goal_pos(2));

    % Create A* planner object using plannerAStarGrid
    planner = plannerAStarGrid(map);

    % Plan the path using valid start and goal positions
    path = plan(planner, start_pos, goal_pos);

    % If no valid path is found, return empty
    if isempty(path)
        path = [];
    end
end
