use <voronoi/vrn2_cells_space.scad>
use <polyline_join.scad>
use <ptf/ptf_torus.scad>

size = [40, 80];
grid_w = 5;
cells = vrn2_cells_space(size, grid_w);

$fn = 4;

for(cell = cells) {
    cell_poly = [for(p = cell[1]) ptf_torus(size, p, [10, 5], [360, 360])];

    polyline_join(cell_poly)
	    sphere(d = 1);
}