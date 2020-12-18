use <hull_polyline3d.scad>;
use <maze/mz_square_blocks.scad>;
use <maze/mz_square_walls.scad>;
use <ptf/ptf_x_twist.scad>;
use <ptf/ptf_y_twist.scad>;

rows = 10;
columns = 10;
block_width = 4;
wall_thickness = 1;   
angle = 90;
axis = "X_AXIS"; // [X_AXIS, Y_AXIS]
// $fn = 24;

blocks = mz_square_blocks(
    rows, columns
);

walls = mz_square_walls(blocks, rows, columns, block_width);

size = [columns * block_width, rows * block_width];
for(wall_pts = walls) {  
   transformed = [for(pt = wall_pts) axis == "X_AXIS" ? ptf_x_twist(size, pt, angle) : ptf_y_twist(size, pt, angle)];
   hull_polyline3d(transformed, wall_thickness);
}