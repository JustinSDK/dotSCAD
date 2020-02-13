use <hull_polyline3d.scad>;
use <rotate_p.scad>;
use <square_maze.scad>;
use <experimental/tf_ring.scad>;

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

size = [columns * block_width, rows * block_width];
for(wall_pts = walls) {  
   z_rotated = [for(pt = wall_pts) tf_ring(size, pt, radius, 360, angle)];
   hull_polyline3d(z_rotated, wall_thickness);
}