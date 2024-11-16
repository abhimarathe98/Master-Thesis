function path = astar_path(start_pos, goal_pos, grid_size, obstacles)
    % A* Pathfinding with obstacle avoidance
    % Input:
    % - start_pos: Starting position [x, y]
    % - goal_pos: Goal position [x, y]
    % - grid_size: Size of the grid (e.g., [200, 200])
    % - obstacles: Binary matrix representing obstacles (1 = obstacle, 0 = free space)

    % Initialize the open and closed lists
    open_list = start_pos;  % Start with the starting position
    closed_list = false(grid_size);  % No nodes evaluated yet

    % Create a matrix to store node costs and parent info
    g_costs = inf(grid_size);  % Initialize g_costs to infinity
    f_costs = inf(grid_size);  % Initialize f_costs to infinity
    parents = cell(grid_size(1), grid_size(2));  % To store parent nodes for reconstructing the path

    % Set the g_cost and f_cost for the start node
    g_costs(start_pos(2), start_pos(1)) = 0;  % Swap x and y here
    f_costs(start_pos(2), start_pos(1)) = heuristic(start_pos, goal_pos);

    % Movement directions (up, down, left, right)
    directions = [0 1; 1 0; 0 -1; -1 0; 1 1; -1 1; 1 -1; -1 -1];

    while ~isempty(open_list)
        % Get the node with the lowest f-cost
        [~, idx] = min(f_costs(sub2ind(grid_size, open_list(:,2), open_list(:,1))));
        current_node = open_list(idx, :);
        open_list(idx, :) = [];  % Remove the node from the open list

        % Check if we reached the goal
        if isequal(current_node, goal_pos)
            path = reconstruct_path(parents, current_node, start_pos);
            return;
        end

        % Mark the current node as closed
        closed_list(current_node(2), current_node(1)) = true;  % Swap x and y here

        % Process each neighbor
        for i = 1:size(directions, 1)
            neighbor = current_node + directions(i, :);

            % Skip neighbors out of bounds
            if any(neighbor < 1) || neighbor(1) > grid_size(1) || neighbor(2) > grid_size(2)
                continue;
            end

            % Skip neighbors that are obstacles or already closed
            if obstacles(neighbor(2), neighbor(1)) == 1 || closed_list(neighbor(2), neighbor(1))
                continue;
            end

            % Calculate tentative g-cost for the neighbor
            tentative_g_cost = g_costs(current_node(2), current_node(1)) + 1;

            % If this path to the neighbor is better, update the costs and parent
            if tentative_g_cost < g_costs(neighbor(2), neighbor(1))
                g_costs(neighbor(2), neighbor(1)) = tentative_g_cost;
                f_costs(neighbor(2), neighbor(1)) = tentative_g_cost + heuristic(neighbor, goal_pos);
                parents{neighbor(2), neighbor(1)} = current_node;

                % Add the neighbor to the open list if it's not already in it
                if ~ismember(neighbor, open_list, 'rows')
                    open_list = [open_list; neighbor];
                end
            end
        end
    end

    % If no path is found, return an empty array
    path = [];
end

% Euclidean distance heuristic (up, down, left, right movement only)
function h = heuristic(node, goal)
    h = sqrt((node(1) - goal(1))^2 + (node(2) - goal(2))^2);
end

% Reconstruct the path from the goal to the start using the parents matrix
function path = reconstruct_path(parents, current_node, start_node)
    path = current_node;
    while ~isequal(current_node, start_node)
        current_node = parents{current_node(2), current_node(1)};  % Swap x and y
        path = [current_node; path];  % Prepend to the path
    end
end
