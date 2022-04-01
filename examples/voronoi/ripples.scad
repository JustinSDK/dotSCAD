use <noise/nz_worley2.scad>;
use <noise/nz_perlin2.scad>;
use <surface/sf_thicken.scad>;

size = [30, 30];
grid_w = 15;
amplitude = 1;
mesh_w = 0.2;
wave_smoothness = 20;
thickness = 0.5;
dist = "euclidean"; // [euclidean, manhattan, chebyshev, border] 
seed = 51;

ripples();

module ripples() {
    point_size = size / mesh_w;

	points = [for(y = [0:point_size.y - 1], x = [0:point_size.x - 1]) [x, y] * mesh_w];

	noise = [for(p = points) nz_worley2(p.x, p.y, seed, grid_w, dist)[2]];

	sf = [
		for(y = [0:point_size.y - 1]) 
			[for(x = [0:point_size.x - 1]) 
				let(
					i = point_size.x * y + x,
					nz = noise[i],
					p = points[i],
					n = amplitude * nz_perlin2(nz + p.x / wave_smoothness, nz + p.y / wave_smoothness, seed)
				)
				[p.x, p.y, n]
			]
	];

	sf_thicken(sf, thickness);
}