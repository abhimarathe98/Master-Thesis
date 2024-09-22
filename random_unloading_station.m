function goal_pos = random_unloading_station(obstacles)
    % random_unloading_station - Selects a random unloading station position
    % Input: 
    %   - obstacles: The obstacle grid
    % Output:
    %   - goal_pos: A valid unloading station position in free space

    % Create the occupancy map from the obstacle grid
    map = binaryOccupancyMap(obstacles, 1);  % Set grid resolution to 1

    % Define possible unloading station positions (example positions)
    unloading_stations = [
        10, 72.5;
        25, 72.5;
        40, 72.5;
        77.5, 80;
        77.5, 95;
        130, 32.5;
        145, 32.5;
        160, 32.5;
        175, 32.5;
        190, 32.5;
        130, 72.5;
        145, 72.5;
        160, 72.5;
        175, 72.5;
        190, 72.5;
        10, 167.5;
        25, 167.5;
        40, 167.5;
        55, 167.5;
        10, 142.5;
        25, 142.5;
        40, 142.5;
        10, 117.5;
        25, 117.5;
        40, 117.5;
    ];

    % Keep selecting an unloading station until a free space is found
    valid_goal = false;
    while ~valid_goal
        goal_pos = unloading_stations(randi(size(unloading_stations, 1)), :);
        goal_pos_int = round(goal_pos);  % Ensure integer position for occupancy checking
        
        % Check if the goal position is free in the binary occupancy map
        if ~checkOccupancy(map, [goal_pos_int(2), goal_pos_int(1)])  % MATLAB uses y, x indexing
            valid_goal = true;  % Valid goal found
        end
    end
end
