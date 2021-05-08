use <shape_circle.scad>;
use <bezier_curve.scad>;
use <sweep.scad>;
use <path_scaling_sections.scad>;
use <bijection_offset.scad>;
use <util/rand.scad>;
use <noise/nz_perlin2s.scad>;
use <noise/nz_perlin3s.scad>;

beginning_radius = 20;
thickness = 2;
fn = 180;
amplitude = 15;
smoothness = 15;
// Perlin noise 2D or 3D
perlin = 2; // [2, 3]
epsilon = 0.000001;

distorted_vase(beginning_radius, thickness, fn, amplitude, smoothness, perlin, epsilon);

module distorted_vase(beginning_radius, thickness, fn, amplitude, smoothness, perlin, epsilon) {
	seed = rand() * 1000;
	section = shape_circle(radius = beginning_radius, $fn = fn);
	pt = [beginning_radius, 0, 0];

	edge_path = bezier_curve(0.02, [
		pt,
		pt + [15, 0, 20],
		pt + [45, 0, 50],
		pt + [20, 0, 70],
		pt + [5, 0, 80],
		pt + [-5, 0, 100],
		pt + [10, 0, 140]
	]);


	sections = path_scaling_sections(section, edge_path);

    noise = perlin == 2 ? function(pts, seed) nz_perlin2s(pts, seed) : 
                          function(pts, seed) nz_perlin3s(pts, seed);

	noisy = [
		for(section = sections)
		let(nz = noise(section / smoothness, seed))
		[
			for(i = [0:len(nz) - 1])
			let(
				p = section[i],
				p2d = [p[0], p[1]],
				noisyP = p2d + p2d / norm(p2d) * nz[i] * amplitude
			)
			[noisyP[0], noisyP[1], p[2]]
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
	
	linear_extrude(thickness)
	    polygon([for(p = offset_noisy[len(offset_noisy) - 1]) [p[0], p[1]]]);
}