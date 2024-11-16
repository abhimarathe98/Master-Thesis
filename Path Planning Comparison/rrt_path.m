function path = rrt_path(start_pos, goal_pos, grid_size, obstacles)
    max_iter = 3000;        
    step_size = 1;          
    goal_bias = 0.02;       

    tree = [start_pos];  
    parents = NaN;  
    goal_reached = false;

    for iter = 1:max_iter
        if rand < goal_bias
            rand_point = goal_pos;
        else
            rand_point = [randi(grid_size(1)), randi(grid_size(2))];
        end

        [~, nearest_idx] = min(vecnorm(tree - rand_point, 2, 2));
        nearest_point = tree(nearest_idx, :);

        direction = (rand_point - nearest_point) / norm(rand_point - nearest_point);
        new_point = nearest_point + step_size * direction;
        new_point = round(new_point);
        new_point = max(min(new_point, grid_size), 1); 

        if obstacles(new_point(2), new_point(1)) == 1
            continue;
        end

        tree = [tree; new_point];
        parents = [parents; nearest_idx];

        if norm(new_point - goal_pos) < step_size
            goal_reached = true;
            path = reconstruct_rrt_path(tree, parents, size(tree, 1), start_pos);
            return;
        end
    end

    if ~goal_reached
        warning('RRT could not find a valid path within the maximum iterations.');
    end
    path = [];

    % Nested function for path reconstruction
    function path = reconstruct_rrt_path(tree, parents, goal_idx, start_pos)
        path = tree(goal_idx, :);  
        while ~isequal(tree(goal_idx, :), start_pos)
            goal_idx = parents(goal_idx);  
            path = [tree(goal_idx, :); path];
        end
    end
end
