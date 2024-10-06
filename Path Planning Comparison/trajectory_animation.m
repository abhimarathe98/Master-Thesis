function trajectory_animation(start_poses, goal_poses, paths)
    % trajectory_animation - Animates robot trajectories from start to goal
    % positions, then moves to the loading station, all in the same
    % animation, without repeating.
    % Input:
    %   - start_poses: Starting positions of the robots
    %   - goal_poses: Goal positions of the robots
    %   - paths: Cell array containing paths for each robot

    % Plot the original warehouse layout as the background
    warehouse_layout();
    hold on;
    title('Multi-Robot Trajectory Animation');
    xlabel('X [meters]');
    ylabel('Y [meters]');
    grid on;

    % Plot start and goal positions
    for i = 1:length(start_poses)
        plot(start_poses(i, 1), start_poses(i, 2), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');  % Start
        plot(goal_poses(i, 1), goal_poses(i, 2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');    % Unloading Station
    end

    % Animate the robots' movement along their paths
    num_robots = length(paths);
    robot_markers = gobjects(num_robots, 1);  % Create handles for robot markers
    for i = 1:num_robots
        % Plot initial position of each robot
        robot_markers(i) = plot(start_poses(i, 1), start_poses(i, 2), 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
    end

    % Move the robots along their paths to the unloading stations
    for step = 1:max(cellfun(@(p) size(p, 1), paths))
        for i = 1:num_robots
            if step <= size(paths{i}, 1)
                % Update robot marker position along the path
                set(robot_markers(i), 'XData', paths{i}(step, 1), 'YData', paths{i}(step, 2));  % X = first column, Y = second column
            end
        end
        pause(0.1);  % Adjust the speed of the animation as needed
        drawnow;
    end

    % Wait 3 seconds at the unloading stations (simulate robot waiting)
    wait_time = 3;  % 3 seconds
    steps_in_wait = wait_time / 0.1;  % How many animation steps should occur during the wait

    for t = 1:steps_in_wait
        pause(0.1);  % Continue the animation with no movement
        drawnow;  % Keep updating the figure for interaction analysis
    end

    % Now, continue to the final loading station for all robots at once
    final_goal = [137.5, 155];  % Loading station
    for i = 1:num_robots
        % Compute the final path from the unloading stations to the loading station
        final_path = astar_path(goal_poses(i, :), final_goal, [200, 200], obstacle_map([200, 200]));
        
        for step = 1:size(final_path, 1)
            % Update robot marker positions to move to the loading station
            set(robot_markers(i), 'XData', final_path(step, 1), 'YData', final_path(step, 2));
        end
    end
    
    pause(0.1);  % Pause for smooth animation
    drawnow;

    hold off;
end
