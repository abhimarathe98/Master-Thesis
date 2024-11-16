function path = prm_path(start_pos, goal_pos, grid_size, obstacles)
    num_nodes = 5000;  % Significantly increased number of nodes
    max_neighbors = 10;  % Keep high connectivity
    step_size = 5;  % Increased step size penalty for longer paths
    connection_radius = 20;  % Limit the connection radius to avoid shortcuts

    % Sample nodes randomly in the free space
    nodes = [];
    while size(nodes, 1) < num_nodes
        rand_node = [randi(grid_size(1)), randi(grid_size(2))];
        if obstacles(rand_node(2), rand_node(1)) == 0
            nodes = [nodes; rand_node];
        end
    end

    % Add start and goal positions to the node list
    nodes = [start_pos; nodes; goal_pos];

    % Construct a graph by connecting nodes within a limited radius
    edges = cell(size(nodes, 1), 1);
    for i = 1:size(nodes, 1)
        distances = vecnorm(nodes - nodes(i, :), 2, 2);
        [~, neighbors] = sort(distances);
        for j = 2:min(max_neighbors + 1, length(neighbors))  % Skip the node itself
            if distances(neighbors(j)) <= connection_radius && is_collision_free(nodes(i, :), nodes(neighbors(j), :), obstacles)
                edges{i} = [edges{i}; neighbors(j)];
            end
        end
    end

    % Find the shortest path using modified Dijkstra's algorithm on the roadmap
    path = dijkstra_on_roadmap(nodes, edges, start_pos, goal_pos, step_size);
end

% Check if the straight line between p1 and p2 is collision-free
function collision_free = is_collision_free(p1, p2, obstacles)
    points = bresenham(p1(1), p1(2), p2(1), p2(2));  % Get all points on the line
    collision_free = all(arrayfun(@(x, y) obstacles(y, x) == 0, points(:, 1), points(:, 2)));
end

% Bresenham's Line Algorithm to compute grid points between two points
function points = bresenham(x1, y1, x2, y2)
    dx = abs(x2 - x1);
    dy = abs(y2 - y1);
    sx = sign(x2 - x1);
    sy = sign(y2 - y1);

    points = [];
    
    if dx > dy
        err = dx / 2;
        while x1 ~= x2
            points = [points; x1, y1];
            err = err - dy;
            if err < 0
                y1 = y1 + sy;
                err = err + dx;
            end
            x1 = x1 + sx;
        end
    else
        err = dy / 2;
        while y1 ~= y2
            points = [points; x1, y1];
            err = err - dx;
            if err < 0
                x1 = x1 + sx;
                err = err + dy;
            end
            y1 = y1 + sy;
        end
    end
    points = [points; x2, y2];
end

% Perform modified Dijkstra's algorithm on the roadmap graph with step size penalty
function path = dijkstra_on_roadmap(nodes, edges, start_pos, goal_pos, step_size)
    num_nodes = size(nodes, 1);
    start_idx = find(ismember(nodes, start_pos, 'rows'));
    goal_idx = find(ismember(nodes, goal_pos, 'rows'));

    % Initialize cost and parent structures
    g_costs = inf(num_nodes, 1);
    g_costs(start_idx) = 0;
    parents = NaN(num_nodes, 1);
    open_list = [start_idx];
    closed_list = false(num_nodes, 1);

    while ~isempty(open_list)
        % Find the node with the lowest cost in the open list
        [~, idx] = min(g_costs(open_list));
        current_idx = open_list(idx);
        open_list(idx) = [];

        % If we reached the goal, reconstruct the path
        if current_idx == goal_idx
            path = reconstruct_prm_path(nodes, parents, goal_idx, start_pos);
            return;
        end

        % Mark the node as closed
        closed_list(current_idx) = true;

        % Evaluate neighbors
        neighbors = edges{current_idx};
        for i = 1:length(neighbors)
            neighbor_idx = neighbors(i);

            if closed_list(neighbor_idx)
                continue;
            end

            % Tentative cost with step size penalty and connection radius limit
            distance = norm(nodes(current_idx, :) - nodes(neighbor_idx, :));
            tentative_g_cost = g_costs(current_idx) + distance * step_size;

            % Update costs and parent if a better path is found
            if tentative_g_cost < g_costs(neighbor_idx)
                g_costs(neighbor_idx) = tentative_g_cost;
                parents(neighbor_idx) = current_idx;

                if ~ismember(neighbor_idx, open_list)
                    open_list = [open_list; neighbor_idx];
                end
            end
        end
    end

    % If no path is found, return empty
    path = [];
end

% Reconstruct the path for PRM by tracing back the parents
function path = reconstruct_prm_path(nodes, parents, goal_idx, start_pos)
    path = nodes(goal_idx, :);
    while ~isequal(nodes(goal_idx, :), start_pos)
        goal_idx = parents(goal_idx);
        path = [nodes(goal_idx, :); path];
    end
end
