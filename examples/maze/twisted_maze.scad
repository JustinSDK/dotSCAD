use <hull_polyline3d.scad>;
use <experimental/mz_blocks.scad>;
use <experimental/mz_walls.scad>;
use <experimental/ptf_y_twist.scad>;

rows = 16;
columns = 8;
block_width = 4;
wall_thickness = 1;   
angle = 180;
// $fn = 24;

blocks = mz_blocks(
    [1, 1],  
    rows, columns
);

walls = mz_walls(blocks, rows, columns, block_width);

size = [columns * block_width, rows * block_width];
for(wall_pts = walls) {  
   transformed = [for(pt = wall_pts) ptf_y_twist(size, pt, angle)];
   hull_polyline3d(transformed, wall_thickness);
}