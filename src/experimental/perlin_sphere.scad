use <util/rand.scad>;
use <noise/nz_perlin3s.scad>;
use <polyhedra/geom_icosahedron.scad>;

radius = 30;
detail = 30;
amplitude = 10;
period = 2;
	
perlin_sphere(radius, detail, amplitude, period);

module perlin_sphere(radius, detail, amplitude, period = 1, seed = undef) {
    points_faces = geom_icosahedron(radius, detail);
	points = points_faces[0];
	faces = points_faces[1];

	sd = is_undef(seed) ? rand() * 1000: seed;
    noisy = nz_perlin3s(period * points / radius, sd);

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