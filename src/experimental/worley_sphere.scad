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
	
    points_faces = geom_icosahedron(radius, detail);
	points = points_faces[0];
	faces = points_faces[1];

    number_of_buckets = ceil(sqrt(len(points)));
    hash = _pt3_hash(number_of_buckets);

	deduped_pts = dedup(points, hash = hash, number_of_buckets = number_of_buckets);

	sd = is_undef(seed) ? rand() * 1000: seed;
    noisy = nz_worley3s(deduped_pts, sd, gw, dist);

	p_nz = hashmap([
		for(i = [0:len(deduped_pts) - 1]) 
		    [deduped_pts[i], noisy[i][3]]
	], hash = hash, number_of_buckets = number_of_buckets);

	noisy_points = [
		for(p = points)
		let(nz = hashmap_get(p_nz, p, hash = hash))
		p / norm(p) * (radius + nz * amplitude)
	];
	
	polyhedron(noisy_points, faces);
}