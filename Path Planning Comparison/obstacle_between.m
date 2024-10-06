function is_obstacle = obstacle_between(p1, p2, obstacles)
    num_samples = max(abs(p2 - p1)) * 2;
    x_values = linspace(p1(1), p2(1), num_samples);
    y_values = linspace(p1(2), p2(2), num_samples);

    is_obstacle = false;
    for i = 1:num_samples
        x = round(x_values(i));
        y = round(y_values(i));

        if x >= 1 && x <= size(obstacles, 2) && y >= 1 && y <= size(obstacles, 1)
            if obstacles(y, x) == 1
                is_obstacle = true;
                return;
            end
        end
    end
end
