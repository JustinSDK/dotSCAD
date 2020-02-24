use <hull_polyline3d.scad>;
use <experimental/ptf_torus.scad>;
use <experimental/mz_blocks.scad>;
use <experimental/mz_walls.scad>;

rows = 36;
columns = 12;
block_width = 2;
wall_thickness = 1;   
angle = 180;
twist = 360;

leng = rows * block_width;
radius = 0.5 * leng / PI;
a_step = 360 / leng;

blocks = mz_blocks(
    [1, 1],  
    rows, columns, 
    x_circular = true, y_circular = true
);

walls = mz_walls(blocks, rows, columns, block_width, left_border = false, bottom_border = false);

size = [columns * block_width, rows * block_width];
for(wall_pts = walls) {  
   transformed = [for(pt = wall_pts) ptf_torus(size, pt, [radius, radius / 2], twist = twist)];
   hull_polyline3d(transformed, wall_thickness, $fn = 4);
}

color("black")
rotate_extrude($fn = 36)
translate([radius * 1.5, 0, 0])
    circle(radius / 2);