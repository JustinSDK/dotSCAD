use <shape_circle.scad>
use <bezier_curve.scad>
use <sweep.scad>
use <path_scaling_sections.scad>
use <bijection_offset.scad>
use <util/rand.scad>
use <noise/nz_worley3s.scad>
use <noise/nz_perlin3.scad>

beginning_radius = 30;
height = 180;
thickness = 3;
fn = 180;
amplitude = 4;
curve_step = 0.01;
sample_scale = 0.005;
grid_w = .5;
dist = "euclidean"; // [euclidean, manhattan, chebyshev, border]

bottom = "YES"; // ["YES", "NO"]
epsilon = 0.0000001;

ripple_vase(beginning_radius, height, thickness, fn, amplitude, curve_step, sample_scale, grid_w, dist, bottom, epsilon);

module ripple_vase(beginning_radius, height, thickness, fn, amplitude,curve_step, sample_scale, grid_w, dist, bottom, epsilon) {
    seed = rand() * 1000;
	section = shape_circle(radius = beginning_radius, $fn = fn);
	pt = [beginning_radius, 0, 0];
    h_s = height / 140;
	edge_path = bezier_curve(curve_step, [
		pt,
		pt + [15, 0, 20 * h_s],
		pt + [55, 0, 50 * h_s],
		pt + [20, 0, 70 * h_s],
		pt + [5, 0, 80 * h_s],
		pt + [-5, 0, 100 * h_s],
		pt + [10, 0, 140 * h_s]
	]);

	sections = path_scaling_sections(section, edge_path);

	noisy = [
		for(section = sections)
		let(nz = nz_worley3s(section * sample_scale, seed, grid_w, dist))
		[
			for(i = [0:len(nz) - 1])
			let(
				p = section[i],
				p2d = [p.x, p.y],
				noisyP = p2d + p2d / norm(p2d) * nz_perlin3(nz[i][3] * sample_scale * 5000, p2d.x * sample_scale, p2d.y * sample_scale, seed) * amplitude
			)
			[noisyP.x, noisyP.y, p.z]
		]
	];
	
	offset_noisy = [
		for(section = noisy)
		let(
			offset_s = bijection_offset(section, thickness, epsilon)
		)
		[
			for(i = [0:len(offset_s) - 1])
			[offset_s[i][0], offset_s[i][1], section[i][2]]
		]
	];

	all = [
		for(i = [0:len(offset_noisy) - 1])
		concat(
			offset_noisy[i],
			noisy[i]
		)
	];

	sweep(all, triangles = "HOLLOW");
	
	if(bottom == "YES") {
	    sweep([
			for(section = noisy)
			if(section[0][2] < thickness) 
			section
		]);
	}
}