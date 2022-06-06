use <polyline_join.scad>
use <ptf/ptf_torus.scad>
use <maze/mz_square.scad>
use <maze/mz_squarewalls.scad>

rows = 36;
columns = 12;
cell_width = 2;
line_diameter = 1;   
angle = 180;
twist = 360;

leng = rows * cell_width;
radius = 0.5 * leng / PI;
a_step = 360 / leng;

cells = mz_square(
    rows, columns, 
    x_wrapping = true, y_wrapping = true
);

walls = mz_squarewalls(cells, cell_width, left_border = false, bottom_border = false);

size = [columns * cell_width, rows * cell_width];
for(wall_pts = walls) {  
   transformed = [for(pt = wall_pts) ptf_torus(size, pt, [radius, radius / 2], twist = twist)];
   polyline_join(transformed)
       sphere(d = line_diameter, $fn = 4);
}

color("black")
rotate_extrude($fn = 36)
translate([radius * 1.5, 0, 0])
    circle(radius / 2);