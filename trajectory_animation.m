function trajectory_animation(start_poses, end_poses, paths)
    % This function animates the movement of robots from start to end positions along the computed paths
    
    % Number of robots
    num_robots = size(start_poses, 1);

    % Import the same robot from URDF file for all robots
    robot = importrobot('robomaster.urdf');
    robot.DataFormat = 'row';

    % Plot the warehouse layout (obstacles are already shown from warehouse_layout.m)
    hold on;
    title('Multi-Robot Trajectory Animation with Obstacles');
    xlabel('X [meters]');
    ylabel('Y [meters]');
    grid on;

    % Plot start and end positions for all robots
    for i = 1:num_robots
        plot(start_poses(i, 1), start_poses(i, 2), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
        plot(end_poses(i, 1), end_poses(i, 2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    end

    % Initialize robot markers for animation
    robot_markers = gobjects(num_robots, 1);
    for i = 1:num_robots
        % Plot the robot start positions with a blue marker
        robot_markers(i) = plot(start_poses(i, 1), start_poses(i, 2), 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
    end

    % Animate all robots along their paths
    max_steps = max(cellfun(@(p) size(p, 1), paths));  % Find the longest path
    for step = 1:max_steps  % Loop through the maximum number of steps
        for i = 1:num_robots
            if step <= size(paths{i}, 1)
                % Update the robot position along the path
                set(robot_markers(i), 'XData', paths{i}(step, 1), 'YData', paths{i}(step, 2));
            end
        end
        drawnow;  % Update the figure immediately
        pause(0.05);  % Control the animation speed
    end

    hold off;
end
