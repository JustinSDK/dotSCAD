use <hull_polyline3d.scad>;
use <rotate_p.scad>;
use <square_maze.scad>;
use <experimental/tf_y_twist.scad>;

rows = 16;
columns = 8;
block_width = 4;
wall_thickness = 1;   
angle = 180;
// $fn = 24;

function y_twist(walls, angle, rows, columns, block_width) = 
    let(size = [columns * block_width, rows * block_width])
    [
        for(wall_pts = walls) 
            [for(pt = wall_pts) tf_y_twist(size, pt, angle)]
    ];

blocks = go_maze( 
    1, 1,   // starting point
    starting_maze(rows, columns),  
    rows, columns
);
    
walls = maze_walls(blocks, rows, columns, block_width);
for(wall_pts = y_twist(walls, angle, rows, columns, block_width)) {   
   hull_polyline3d(wall_pts, wall_thickness);
}