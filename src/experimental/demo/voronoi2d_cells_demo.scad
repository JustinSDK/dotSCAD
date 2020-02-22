use <hull_polyline2d.scad>;
use <shape_square.scad>;
use <experimental/voronoi2d_cells.scad>;

xs1 = rands(-20, 20, 15);
ys1 = rands(-20, 20, 15);
points = [for(i = [0:len(xs1) - 1]) [xs1[i], ys1[i]]];

function default_region_size(points) = 
    let(
        xs = [for(p = points) p[0]],
        ys = [for(p = points) abs(p[1])]
    )
    max([(max(xs) -  min(xs) / 2), (max(ys) -  min(ys)) / 2]);

size = default_region_size(points);  
region_shape = shape_square(size, corner_r = size / 10);

cells = voronoi2d_cells(points, region_shape);
for(i = [0:len(points) - 1]) {
    pt = points[i];
    cell = cells[i];
    
    linear_extrude(1)
        hull_polyline2d(concat(cell, [cell[0]]), width = 1);
    
    color(rands(0, 1, 3))
    translate(pt)    
    linear_extrude(2, scale = 0.8)
    translate(-pt)    
        polygon(cell);
}