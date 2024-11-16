function trajectory_animation(start_poses, goal_poses, paths, video_filename)
    % trajectory_animation - Animates robot trajectories from start to goal and saves as video
    % Input:
    %   - start_poses: Starting positions of the robots
    %   - goal_poses: Goal positions of the robots
    %   - paths: Cell array containing paths for each robot
    %   - video_filename: (Optional) The name of the output video file

    if nargin < 4  % If no video filename is provided, use a default name
        video_filename = 'robot_animation.mp4';
    end

    % Create VideoWriter object to save the video
    video_writer = VideoWriter(video_filename, 'MPEG-4');  
    video_writer.FrameRate = 10;  % Adjust the frame rate as needed
    open(video_writer);  % Open the video file for writing

    warehouse_layout();
    hold on;
    title('Multi-Robot Trajectory Animation');
    xlabel('X [meters]');
    ylabel('Y [meters]');
    grid on;

    % Plot only the main start positions (5 per room)
    for room_idx = 1:4
        for pos_idx = 1:5
            % Calculate the index for the main positions
            main_pos_index = (room_idx - 1) * 5 + pos_idx;
            plot(start_poses(main_pos_index, 1), start_poses(main_pos_index, 2), 'go', 'MarkerSize', 5, 'MarkerFaceColor', 'g');
        end
    end

    % Plot goal positions
    for i = 1:size(goal_poses, 1)
        plot(goal_poses(i, 1), goal_poses(i, 2), 'ro', 'MarkerSize', 5, 'MarkerFaceColor', 'r');
    end

    % Animate the robots' movement along their paths
    num_robots = length(paths);
    robot_markers = gobjects(num_robots, 1);  % Create handles for robot markers

    % Generate unique offsets for each robot (small random offsets)
    offsets = randn(num_robots, 2) * 0.5;  % Adjust the scaling factor for offsets as needed

    % Assign each robot to a start position, cycling through main positions if necessary
    num_main_positions = size(start_poses, 1);
    for i = 1:num_robots
        main_start_index = mod(i - 1, num_main_positions) + 1;
        robot_markers(i) = plot(start_poses(main_start_index, 1), start_poses(main_start_index, 2), ...
                                'bo', 'MarkerSize', 2, 'MarkerFaceColor', 'b');
    end

    % Move the robots along their paths and capture each frame
    max_steps = max(cellfun(@(p) size(p, 1), paths));
    for step = 1:max_steps
        for i = 1:num_robots
            if step <= size(paths{i}, 1)
                % Apply the dynamic offset to each robot's position for movement only
                offset_position = paths{i}(step, :) + offsets(i, :);

                % Ensure the robot stays within the grid (optional boundary checking)
                offset_position = max(min(offset_position, [200, 200]), [1, 1]);

                % Update robot marker position along the path with the applied offset
                set(robot_markers(i), 'XData', offset_position(1), 'YData', offset_position(2));
            end
        end
        pause(0.1);  % Adjust the speed of the animation as needed
        drawnow;
        
        % Capture the current frame and write it to the video
        frame = getframe(gcf);  
        writeVideo(video_writer, frame);
    end

    hold off;
    close(video_writer);
end
