function obstacles = obstacle_map(grid_size)

    % obstacle_map - Generates a binary map of the warehouse obstacles based on the layout
    % Input:
    %   - grid_size: The size of the grid, e.g., [200, 200]
    % Output:
    %   - obstacles: A binary matrix (grid_size) where 1 represents an obstacle and 0 represents free space

    % Initialize a grid with 0s (free spaces initially)
    obstacles = zeros(grid_size);

    %% Room 1 (Bottom Left)
    % Obstacles (racks and walls)
    obstacles(40:45, 1:40) = 1;     % Horizontal Conveyor 1
    obstacles(20:45, 30:70) = 1;
    obstacles(55:60, 60:65) = 1;    % Obstacle Block
    obstacles(65:70, 60:65) = 1;    % Obstacle Block
    obstacles(75:100, 1:45) = 1;    % Unloading Rack 1
    obstacles(75:85, 80:100) = 1;   % Unloading Rack 4
    obstacles(90:100, 80:100) = 1;  % Unloading Rack 5


    %% Room 2 (Bottom Right)
    obstacles(1:30, 135:210) = 1;   % Unloading Rack 1
    obstacles(40:70, 135:210) = 1;  % Unloading Rack 6

    %% Room 3 (Top Right)
    obstacles(110:150, 110:135) = 1;   % Unloading Rack 1
    obstacles(180:210, 110:135) = 1;   % Unloading Rack 3
    obstacles(150:210, 175:210) = 1;   % Unloading Rack 4

    %% Room 4 (Top Left)
    obstacles(110:120, 5:45) = 1;   % Unloading Rack 1
    obstacles(130:140, 5:45) = 1;  % Unloading Rack 2
    obstacles(170:210, 5:60) = 1;  % Unloading Rack 3
    obstacles(110:150, 70:100) = 1; % Office

    %% Walls Between Rooms (Separating Walls)
    obstacles(1:210, 100:110) = 1;  % Vertical Wall
    obstacles(100:110, 1:210) = 1;  % Horizontal Wall

    %% Doors Between Rooms (Free passage areas)
    obstacles(45:55, 100:110) = 0;  % Corridor between Room 1 and Room 2
    obstacles(100:110, 155:165) = 0;  % Corridor between Room 2 and Room 3
    obstacles(155:165, 100:110) = 0;  % Corridor between Room 3 and Room 4

end