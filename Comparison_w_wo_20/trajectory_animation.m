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

    % Plot start and goal positions (5 main start positions for each room)
    for i = 1:size(start_poses, 1)
        plot(start_poses(i, 1), start_poses(i, 2), 'go', 'MarkerSize', 5, 'MarkerFaceColor', 'g');  % Main Start Positions
    end

    for i = 1:size(goal_poses, 1)
        plot(goal_poses(i, 1), goal_poses(i, 2), 'ro', 'MarkerSize', 5, 'MarkerFaceColor', 'r');  % Goal Positions
    end

    % Animate the robot's movement along their paths
    num_robots = length(paths);
    robot_markers = gobjects(num_robots, 1);  % Create handles for robot markers

    % Generate unique offsets for each robot (small random offsets)
    offsets = randn(num_robots, 2) * 0.5;  % Adjust the scaling factor for offsets as needed

    for i = 1:num_robots
        % Plot initial position of each robot based on their main start position
        % Use mod to make sure that each robot uses one of the 5 main positions per room
        room_id = ceil(i / 25);  % Identify the room of the robot (1 to 4)
        pos_id = mod(i-1, 5) + 1;  % Cycle through the 5 main start positions
        robot_markers(i) = plot(start_poses((room_id-1)*5 + pos_id, 1), start_poses((room_id-1)*5 + pos_id, 2), 'bo', 'MarkerSize', 2, 'MarkerFaceColor', 'b');
    end

    % Move the robots along their paths and capture each frame
    for step = 1:max(cellfun(@(p) size(p, 1), paths))
        for i = 1:num_robots
            if step <= size(paths{i}, 1)
                % Apply the dynamic offset to each robot's position
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
