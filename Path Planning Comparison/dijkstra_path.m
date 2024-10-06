function [path, num_explored] = dijkstra_path(start_pos, goal_pos, grid_size, obstacles)
    % Dijkstra Pathfinding with obstacle avoidance
    start_pos = round(start_pos);
    goal_pos = round(goal_pos);

    if obstacles(start_pos(2), start_pos(1)) == 1 || obstacles(goal_pos(2), goal_pos(1)) == 1
        error('Start or goal position is an obstacle.');
    end

    % Initialize costs, lists, and parent tracking
    g_costs = inf(grid_size);
    g_costs(start_pos(2), start_pos(1)) = 0;
    open_list = start_pos;
    closed_list = false(grid_size);
    
    % Use a numeric array for parents instead of a cell array
    parents = NaN(prod(grid_size), 2);  % To store the parent node coordinates for reconstruction

    directions = [0 1; 1 0; 0 -1; -1 0];  % Movement directions (up, down, left, right)
    
    num_explored = 0;  % Initialize node exploration counter

    while ~isempty(open_list)
        % Get the node with the lowest g-cost
        [~, idx] = min(g_costs(sub2ind(grid_size, open_list(:,2), open_list(:,1))));
        current_node = open_list(idx, :);
        open_list(idx, :) = [];  % Remove the node from the open list

        % Check if the goal has been reached
        if isequal(current_node, goal_pos)
            path = reconstruct_path(parents, current_node, start_pos, grid_size);
            num_explored = sum(closed_list(:));
            return;
        end

        % Mark the current node as closed (explored)
        closed_list(current_node(2), current_node(1)) = true;

        % Explore each neighbor of the current node
        for i = 1:size(directions, 1)
            neighbor = current_node + directions(i, :);
            
            % Ensure the neighbor is within bounds
            if any(neighbor < 1) || neighbor(1) > grid_size(1) || neighbor(2) > grid_size(2)
                continue;
            end

            % Skip if the neighbor is an obstacle or already closed
            if obstacles(neighbor(2), neighbor(1)) == 1 || closed_list(neighbor(2), neighbor(1))
                continue;
            end

            % Calculate the tentative g-cost for the neighbor
            tentative_g_cost = g_costs(current_node(2), current_node(1)) + 1;

            % If this path to the neighbor is better, update costs and parent tracking
            if tentative_g_cost < g_costs(neighbor(2), neighbor(1))
                g_costs(neighbor(2), neighbor(1)) = tentative_g_cost;
                % Store the parent as the index of the current node
                parents(sub2ind(grid_size, neighbor(2), neighbor(1)), :) = current_node;

                % Add the neighbor to the open list if it's not already in it
                if ~ismember(neighbor, open_list, 'rows')
                    open_list = [open_list; neighbor];
                end
            end
        end
    end

    % If no path is found, return an empty path
    path = [];
    num_explored = sum(closed_list(:));
end
