use <polyline_join.scad>
use <maze/mz_square.scad>
use <maze/mz_squarewalls.scad>
use <ptf/ptf_x_twist.scad>
use <ptf/ptf_y_twist.scad>

rows = 10;
columns = 10;
cell_width = 4;
line_diameter = 1;   
angle = 90;
axis = "X_AXIS"; // [X_AXIS, Y_AXIS]
// $fn = 24;

cells = mz_square(rows, columns);

walls = mz_squarewalls(cells, cell_width);

size = [columns * cell_width, rows * cell_width];
for(wall_pts = walls) {  
   transformed = [for(pt = wall_pts) axis == "X_AXIS" ? ptf_x_twist(size, pt, angle) : ptf_y_twist(size, pt, angle)];
   polyline_join(transformed)
       sphere(d = line_diameter);
}