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
    obstacles(75:100, 5:15) = 1;    % Unloading Rack 1
    obstacles(75:100, 20:30) = 1;   % Unloading Rack 2
    obstacles(75:100, 35:45) = 1;   % Unloading Rack 3
    obstacles(75:85, 80:100) = 1;   % Unloading Rack 4
    obstacles(90:100, 80:100) = 1;  % Unloading Rack 5


    %% Room 2 (Bottom Right)
    obstacles(1:30, 125:135) = 1;   % Unloading Rack 1
    obstacles(1:30, 140:150) = 1;   % Unloading Rack 2
    obstacles(1:30, 155:165) = 1;   % Unloading Rack 3
    obstacles(1:30, 170:180) = 1;   % Unloading Rack 4
    obstacles(1:30, 185:195) = 1;   % Unloading Rack 5
    obstacles(40:70, 125:135) = 1;  % Unloading Rack 6
    obstacles(40:70, 140:150) = 1;  % Unloading Rack 7
    obstacles(40:70, 155:165) = 1;  % Unloading Rack 8
    obstacles(40:70, 170:180) = 1;  % Unloading Rack 9
    obstacles(40:70, 185:195) = 1;  % Unloading Rack 10

    %% Room 3 (Top Right)
    obstacles(105:120, 105:130) = 1;   % Unloading Rack 1
    obstacles(120:140, 105:130) = 1;   % Unloading Rack 2
    obstacles(170:195, 105:130) = 1;   % Unloading Rack 3
    obstacles(140:150, 170:200) = 1;   % Unloading Rack 4
    obstacles(155:165, 170:200) = 1;   % Unloading Rack 5
    obstacles(170:180, 170:200) = 1;   % Unloading Rack 6
    obstacles(185:195, 170:200) = 1;   % Unloading Rack 7

    %% Room 4 (Top Left)
    obstacles(105:115, 5:15) = 1;   % Unloading Rack 1
    obstacles(105:115, 20:30) = 1;  % Unloading Rack 2
    obstacles(105:115, 35:45) = 1;  % Unloading Rack 3
    obstacles(130:140, 5:15) = 1;   % Unloading Rack 4
    obstacles(130:140, 20:30) = 1;  % Unloading Rack 5
    obstacles(130:140, 35:45) = 1;  % Unloading Rack 6
    obstacles(170:200, 5:15) = 1;   % Unloading Rack 7
    obstacles(170:200, 20:30) = 1;  % Unloading Rack 8
    obstacles(170:200, 35:45) = 1;  % Unloading Rack 9
    obstacles(170:200, 50:60) = 1;  % Unloading Rack 10
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