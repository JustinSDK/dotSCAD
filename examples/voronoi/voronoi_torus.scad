use <experimental/voronoi_square_cells.scad>;
use <hull_polyline3d.scad>;
use <ptf/ptf_torus.scad>;

size = [40, 80];
grid_w = 5;
cells = voronoi_square_cells(size, grid_w);

$fn = 4;

for(cell = cells) {
    cell_poly = [for(p = cell[1]) ptf_torus(size, p, [10, 5], [360, 360])];

    hull_polyline3d(cell_poly, thickness = 1);
}