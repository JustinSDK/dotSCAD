use <stereographic_extrude.scad>
use <square_maze.scad>

maze_rows = 10;
cell_width = 40;
wall_thickness = 20;
fn = 36;
shadow = "YES"; // [YES, NO]
wall_height = 2;

module stereographic_projection_maze2(maze_rows, cell_width, wall_thickness, fn, wall_height, shadow) {
    length = cell_width * maze_rows + wall_thickness;
    
    module maze() {
        translate([-cell_width * maze_rows / 2, -cell_width * maze_rows / 2, 0]) 
            square_maze(maze_rows, cell_width, wall_thickness);
    }
    
    stereographic_extrude(shadow_side_leng = length, $fn = fn, convexity = 10)
        maze();
    
    if(shadow == "YES") {
        color("black") 
        linear_extrude(wall_height) 
            maze();
    }
}

stereographic_projection_maze2(maze_rows, cell_width, wall_thickness, fn, wall_height, shadow);