use <hull_polyline3d.scad>;
use <experimental/mz_blocks.scad>;
use <experimental/mz_walls.scad>;
use <experimental/ptf_ring.scad>;

rows = 48;
columns = 8;
block_width = 2;
wall_thickness = 1;   
angle = 180;
// $fn = 24;

leng = rows * block_width;
radius = 0.5 * leng / PI;
a_step = 360 / leng;

blocks = mz_blocks(
    [1, 1],  
    rows, columns, 
    y_circular = true
);

walls = mz_walls(blocks, rows, columns, block_width, bottom_border = false);

size = [columns * block_width, rows * block_width];
for(wall_pts = walls) {  
   transformed = [for(pt = wall_pts) ptf_ring(size, pt, radius, 360, angle)];
   hull_polyline3d(transformed, wall_thickness);
}