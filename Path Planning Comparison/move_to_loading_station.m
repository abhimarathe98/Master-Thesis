function paths = move_to_loading_station(paths, goal_positions, loading_station, grid_size, obstacles)
    % Move robots from unloading stations to loading station in Room 3
    % Input:
    %   - paths: Cell array of existing paths to unloading stations
    %   - goal_positions: The positions of the robots at unloading stations
    %   - loading_station: Position of the loading station in Room 3
    %   - grid_size: Size of the grid (e.g., [200, 200])
    %   - obstacles: Obstacle map of the warehouse
    % Output:
    %   - paths: Updated cell array with extended paths to the loading station

    % Iterate through all robots and extend their paths
    for i = 1:length(goal_positions)
        % Calculate path from current goal position to the loading station
        path_to_loading = astar_path(goal_positions(i, :), loading_station, grid_size, obstacles);
        
        % Append the new path to the existing one
        paths{i} = [paths{i}; path_to_loading];
    end
end
