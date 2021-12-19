use <noise/nz_worley2.scad>;
use <noise/nz_perlin3.scad>;
use <surface/sf_thicken.scad>;

size = [100, 100];
grid_w = 5;
detail = 5;
thickness = 0.5;
dist = "euclidean"; // [euclidean, manhattan, chebyshev, border] 
seed = 51;

ripples();

module ripples() {
	points = [
		for(y = [0:size.y - 1]) 
			for(x = [0:size.x - 1]) 
				[x, y]
	];

	cells = [for(p = points) nz_worley2(p.x / detail, p.y / detail, seed, grid_w, dist)];

	detail2 = detail / 2 * 10;
	nz2 = [
		for(y = [0:size.y - 1]) 
			[for(x = [0:size.x - 1]) 
				let(
					i = size.x * y + x,
					p = points[i],
					n = 2.5 * (nz_perlin3(cells[i][2], p.x / detail2, p.y / detail2, 1) + 1)
				)
				[p.x, p.y, n]
			]
	];


	sf_thicken(nz2, thickness);
}