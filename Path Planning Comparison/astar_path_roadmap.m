function path = astar_path_roadmap(start_pos, goal_pos, samples, edges)
    samples = [start_pos; samples; goal_pos];
    num_nodes = size(samples, 1);

    edges{1} = find_nearest_neighbors(start_pos, samples(2:end-1, :), 5);
    edges{num_nodes} = find_nearest_neighbors(goal_pos, samples(2:end-1, :), 5);

    open_list = [1];
    closed_list = false(num_nodes, 1);
    g_costs = inf(num_nodes, 1);
    f_costs = inf(num_nodes, 1);
    parents = NaN(num_nodes, 1);

    g_costs(1) = 0;
    f_costs(1) = heuristic(samples(1, :), samples(end, :));

    while ~isempty(open_list)
        [~, idx] = min(f_costs(open_list));
        current_node = open_list(idx);
        open_list(idx) = [];

        if current_node == num_nodes
            path = reconstruct_path_roadmap(parents, current_node, samples);
            return;
        end

        closed_list(current_node) = true;
        neighbors = edges{current_node};
        for i = 1:length(neighbors)
            neighbor = neighbors(i);

            if closed_list(neighbor)
                continue;
            end

            tentative_g_cost = g_costs(current_node) + norm(samples(current_node, :) - samples(neighbor, :));
            if tentative_g_cost < g_costs(neighbor)
                g_costs(neighbor) = tentative_g_cost;
                f_costs(neighbor) = tentative_g_cost + heuristic(samples(neighbor, :), samples(end, :));
                parents(neighbor) = current_node;

                if ~ismember(neighbor, open_list)
                    open_list = [open_list; neighbor];
                end
            end
        end
    end

    path = [];
end

function path = reconstruct_path_roadmap(parents, current_node, samples)
    path = samples(current_node, :);
    while ~isnan(parents(current_node))
        current_node = parents(current_node);
        path = [samples(current_node, :); path];
    end
end

function h = heuristic(node, goal)
    h = norm(node - goal);
end
