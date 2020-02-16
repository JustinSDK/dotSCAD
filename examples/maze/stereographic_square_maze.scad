use <stereographic_extrude.scad>;
use <square_maze.scad>;

maze_rows = 10;
block_width = 40;
wall_thickness = 20;
fn = 24;
shadow = "YES"; // [YES, NO]
wall_height = 2;

module stereographic_projection_maze2(maze_rows, block_width, wall_thickness, fn, wall_height, shadow) {
    length = block_width * maze_rows + wall_thickness;
    
    module maze() {
        translate([-block_width * maze_rows / 2, -block_width * maze_rows / 2, 0]) 
            square_maze([1, 1], maze_rows, block_width, wall_thickness);
    }
    
    stereographic_extrude(shadow_side_leng = length, $fn = fn)
        maze();
    
    if(shadow == "YES") {
        color("black") 
        linear_extrude(wall_height) 
            maze();
    }
}

stereographic_projection_maze2(maze_rows, block_width, wall_thickness, fn, wall_height, shadow);