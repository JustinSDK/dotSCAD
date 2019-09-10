include <line2d.scad>;
include <square_maze.scad>;

maze_rows = 10;
block_width = 2;
wall_thickness = 1;

module pyramid_maze(maze_rows, block_width, wall_thickness) {
    module pyramid(leng) {
        height = leng / 1.4142135623730950488016887242097;
        linear_extrude(height, scale = 0) 
            square(leng, center = true);
    }

    maze_blocks = go_maze(
        1, 1,   // starting point
        starting_maze(maze_rows, maze_rows),  
        maze_rows, maze_rows
    ); 
   
    leng = maze_rows * block_width ;
    half_leng = leng / 2;
    
    intersection() {
        linear_extrude(leng * 2) 
            translate([-half_leng, -half_leng]) build_square_maze(
                maze_rows, 
                maze_rows, 
                maze_blocks, 
                block_width, 
                wall_thickness
            );
        pyramid(leng + wall_thickness);
    }
}

pyramid_maze(maze_rows, block_width, wall_thickness);