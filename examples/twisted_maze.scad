include <hull_polyline3d.scad>;
include <rotate_p.scad>;
include <square_maze.scad>;

rows = 16;
columns = 8;
block_width = 2;
wall_thickness = 1;   
angle = 90;
// $fn = 24;

blocks = go_maze( 
    1, 1,   // starting point
    starting_maze(rows, columns),  
    rows, columns
);
    
walls = maze_walls(blocks, rows, columns, block_width);

for(wall_pts = y_twist(walls, angle, rows, columns, block_width)) {   
   hull_polyline3d(wall_pts, wall_thickness);
}