use <util/rand.scad>
use <noise/_impl/_nz_worley3_impl.scad>
use <polyhedra/geom_icosahedron.scad>

radius = 30;
detail = 10;
amplitude = .05;
dist = "border"; // [euclidean, manhattan, chebyshev, border]
	
worley_sphere(radius, detail, amplitude, dist);

module worley_sphere(radius, detail, amplitude, dist = "border", grid_w = undef, seed = undef) {
    gw = is_undef(grid_w) ? radius : grid_w;
    points_faces = geom_icosahedron(1, detail);
	sd = is_undef(seed) ? rand() : seed;
	points = points_faces[0];
	noises = _nz_worley3s(points * radius, sd, gw, dist);
	polyhedron(
		[for(i = [0:len(points) - 1]) points[i] * (radius + noises[i][3] * amplitude)], 
		points_faces[1]
	);
}