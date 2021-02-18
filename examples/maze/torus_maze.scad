use <hull_polyline3d.scad>;
use <ptf/ptf_torus.scad>;
use <maze/mz_square_cells.scad>;
use <maze/mz_square_walls.scad>;

rows = 36;
columns = 12;
cell_width = 2;
line_diameter = 1;   
angle = 180;
twist = 360;

leng = rows * cell_width;
radius = 0.5 * leng / PI;
a_step = 360 / leng;

cells = mz_square_cells(
    rows, columns, 
    x_wrapping = true, y_wrapping = true
);

walls = mz_square_walls(cells, rows, columns, cell_width, left_border = false, bottom_border = false);

size = [columns * cell_width, rows * cell_width];
for(wall_pts = walls) {  
   transformed = [for(pt = wall_pts) ptf_torus(size, pt, [radius, radius / 2], twist = twist)];
   hull_polyline3d(transformed, line_diameter, $fn = 4);
}

color("black")
rotate_extrude($fn = 36)
translate([radius * 1.5, 0, 0])
    circle(radius / 2);