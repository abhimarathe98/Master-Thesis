function [path, num_explored] = astar_path(start_pos, goal_pos, grid_size, obstacles)
    % A* Pathfinding with obstacle avoidance
    % (Updated to return number of explored nodes)
    
    start_pos = round(start_pos);
    goal_pos = round(goal_pos);

    g_costs = inf(grid_size);
    f_costs = inf(grid_size);
    open_list = start_pos;
    closed_list = false(grid_size);
    parents = cell(grid_size(1), grid_size(2));

    g_costs(start_pos(2), start_pos(1)) = 0;
    f_costs(start_pos(2), start_pos(1)) = heuristic(start_pos, goal_pos);

    directions = [0 1; 1 0; 0 -1; -1 0];

    while ~isempty(open_list)
        [~, idx] = min(f_costs(sub2ind(grid_size, open_list(:,2), open_list(:,1))));
        current_node = open_list(idx, :);
        open_list(idx, :) = [];

        if isequal(current_node, goal_pos)
            path = reconstruct_path(parents, current_node, start_pos);
            num_explored = sum(closed_list(:));
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

            tentative_g_cost = g_costs(current_node(2), current_node(1)) + 1;
            if tentative_g_cost < g_costs(neighbor(2), neighbor(1))
                g_costs(neighbor(2), neighbor(1)) = tentative_g_cost;
                f_costs(neighbor(2), neighbor(1)) = tentative_g_cost + heuristic(neighbor, goal_pos);
                parents{neighbor(2), neighbor(1)} = current_node;

                if ~ismember(neighbor, open_list, 'rows')
                    open_list = [open_list; neighbor];
                end
            end
        end
    end

    path = [];
    num_explored = sum(closed_list(:));
end

function h = heuristic(node, goal)
    h = abs(node(1) - goal(1)) + abs(node(2) - goal(2));
end

function path = reconstruct_path(parents, current_node, start_node)
    path = current_node;
    while ~isequal(current_node, start_node)
        current_node = parents{current_node(2), current_node(1)};
        path = [current_node; path];
    end
end
