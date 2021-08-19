use <sweep.scad>;
use <util/rand.scad>;
use <noise/nz_worley3s.scad>;
use <ptf/ptf_rotate.scad>;

$fn = 192;

radius = 30;
amplitude = 20;
sample_scale = 0.05;
dist = "border"; // [euclidean, manhattan, chebyshev, border]
grid_w = 1;
	
worley_sphere(radius, amplitude, sample_scale, grid_w, dist);

module worley_sphere(radius, amplitude, sample_scale, grid_w = 1, dist = "border", angle_boundary = 180 / $fn, seed = undef) {
    sd = is_undef(seed) ? rand() * 1000: seed;
	a_step = 360 / $fn;

	sections = [
	    for(a = [-90 + angle_boundary:a_step:90 - angle_boundary])
		let(p = [radius * cos(-a), 0, radius * sin(-a)])		
			for(a = [0:a_step:360 - a_step])
			ptf_rotate(p, a)
		
	];

    nz = nz_worley3s(sections * sample_scale, sd, grid_w, dist);
	noisy_sphere = [
			for(i = [0:len(nz) - 1])
			let(
				p = sections[i],
				p2d = [p[0], p[1]],
				noisyP = p2d + p2d / norm(p2d) * nz[i][3] * amplitude
			)
			[noisyP[0], noisyP[1], p[2]]
	];

	sweep([
	    for(i = [0:$fn:len(noisy_sphere) - $fn])
		[
		    for(j = [0:$fn - 1])
			noisy_sphere[i + j]
		]
	]);
}