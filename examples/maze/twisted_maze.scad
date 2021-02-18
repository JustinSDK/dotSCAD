use <hull_polyline3d.scad>;
use <maze/mz_square_cells.scad>;
use <maze/mz_square_walls.scad>;
use <ptf/ptf_x_twist.scad>;
use <ptf/ptf_y_twist.scad>;

rows = 10;
columns = 10;
cell_width = 4;
line_diameter = 1;   
angle = 90;
axis = "X_AXIS"; // [X_AXIS, Y_AXIS]
// $fn = 24;

cells = mz_square_cells(
    rows, columns
);

walls = mz_square_walls(cells, rows, columns, cell_width);

size = [columns * cell_width, rows * cell_width];
for(wall_pts = walls) {  
   transformed = [for(pt = wall_pts) axis == "X_AXIS" ? ptf_x_twist(size, pt, angle) : ptf_y_twist(size, pt, angle)];
   hull_polyline3d(transformed, line_diameter);
}