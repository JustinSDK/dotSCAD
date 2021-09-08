use <__comm__/_pt3_hash.scad>;
use <util/rand.scad>;
use <util/dedup.scad>;
use <util/map/hashmap.scad>;
use <util/map/hashmap_get.scad>;
use <noise/nz_worley3s.scad>;
use <experimental/geom_icosahedron.scad>;

// radius = 30;
// detail = 3;
// amplitude = .05;
// dist = "border"; // [euclidean, manhattan, chebyshev, border]
	
// worley_sphere(radius, detail, amplitude, dist);

module worley_sphere(radius, detail, amplitude, dist = "border", grid_w = undef, seed = undef) {
    gw = is_undef(grid_w) ? radius : grid_w;
	
    points_faces = geom_icosahedron(radius, detail, quick_mode = false);
	points = points_faces[0];
	faces = points_faces[1];

	sd = is_undef(seed) ? rand() * 1000: seed;
    noisy = nz_worley3s(points, sd, gw, dist);

	noisy_points = [
		for(i = [0:len(points) - 1])
		let(
			p = points[i],
			nz = noisy[i][3]
		)
		p / norm(p) * (radius + nz * amplitude)
	];
	
	polyhedron(noisy_points, faces);
}