function path = reconstruct_path(parents, current_node, start_node, grid_size)
    % Reconstruct the path from the goal to the start using the parents matrix
    path = current_node;  % Start with the goal node
    while ~isequal(current_node, start_node)
        % Find the index of the parent node
        parent_idx = sub2ind(grid_size, current_node(2), current_node(1));
        current_node = parents(parent_idx, :);
        path = [current_node; path];  % Prepend the current node to the path
    end
end
