use <util/rand.scad>;
use <noise/nz_perlin3s.scad>;
use <polyhedra/geom_icosahedron.scad>;

// radius = 30;
// detail = 10;
// amplitude = 10;
// period = 20;
	
// perlin_sphere(radius, detail, amplitude, period);

module perlin_sphere(radius, detail, amplitude, period = 10, seed = undef) {
    points_faces = geom_icosahedron(radius, detail);
	points = points_faces[0];
	faces = points_faces[1];

	sd = is_undef(seed) ? rand() * 1000: seed;
    noisy = nz_perlin3s(points / period, sd);

	noisy_points = [
		for(i = [0:len(points) - 1])
		let(
			p = points[i],
			nz = noisy[i]
		)
		p / norm(p) * (radius + nz * amplitude)
	];
	
	polyhedron(noisy_points, faces);
}