function [path, num_explored] = prm_path(start_pos, goal_pos, grid_size, obstacles)
    start_pos = round(start_pos);
    goal_pos = round(goal_pos);

    num_samples = 100;  % Number of random samples
    max_neighbors = 5;  % Max connections for each node

    samples = [start_pos; goal_pos];
    while size(samples, 1) < num_samples
        sample = [randi(grid_size(1)), randi(grid_size(2))];
        if obstacles(sample(2), sample(1)) == 0
            samples = [samples; sample];
        end
    end

    edges = cell(num_samples, 1);
    for i = 1:num_samples
        for j = i+1:num_samples
            if norm(samples(i, :) - samples(j, :)) < max_neighbors && ...
               ~obstacle_between(samples(i, :), samples(j, :), obstacles)
                edges{i} = [edges{i}; j];
                edges{j} = [edges{j}; i];
            end
        end
    end

    path = astar_path_roadmap(start_pos, goal_pos, samples, edges);
    num_explored = numel(samples);  % Total number of nodes considered
end

function neighbors = find_nearest_neighbors(point, samples, max_neighbors)
    distances = sqrt(sum((samples - point).^2, 2));
    [~, sorted_indices] = sort(distances);
    neighbors = sorted_indices(1:min(max_neighbors, length(sorted_indices)));
end
