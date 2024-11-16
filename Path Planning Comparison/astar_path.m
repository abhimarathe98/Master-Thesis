function path = astar_path(start_pos, goal_pos, grid_size, obstacles)
    % A* Pathfinding with obstacle avoidance and 8-direction movement (including diagonals)
    % Input:
    % - start_pos: Starting position [x, y]
    % - goal_pos: Goal position [x, y]
    % - grid_size: Size of the grid (e.g., [200, 200])
    % - obstacles: Binary matrix representing obstacles (1 = obstacle, 0 = free space)

    % Priority queue for open list management
    open_list = start_pos;
    closed_list = false(grid_size);
    
    g_costs = inf(grid_size);
    f_costs = inf(grid_size);
    parents = cell(grid_size(1), grid_size(2));

    % Initialize costs for start position
    g_costs(start_pos(2), start_pos(1)) = 0;
    f_costs(start_pos(2), start_pos(1)) = heuristic(start_pos, goal_pos);

    % Allow diagonal movement
    directions = [0 1; 1 0; 0 -1; -1 0; -1 -1; -1 1; 1 -1; 1 1];
    
    % Increase heuristic weight for scalability improvement
    heuristic_weight = 1.5;  % Adjust weight as needed for efficiency
    
    while ~isempty(open_list)
        % Use a priority queue or improved selection method for min f_cost
        [~, idx] = min(f_costs(sub2ind(grid_size, open_list(:,2), open_list(:,1))));
        current_node = open_list(idx, :);
        open_list(idx, :) = [];
        
        if isequal(current_node, goal_pos)
            % Reconstruct path upon reaching the goal
            path = reconstruct_path(parents, current_node, start_pos);
            return;
        end
        
        closed_list(current_node(2), current_node(1)) = true;

        for i = 1:size(directions, 1)
            neighbor = current_node + directions(i, :);
            if any(neighbor < 1) || neighbor(1) > grid_size(1) || neighbor(2) > grid_size(2)
                continue;
            end
            
            if obstacles(neighbor(2), neighbor(1)) == 1 || closed_list(neighbor(2), neighbor(1))
                continue;
            end

            movement_cost = norm(directions(i, :));
            tentative_g_cost = g_costs(current_node(2), current_node(1)) + movement_cost;

            if tentative_g_cost < g_costs(neighbor(2), neighbor(1))
                g_costs(neighbor(2), neighbor(1)) = tentative_g_cost;
                % Apply heuristic weight to encourage goal-oriented moves
                f_costs(neighbor(2), neighbor(1)) = tentative_g_cost + heuristic_weight * heuristic(neighbor, goal_pos);
                parents{neighbor(2), neighbor(1)} = current_node;

                if ~ismember(neighbor, open_list, 'rows')
                    open_list = [open_list; neighbor];
                end
            end
        end
    end

    path = [];
end

% Euclidean distance heuristic function
function h = heuristic(node, goal)
    h = sqrt((node(1) - goal(1))^2 + (node(2) - goal(2))^2);
end

% Reconstruct the path from the goal to the start using the parents matrix
function path = reconstruct_path(parents, current_node, start_node)
    path = current_node;
    while ~isequal(current_node, start_node)
        current_node = parents{current_node(2), current_node(1)};
        path = [current_node; path];
    end
end
