use <square_maze.scad>;

maze_rows = 10;
block_width = 2;
wall_thickness = 1;

module pyramid_maze(maze_rows, block_width, wall_thickness) {
    module pyramid(leng) {
        height = leng / 1.4142135623730950488016887242097;
        linear_extrude(height, scale = 0) 
            square(leng, center = true);
    }
    
    leng = maze_rows * block_width ;
    half_leng = leng / 2;
    
    intersection() {
        linear_extrude(leng * 2) 
        translate([-half_leng, -half_leng]) 
            square_maze([1, 1], maze_rows, block_width, wall_thickness);

        pyramid(leng + wall_thickness);
    }
}

pyramid_maze(maze_rows, block_width, wall_thickness);