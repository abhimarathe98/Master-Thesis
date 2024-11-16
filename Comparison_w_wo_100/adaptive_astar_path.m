function path = adaptive_astar_path(start_pos, goal_pos, grid_size, obstacles, ap_positions, robot_id)
    % Initialize open and closed lists
    open_list = start_pos;
    closed_list = false(grid_size);
    
    % Initialize costs and parents
    g_costs = inf(grid_size);
    f_costs = inf(grid_size);
    parents = cell(grid_size(1), grid_size(2));

    g_costs(start_pos(2), start_pos(1)) = 0;
    f_costs(start_pos(2), start_pos(1)) = heuristic(start_pos, goal_pos);

    % Movement directions (8 directions for flexibility)
    directions = [0 1; 1 0; 0 -1; -1 0; 1 1; -1 1; 1 -1; -1 -1];

    % Optimization variables
    base_signal_weight = 0.5;  % Further reduced base signal weight for balanced influence
    distance_weight = 2;  % Weight for distance cost
    dynamic_adjustment = 0.1;  % Fine-tuned factor for smooth signal adjustment
    goal_threshold_factor = 1.01;  % Threshold factor to prioritize goal over signal

    % Calculate the RSSI map based on APs for current grid
    rssi_map = compute_rssi_map(grid_size, ap_positions);

    % Adaptive A* Pathfinding with Optimized Signal Usage
    while ~isempty(open_list)
        % Get the node with the lowest f-cost
        [~, idx] = min(f_costs(sub2ind(grid_size, open_list(:, 2), open_list(:, 1))));
        current_node = open_list(idx, :);
        open_list(idx, :) = [];

        % Check if goal is reached
        if isequal(current_node, goal_pos)
            path = reconstruct_dynamic_path(parents, current_node, start_pos);
            path = path_smoothing(path, rssi_map);  % Apply path smoothing based on RSSI
            return;
        end

        closed_list(current_node(2), current_node(1)) = true;

        for i = 1:size(directions, 1)
            neighbor = current_node + directions(i, :);

            % Skip out-of-bounds neighbors
            if any(neighbor < 1) || neighbor(1) > grid_size(1) || neighbor(2) > grid_size(2)
                continue;
            end

            % Skip obstacles or already closed neighbors
            if obstacles(neighbor(2), neighbor(1)) == 1 || closed_list(neighbor(2), neighbor(1))
                continue;
            end

            % Calculate tentative g-cost with reduced signal influence
            base_g_cost = g_costs(current_node(2), current_node(1)) + 1;
            signal_strength = rssi_map(neighbor(2), neighbor(1));
            goal_distance = heuristic(neighbor, goal_pos);
            current_goal_distance = heuristic(current_node, goal_pos);

            % Prioritize goal if moving closer
            if goal_distance <= current_goal_distance * goal_threshold_factor
                signal_weight = base_signal_weight - dynamic_adjustment;
            else
                signal_weight = base_signal_weight;
            end
            
            % Calculate the signal cost with reduced influence
            signal_cost = -log(signal_strength + 1e-5) * signal_weight;
            
            % Adjust effective cost to prioritize goal distance over signal influence
            effective_distance_cost = goal_distance + 0.5 * signal_cost;
            
            tentative_g_cost = base_g_cost + distance_weight * effective_distance_cost;
            f_cost = tentative_g_cost + heuristic(neighbor, goal_pos);

            if tentative_g_cost < g_costs(neighbor(2), neighbor(1))
                g_costs(neighbor(2), neighbor(1)) = tentative_g_cost;
                f_costs(neighbor(2), neighbor(1)) = f_cost;
                parents{neighbor(2), neighbor(1)} = current_node;

                if ~ismember(neighbor, open_list, 'rows')
                    open_list = [open_list; neighbor];
                end
            end
        end
    end

    % If no path is found, return an empty array
    path = [];
end

% Path smoothing based on RSSI
function smoothed_path = path_smoothing(path, rssi_map)
    % Smoothing adjustments based on signal strength in the path
    smoothed_path = path;
    for i = 2:(size(path, 1) - 1)
        prev_rssi = rssi_map(path(i-1, 2), path(i-1, 1));
        current_rssi = rssi_map(path(i, 2), path(i, 1));
        next_rssi = rssi_map(path(i+1, 2), path(i+1, 1));

        % Adjust if signal improves or worsens
        if current_rssi < prev_rssi && current_rssi < next_rssi
            % Boost the path if it leads to better RSSI
            smoothed_path(i, :) = mean([path(i-1, :); path(i+1, :)], 1);
        end
    end
end

% Function to calculate signal strength map (RSSI) based on APs
function rssi_map = compute_rssi_map(grid_size, ap_positions)
    rssi_map = zeros(grid_size);

    % Parameters for RSSI calculation
    signal_power = 100;  % Base signal power
    attenuation_factor = 2;  % Balanced attenuation factor

    for x = 1:grid_size(1)
        for y = 1:grid_size(2)
            % Compute signal strength from each AP and take the max value
            max_signal = 0;
            for ap = 1:size(ap_positions, 1)
                distance = norm([x, y] - ap_positions(ap, :));
                signal = signal_power / (distance^attenuation_factor + 1e-5);
                max_signal = max(max_signal, signal);
            end
            rssi_map(x, y) = max_signal;
        end
    end

    rssi_map = rssi_map / max(rssi_map(:));
end

% Euclidean distance heuristic function
function h = heuristic(node, goal)
    h = sqrt((node(1) - goal(1))^2 + (node(2) - goal(2))^2);
end

% Reconstruct the path dynamically from the goal to the start using the parents matrix
function path = reconstruct_dynamic_path(parents, current_node, start_node)
    path = current_node;
    while ~isequal(current_node, start_node)
        current_node = parents{current_node(2), current_node(1)};
        path = [current_node; path];
    end
end
