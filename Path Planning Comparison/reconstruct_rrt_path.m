function path = reconstruct_rrt_path(parents, goal_idx, tree)
    % Reconstruct the path from the goal to the start using parent indices
    path = tree(goal_idx, :);  % Start with the goal node
    current_idx = goal_idx;
    
    while parents(current_idx) > 0
        current_idx = parents(current_idx);  % Move to the parent node
        path = [tree(current_idx, :); path];  % Prepend the current node to the path
    end
end
