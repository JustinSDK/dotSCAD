include <line2d.scad>;
include <square_maze.scad>;

maze_rows = 8;
block_width = 10;
stairs_width = 5;

module draw_block(wall_type, block_width, wall_thickness) {
    if(wall_type == UPPER_WALL || wall_type == UPPER_RIGHT_WALL) {
        // draw a upper wall
        line2d(
            [0, block_width], [block_width, block_width], wall_thickness
        ); 
    }
    
    if(wall_type == RIGHT_WALL || wall_type == UPPER_RIGHT_WALL) {
        // draw a right wall
        line2d(
            [block_width, block_width], [block_width, 0], wall_thickness
        ); 
    }
}

module draw_maze(rows, columns, blocks, block_width, wall_thickness) {
    for(block = blocks) {
        // move a block to a right position.
        translate([get_x(block) - 1, get_y(block) - 1] * block_width) 
            draw_block(
                get_wall_type(block), 
                block_width, 
                wall_thickness
            );
    }

    // the lowermost wall
    line2d([0, 0], [block_width * columns, 0], 
         wall_thickness);
    // the leftmost wall
    line2d([0, block_width], [0, block_width * rows], 
         wall_thickness);
} 

module pyramid_with_stairs(base_width, stairs_width, rows) {
    height = base_width * sqrt(2) / 2;

    module floor(i) {
        base_w = base_width - (base_width / rows) * (i - 1) + stairs_width;
        floor_h = height / rows * 2;
                
        stairsteps = rows;
        staircase_h = floor_h / stairsteps;
        staircase_w = stairs_width / stairsteps * 2;
        
        translate([0, 0, floor_h / 2 * (i - 1)]) 
            for(j = [1:stairsteps]) {
                square_w = base_w - j * staircase_w;
                translate([0, 0, staircase_h * (j - 1)])  
                    linear_extrude(staircase_h) 
                        square([square_w, square_w], center = true);
            }
    }
    
    for(i = [1:2:rows - 1]) {
        floor(i);
    }
}

module pyramidal_staircase_maze(maze_rows, block_width, stairs_width) {
    maze_blocks = go_maze(
        1, 1,   // starting point
        starting_maze(maze_rows, maze_rows),  
        maze_rows, maze_rows
    ); 
    
    intersection() {
        pyramid_with_stairs(
            maze_rows * block_width, stairs_width, maze_rows);

        linear_extrude(maze_rows * block_width * sqrt(2) / 2)  difference() {
            
            square([block_width * maze_rows + stairs_width, block_width * maze_rows + stairs_width], center = true);
            
            translate([-(maze_rows * block_width) / 2, -(maze_rows * block_width) / 2, 0]) 

            
            draw_maze(
                maze_rows, 
                maze_rows, 
                maze_blocks, 
                block_width, 
                stairs_width
            );
        }
    }
}

pyramidal_staircase_maze(maze_rows, block_width, stairs_width);