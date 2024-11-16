function goal_pos = random_unloading_station(obstacles)
    % random_unloading_station - Selects a valid unloading station position
    % Input: 
    %   - obstacles: The obstacle map
    % Output:
    %   - goal_pos: A valid unloading station position

    % Define possible unloading station positions
    unloading_stations = [
        10, 72.5;
        25, 72.5;
        40, 72.5;
        77.5, 80;
        77.5, 95;
        140, 32.5;
        155, 32.5;
        170, 32.5;
        185, 32.5;
        200, 32.5;
        140, 72.5;
        155, 72.5;
        170, 72.5;
        185, 72.5;
        200, 72.5;
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
        137.5, 117.5;
        137.5, 137.5;
        137.5, 192.5;
        172.5, 155;
        172.5, 170;
        172.5, 185;
        172.5, 200
    ];

    % Filter out unloading stations that are occupied by obstacles
    valid_stations = [];
    for i = 1:size(unloading_stations, 1)
        station = round(unloading_stations(i, :));  % Round to nearest integer
        if obstacles(station(2), station(1)) == 0  % Ensure station is not an obstacle
            valid_stations = [valid_stations; station];
        end
    end

    % Randomly select a valid unloading station
    if ~isempty(valid_stations)
        goal_pos = valid_stations(randi(size(valid_stations, 1)), :);
    else
        error('No valid unloading stations available.');
    end
end
