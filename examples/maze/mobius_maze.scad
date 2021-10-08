use <polyline_join.scad>;
use <maze/mz_square_cells.scad>;
use <maze/mz_square_walls.scad>;
use <ptf/ptf_ring.scad>;

rows = 48;
columns = 8;
cell_width = 2;
line_diameter = 1;   
angle = 180;
// $fn = 24;

leng = rows * cell_width;
radius = 0.5 * leng / PI;
a_step = 360 / leng;

cells = mz_square_cells(
    rows, columns, 
    y_wrapping = true
);

walls = mz_square_walls(cells, rows, columns, cell_width, bottom_border = false);

size = [columns * cell_width, rows * cell_width];
for(wall_pts = walls) {  
   transformed = [for(pt = wall_pts) ptf_ring(size, pt, radius, 360, angle)];
   polyline_join(transformed)
       sphere(d = line_diameter);
}