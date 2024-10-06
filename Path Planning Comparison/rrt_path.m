function [path, num_explored] = rrt_path(start_pos, goal_pos, grid_size, obstacles)
    % RRT Pathfinding for grid-based environments
    start_pos = round(start_pos);
    goal_pos = round(goal_pos);

    % Parameters
    max_nodes = 1000;  % Maximum number of RRT nodes
    step_size = 5;     % Distance between nodes

    % Initialize the tree with the start position
    tree = start_pos;  % The first node is the start position
    parents = NaN(max_nodes, 1);  % Store parent indices (not coordinates)
    parents(1) = 0;  % Root node has no parent

    num_explored = 1;  % Count of explored nodes
    node_count = 1;    % Start with 1 node (the start node)

    % Grow the RRT tree
    for i = 2:max_nodes
        % Sample a random point
        rand_point = [randi(grid_size(1)), randi(grid_size(2))];

        % Find the nearest node in the tree
        dists = sqrt(sum((tree - rand_point).^2, 2));
        [~, nearest_idx] = min(dists);  % Index of nearest node
        nearest_node = tree(nearest_idx, :);

        % Move towards the random point
        direction = (rand_point - nearest_node) / norm(rand_point - nearest_node);
        new_node = nearest_node + step_size * direction;
        new_node = round(new_node);

        % Ensure new_node stays within bounds
        new_node = max(min(new_node, grid_size), 1);

        % Check for collision with obstacles
        if obstacles(new_node(2), new_node(1)) == 0
            % Add the new node to the tree
            tree = [tree; new_node];
            node_count = node_count + 1;
            parents(node_count) = nearest_idx;  % Store the index of the parent node
            num_explored = num_explored + 1;

            % Check if the goal is reached
            if norm(new_node - goal_pos) < step_size
                % Call reconstruct_path using the correct index (node_count)
                path = reconstruct_rrt_path(parents, node_count, tree);
                return;
            end
        end
    end

    % If no path found
    path = [];
end
