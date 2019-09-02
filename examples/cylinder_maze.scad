include <hollow_out.scad>;
include <bend.scad>;
include <square_maze.scad>;

radius = 30; 
height = 60;
block_width = 8;

wall_thickness = 5;
wall_height = 5;
wall_top_scale = 0.25;

fn = 24;

module draw_ramp_maze(rows, columns, blocks, block_width, wall_thickness, wall_height, wall_top_scale) {

    module ramp_line(point1, point2, width = 1, height = 1, top_scale = 0.25) {
        angle = 90 - atan((point2[1] - point1[1]) / (point2[0] - point1[0]));
        offset_x = 0.5 * width * cos(angle);
        offset_y = 0.5 * width * sin(angle);

        offset1 = [-offset_x, offset_y];
        offset2 = [offset_x, -offset_y];

        hull() {
            translate(point1) 
                linear_extrude(height, scale = top_scale) 
                    square(width, center = true);
            translate(point2) 
                linear_extrude(height, scale = top_scale) 
                    square(width, center = true);
        }
    }

    module draw_ramp_block(wall_type, block_width, wall_thickness, wall_height, wall_top_scale) {
        if(wall_type == UPPER_WALL || wall_type == UPPER_RIGHT_WALL) {
            ramp_line(
                [0, block_width], [block_width, block_width], wall_thickness, wall_height, wall_top_scale
            ); 
        }

        if(wall_type == RIGHT_WALL || wall_type == UPPER_RIGHT_WALL) {
            ramp_line(
                [block_width, block_width], [block_width, 0], wall_thickness, wall_height, wall_top_scale
            ); 
        }
    }

    for(block = blocks) {
        translate([get_x(block) - 1, get_y(block) - 1] * block_width) 
            draw_ramp_block(
                get_wall_type(block), 
                block_width, 
                wall_thickness,
                wall_height,
                wall_top_scale
            );
    }

    ramp_line(
        [0, 0], [block_width * columns, 0], 
        wall_thickness, wall_height, wall_top_scale
    );
} 

module maze_cylinder() {
    maze_rows = round(height / block_width);
    maze_columns = round(2 * 3.14159 * radius / block_width);

    maze_blocks = go_maze(
        1, maze_rows,   
        starting_maze(maze_rows, maze_columns),  
        maze_rows, maze_columns,
        x_circular = true
    );
    
    leng_circumference = block_width * maze_columns + wall_thickness;

    bend(size = [leng_circumference, block_width * maze_rows + wall_thickness, wall_height], angle = 360 + 360 * wall_thickness / leng_circumference, frags = fn) 
        translate([0, wall_thickness / 2, 0]) draw_ramp_maze(
            maze_rows, 
            maze_columns, 
            maze_blocks, 
            block_width, 
            wall_thickness,
            wall_height,
            wall_top_scale
        );
}

maze_cylinder();
