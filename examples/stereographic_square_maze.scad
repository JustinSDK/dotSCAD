include <line2d.scad>;
include <stereographic_extrude.scad>;
include <square_maze.scad>;

maze_rows = 10;
block_width = 40;
wall_thickness = 20;
fn = 24;
shadow = "YES"; // [YES, NO]
wall_height = 2;

module stereographic_projection_maze2(maze_rows, block_width, wall_thickness, fn, wall_height, shadow) {
    maze_blocks = go_maze(
        1, 1,   // starting point
        starting_maze(maze_rows, maze_rows),  
        maze_rows, maze_rows
    ); 

    length = block_width * maze_rows + wall_thickness;

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
        line2d([0, 0], [block_width * columns, 0], wall_thickness);
        // the leftmost wall
        line2d([0, 0], [0, block_width * rows], wall_thickness);
    } 
    
    module maze() {
        translate([-block_width * maze_rows / 2, -block_width * maze_rows / 2, 0]) union() {
            draw_maze(
                maze_rows, 
                maze_rows, 
                maze_blocks, 
                block_width, 
                wall_thickness
            );
        }
    }
    
    stereographic_extrude(shadow_side_leng = length, $fn = fn)
        maze();
    
    if(shadow == "YES") {
        color("black") linear_extrude(wall_height) maze();
    }
}

stereographic_projection_maze2(maze_rows, block_width, wall_thickness, fn, wall_height, shadow);