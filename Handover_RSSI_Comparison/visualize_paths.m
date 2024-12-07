function visualize_paths(obstacles, start_pos, goal_pos, path)
    % visualize_paths - Visualizes obstacles, start/goal positions, and path
    
    figure('units','normalized','outerposition',[0 0 1 1]); % Full screen figure
    hold on;

    % Plot the obstacle map
    imagesc(obstacles);
    colormap(gray);
    axis equal;
    title('Pathfinding with Obstacles');
    
    % Plot the start and goal with smaller marker sizes
    plot(start_pos(1), start_pos(2), 'go', 'MarkerSize', 2, 'MarkerFaceColor', 'g');  % Start
    plot(goal_pos(1), goal_pos(2), 'ro', 'MarkerSize', 2, 'MarkerFaceColor', 'r');    % Goal
    
    % Plot the path
    if ~isempty(path)
        plot(path(:,1), path(:,2), 'b-', 'LineWidth', 1.5);
    else
        fprintf('No valid path found.\n');
    end

    hold off;
end
