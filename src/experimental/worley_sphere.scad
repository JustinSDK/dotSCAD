use <util/rand.scad>;
use <noise/nz_worley3s.scad>;
use <experimental/geom_isosphere.scad>;

radius = 30;
detail = 3;
amplitude = .1;
dist = "border"; // [euclidean, manhattan, chebyshev, border]
	
worley_sphere(radius, detail, amplitude);

module worley_sphere(radius, detail, amplitude, dist = "border", grid_w = undef, seed = undef) {
    gw = is_undef(grid_w) ? radius : grid_w;
	
    points_faces = geom_isosphere(radius, detail);
	points = points_faces[0];
	faces = points_faces[1];
    
	sd = is_undef(seed) ? rand() * 1000: seed;
	nz = nz_worley3s(points, sd, gw, dist);

	noisy_points = [
		for(i = [0:len(nz) - 1])
		let(p = points[i])
		p / norm(p) * (radius + nz[i][3] * amplitude)
	];
	
	polyhedron(noisy_points, faces);
}