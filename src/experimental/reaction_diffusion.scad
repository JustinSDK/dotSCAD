function init(x, y, n, ix, iy, in) = 
    let(
	    half_x = floor(x / 2),
		half_y = floor(y / 2),
		half_ix = floor(ix / 2),
		half_iy = floor(iy / 2),
		lowx = half_x - half_ix,
		highx = half_x + half_ix,
		lowy = half_y - half_iy,
		highy = half_y + half_iy
	)
	[
		for(j = [0:y - 1])
		[
			for(i = [0:x - 1])
			i >= lowx && i < highx && j >= lowy && j < highy ?
				in : n
		]
	];

function gray_scott(u, v, feel, kill, Du, Dv, space_x, space_y) =
    let(
		nuv = [
			for(y = [0:space_y - 1])
			let(
				uy = (y + 1 + space_y) % space_y,
				ly = (y - 1 + space_y) % space_y,
				row_u = u[y],
				row_v = v[y],
				row_uu = u[uy],
				row_ul = u[ly],
				row_vu = v[uy],
				row_vl = v[ly]
			)
			[
				for(x = [0:space_x - 1])
				let(
					cu = row_u[x],
					cv = row_v[x],
					rx = (x + 1 + space_x) % space_x,
					lx = (x - 1 + space_x) % space_x,
					reaction = cu * (cv ^ 2)
				)
                [
					Du * (row_uu[x] + row_u[rx] + row_ul[x] + row_u[lx] - 4 * cu) - reaction + feel * (1 - cu), 
					Dv * (row_vu[x] + row_v[rx] + row_vl[x] + row_v[lx] - 4 * cv) + reaction - (feel + kill) * cv
				]
			]
		]
	)
	[
	    u + [for(row = nuv) [for(uv = row) uv[0]]], 
		v + [for(row = nuv) [for(uv = row) uv[1]]]
	];
	
function _reaction_diffusion(feel, kill, generation, u, v, Du, Dv, space_x, space_y) = 
    generation == 0 ? [u, v] :
	let(nuv = gray_scott(u, v, feel, kill, Du, Dv, space_x, space_y))
	_reaction_diffusion(feel, kill, generation - 1, nuv[0], nuv[1], Du, Dv, space_x, space_y);
	
function reaction_diffusion(
    feel, kill, generation, space_size = [50, 50], init_size = [10, 10], init_u = 0.5, init_v = 0.25, Du = 0.2, Dv = 0.1) =
	let(
		u = init(space_size[0], space_size[1], 1, init_size[0], init_size[1], init_u),
		v = init(space_size[0], space_size[1], 0, init_size[0], init_size[1], init_v)
	)
	_reaction_diffusion(feel, kill, generation, u, v, Du, Dv, space_size[0], space_size[1]);


/*
use <surface/sf_thicken.scad>;
use <experimental/reaction_diffusion.scad>;

feel = 0.04; 
kill = 0.06;
generation = 1000;
thickness = 0.5;
altitude_scale = 10;
space_size = [50, 50];
init_size = [10, 10];

uv = reaction_diffusion(feel, kill, generation, space_size, init_size);

leng_y = len(uv[0]);
leng_x = len(uv[0][0]);

points = [
    for(y = [0:leng_y - 1])
	[
	     for(x = [0:leng_x - 1])
		 [x, y, uv[0][y][x] * altitude_scale]
	]
];

sf_thicken(points, thickness);
*/