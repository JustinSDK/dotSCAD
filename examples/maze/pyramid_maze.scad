use <square_maze.scad>

maze_rows = 10;
cell_width = 2;
wall_thickness = 1;

module pyramid_maze(maze_rows, cell_width, wall_thickness) {
    module pyramid(leng) {
        height = leng / 1.4142135623730950488016887242097;
        linear_extrude(height, scale = 0) 
            square(leng, center = true);
    }
    
    leng = maze_rows * cell_width ;
    half_leng = leng / 2;
    
    intersection() {
        linear_extrude(leng * 2) 
        translate([-half_leng, -half_leng]) 
            square_maze(maze_rows, cell_width, wall_thickness);

        pyramid(leng + wall_thickness);
    }
}

pyramid_maze(maze_rows, cell_width, wall_thickness);