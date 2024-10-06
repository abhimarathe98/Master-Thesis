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
    video_writer = VideoWriter(video_filename, 'MPEG-4');  % You can specify the format, e.g., 'MPEG-4'
    video_writer.FrameRate = 10;  % Adjust the frame rate as needed
    open(video_writer);  % Open the video file for writing

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
        plot(goal_poses(i, 1), goal_poses(i, 2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');    % Goal
    end

    % Animate the robot's movement along their paths
    num_robots = length(paths);
    robot_markers = gobjects(num_robots, 1);  % Create handles for robot markers
    for i = 1:num_robots
        % Plot initial position of each robot
        robot_markers(i) = plot(start_poses(i, 1), start_poses(i, 2), 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
    end

    % Move the robots along their paths and capture each frame
    for step = 1:max(cellfun(@(p) size(p, 1), paths))
        for i = 1:num_robots
            if step <= size(paths{i}, 1)
                % Update robot marker position along the path
                set(robot_markers(i), 'XData', paths{i}(step, 1), 'YData', paths{i}(step, 2));  % X = first column, Y = second column
            end
        end
        pause(0.1);  % Adjust the speed of the animation as needed
        drawnow;
        
        % Capture the current frame and write it to the video
        frame = getframe(gcf);  % Get the current figure's frame
        writeVideo(video_writer, frame);  % Write the frame to the video
    end

    hold off;

    % Close the video file
    close(video_writer);
end
