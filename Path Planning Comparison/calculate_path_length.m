function length = calculate_path_length(path)
    if isempty(path)
        length = inf;
        return;
    end
    diffs = diff(path);
    segment_lengths = sqrt(sum(diffs.^2, 2));
    length = sum(segment_lengths);
end
