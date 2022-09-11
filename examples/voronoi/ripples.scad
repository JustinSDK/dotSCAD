use <noise/nz_worley2.scad>
use <noise/nz_perlin2.scad>
use <surface/sf_thicken.scad>

size = [30, 30];
grid_w = 15;
amplitude = 1;
mesh_w = 0.2;
wave_smoothing = 2;
thickness = 0.5;
dist = "euclidean"; // [euclidean, manhattan, chebyshev, border] 
seed = 51;

ripples();

module ripples() {
    point_size = size / mesh_w;

	sf = [
		for(y = [0:point_size.y - 1]) 
		[
			for(x = [0:point_size.x - 1]) 
			let(
				px = x * mesh_w,
				py = y * mesh_w,
				nz = nz_worley2(px, py, seed, grid_w, dist)[2],
				n = amplitude * nz_perlin2(nz / wave_smoothing, nz / wave_smoothing, seed)
			)
			[px, py, n]
		]
	];

	sf_thicken(sf, thickness);
}