function path = dijkstra_path(start_pos, goal_pos, grid_size, obstacles)
    open_list = start_pos;
    closed_list = false(grid_size);
    
    g_costs = inf(grid_size);
    parents = cell(grid_size(1), grid_size(2));
    
    g_costs(start_pos(2), start_pos(1)) = 0;
    
    directions = [0 1; 1 0; 0 -1; -1 0; -1 -1; -1 1; 1 -1; 1 1];

    while ~isempty(open_list)
        [~, idx] = min(g_costs(sub2ind(grid_size, open_list(:,2), open_list(:,1))));
        current_node = open_list(idx, :);
        open_list(idx, :) = [];

        if isequal(current_node, goal_pos)
            % Call reconstruct_path here
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

            tentative_g_cost = g_costs(current_node(2), current_node(1)) + 1;
            if tentative_g_cost < g_costs(neighbor(2), neighbor(1))
                g_costs(neighbor(2), neighbor(1)) = tentative_g_cost;
                parents{neighbor(2), neighbor(1)} = current_node;

                if ~ismember(neighbor, open_list, 'rows')
                    open_list = [open_list; neighbor];
                end
            end
        end
    end

    path = [];
end

% Reconstruct the path from the goal to the start using the parents matrix
function path = reconstruct_path(parents, current_node, start_node)
    path = current_node;
    while ~isequal(current_node, start_node)
        current_node = parents{current_node(2), current_node(1)};
        path = [current_node; path];
    end
end