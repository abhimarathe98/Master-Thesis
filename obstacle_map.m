function obstacles = obstacle_map(grid_size)
    % obstacle_map - Generates a binary map of the warehouse obstacles based on the layout
    % Input:
    %   - grid_size: The size of the grid, e.g., [200, 200]
    % Output:
    %   - obstacles: A binary matrix (grid_size) where 1 represents an obstacle and 0 represents free space

    % Initialize a grid with 0s (free spaces initially)
    obstacles = zeros(grid_size);

    % Room 1
    obstacles(25:40, 35:40) = 1;  % Conveyor in Room 1 (Vertical conveyor)
    obstacles(25:30, 35:60) = 1;  % Horizontal conveyor 1
    obstacles(40:45, 1:40) = 1;   % Horizontal conveyor 2
    obstacles(20:35, 60:70) = 1;  % Another free space in Room 1

    % Define racks in Room 1
    obstacles(75:100, 5:15) = 1;  % Unloading rack 1
    obstacles(75:100, 20:30) = 1; % Unloading rack 2
    obstacles(75:100, 35:45) = 1; % Unloading rack 3
    obstacles(90:100, 80:100) = 1; % Unloading rack 4
    obstacles(75:85, 80:100) = 1;  % Unloading rack 5

    % Additional free spaces in Room 1
    obstacles(55:60, 60:65) = 1;  % Free space 1
    obstacles(65:70, 60:65) = 1;  % Free space 2

    % Room 2
    obstacles(1:30, 125:135) = 1;  
    obstacles(1:30, 140:150) = 1;
    obstacles(1:30, 155:165) = 1;
    obstacles(1:30, 170:180) = 1;
    obstacles(1:30, 185:195) = 1;

    % Racks in Room 2
    obstacles(40:70, 125:135) = 1;
    obstacles(40:70, 140:150) = 1;
    obstacles(40:70, 155:165) = 1;
    obstacles(40:70, 170:180) = 1;
    obstacles(40:70, 185:195) = 1;

    % Room 4
    obstacles(105:115, 5:15) = 1;
    obstacles(105:115, 20:30) = 1;
    obstacles(105:115, 35:45) = 1;
    obstacles(130:140, 5:15) = 1;
    obstacles(130:140, 20:30) = 1;
    obstacles(130:140, 35:45) = 1;

    % Rectangular Racks in Room 4
    obstacles(170:200, 5:15) = 1;
    obstacles(170:200, 20:30) = 1;
    obstacles(170:200, 35:45) = 1;
    obstacles(170:200, 50:60) = 1;

    % Partitions between rooms
    obstacles(1:100, 100) = 1;  % Wall between Room 1 and Room 2
    obstacles(100, 100:200) = 1;  % Wall between Room 2 and Room 3
    obstacles(100:200, 100) = 1;  % Wall between Room 3 and Room 4

    % Doors
    obstacles(50:60, 100) = 0;  % Door between Room 1 and Room 2
    obstacles(100, 150:160) = 0;  % Door between Room 2 and Room 3
    obstacles(150:160, 100) = 0;  % Door between Room 3 and Room 4
    obstacles(100, 50:60) = 0;  % Door between Room 1 and Room 4

    % Free up specific robot start positions
    obstacles(15, 5) = 0;  % Robot 1 start position
    obstacles(15, 10) = 0; % Robot 2 start position
    obstacles(15, 15) = 0; % Robot 3 start position
    obstacles(15, 20) = 0; % Robot 4 start position
    obstacles(15, 25) = 0; % Robot 5 start position
end
