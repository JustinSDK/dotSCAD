use <util/rand.scad>;
use <noise/nz_worley3s.scad>;
use <polyhedra/geom_icosahedron.scad>;

radius = 30;
detail = 10;
amplitude = .05;
dist = "border"; // [euclidean, manhattan, chebyshev, border]
	
worley_sphere(radius, detail, amplitude, dist);

module worley_sphere(radius, detail, amplitude, dist = "border", grid_w = undef, seed = undef) {
    gw = is_undef(grid_w) ? radius : grid_w;
	
    points_faces = geom_icosahedron(1, detail);
	points = points_faces[0];
	faces = points_faces[1];

	sd = is_undef(seed) ? rand() * 1000: seed;
    noisy = nz_worley3s(points * radius, sd, gw, dist);

	noisy_points = [
		for(i = [0:len(points) - 1])
		let(
			p = points[i],
			nz = noisy[i][3]
		)
		p * (radius + nz * amplitude)
	];
	
	polyhedron(noisy_points, faces);
}