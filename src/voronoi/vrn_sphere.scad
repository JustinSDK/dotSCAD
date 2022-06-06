use <_impl/_vrn_sphere_impl.scad>
use <vrn2_cells_from.scad>

function vrn_sphere(points) = 
    let(
	    r = norm(points[0]),
	    plane_pts = [for(p = points) stereographic_proj_to_plane(p / r)],
		inifinity = [4e7, 0],
		vrn2_cells = vrn2_cells_from([each plane_pts, inifinity])
	)
    [
		for(i = [0:len(vrn2_cells) - 2])
		[for(p = vrn2_cells[i]) stereographic_proj_to_sphere(p) * r]
	];
	
/*
use <voronoi/vrn_sphere.scad>
use <fibonacci_lattice.scad>
use <polyline_join.scad>

n = 60;
radius = 2;

pts = fibonacci_lattice(n, radius);
#for(p = pts) {
    translate(p)
        sphere(.05);
}

cells = vrn_sphere(pts);
for(i = [0:len(cells) - 1]) {
    cell = cells[i];

    polyline_join(concat(cell, [cell[0]]))
        sphere(.05);

}
*/