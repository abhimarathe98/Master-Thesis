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
    obstacles(25:40, 35:40) = 1;    % Vertical Conveyor
    obstacles(25:30, 40:60) = 1;    % Horizontal Conveyor 2
    obstacles(20:35, 60:70) = 1;    % Sorting block
    obstacles(55:60, 60:65) = 1;    % Obstacle Block
    obstacles(65:70, 60:65) = 1;    % Obstacle Block
    obstacles(75:100, 1:50) = 1;    % Unloading Rack 1
    obstacles(75:85, 80:100) = 1;   % Unloading Rack 4
    obstacles(90:100, 80:100) = 1;  % Unloading Rack 5


    %% Room 2 (Bottom Right)
    obstacles(1:30, 125:200) = 1;   % Unloading Rack 1
    obstacles(40:70, 125:200) = 1;  % Unloading Rack 2

    %% Room 3 (Top Right)
    obstacles(105:120, 105:130) = 1;   % Unloading Rack 1
    obstacles(120:140, 105:130) = 1;   % Unloading Rack 2
    obstacles(170:195, 105:130) = 1;   % Unloading Rack 3
    obstacles(140:200, 170:200) = 1;   % Unloading Rack 4

    %% Room 4 (Top Left)
    obstacles(100:115, 1:45) = 1;   % Unloading Rack 1
    obstacles(130:140, 1:45) = 1;   % Unloading Rack 4
    obstacles(170:200, 5:15) = 1;   % Unloading Rack 7
    obstacles(170:200, 1:60) = 1;  % Unloading Rack 8
    obstacles(100:140, 70:100) = 1; % Office

    %% Walls Between Rooms (Separating Walls)
    obstacles(1:200, 100) = 1;  % Vertical Wall
    obstacles(100, 1:200) = 1;  % Horizontal Wall

    %% Doors Between Rooms (Free passage areas)
    obstacles(50:60, 100) = 0;  % Door between Room 1 and Room 2
    obstacles(100, 50:60) = 0;  % Door between Room 4 and Room 1
    obstacles(100, 150:160) = 0;  % Door between Room 2 and Room 3
    obstacles(150:160, 100) = 0;  % Door between Room 3 and Room 4

end