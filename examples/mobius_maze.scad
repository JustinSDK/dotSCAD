include <hull_polyline3d.scad>;
include <rotate_p.scad>;
include <square_maze.scad>;

rows = 48;
columns = 8;
block_width = 2;
wall_thickness = 1;   
angle = 180;
// $fn = 24;

leng = rows * block_width;
radius = 0.5 * leng / PI;
a_step = 360 / leng;

blocks = go_maze( 
    1, 1,   // starting point
    starting_maze(rows, columns),  
    rows, columns, y_circular = true
);
walls = maze_walls(blocks, rows, columns, block_width, bottom_border = false);

for(wall_pts = y_twist(walls, angle, rows, columns, block_width)) {  
   z_rotated = [for(pt = wall_pts) rotate_p([radius + pt[0], 0, pt[2]], a_step * pt[1])];
   hull_polyline3d(z_rotated, wall_thickness);
}