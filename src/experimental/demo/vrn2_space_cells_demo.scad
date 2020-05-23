use <hull_polyline2d.scad>;
use <voronoi/vrn2_space_cells.scad>;

size = [20, 20];
grid_w = 5;
cells = vrn2_space_cells(size, grid_w);

for(cell = cells) {
    cell_pt = cell[0];
    cell_poly = cell[1];

    linear_extrude(1)
        hull_polyline2d(concat(cell_poly, [cell_poly[0]]), width = 1);
    
    color(rands(0, 1, 3))
    translate(cell_pt)    
    linear_extrude(2, scale = 0.8)
    translate(-cell_pt)    
        polygon(cell_poly);  
}