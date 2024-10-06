function neighbors = find_nearest_neighbors(point, samples, max_neighbors)
    % find_nearest_neighbors - Finds the nearest neighbors to a given point
    % Input:
    %   - point: The query point [x, y]
    %   - samples: The array of sample points [x1, y1; x2, y2; ...]
    %   - max_neighbors: The maximum number of nearest neighbors to return
    % Output:
    %   - neighbors: Indices of the nearest neighbors in the 'samples' array

    % Calculate the Euclidean distance between the query point and each sample
    distances = sqrt(sum((samples - point).^2, 2));

    % Sort the distances and return the indices of the nearest neighbors
    [~, sorted_indices] = sort(distances);

    % Return the nearest 'max_neighbors' indices
    neighbors = sorted_indices(1:min(max_neighbors, length(sorted_indices)));
end
