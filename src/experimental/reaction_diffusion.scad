function init(x, y, ix, iy, init_u, init_v) = 
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
			[init_u, init_v] : [1, 0]
		]
	];

function gray_scott(uv, feed, kill, Du, Dv, uy_ly, rx_lx, space_x, space_y) =
    [
		for(y = [0:space_y - 1])
		let(
			uy = uy_ly[y][0],
			ly = uy_ly[y][1],
			ruv = uv[y],
			sum_of_ruv_ul = uv[uy] + uv[ly]
		)
		[
			for(x = [0:space_x - 1])
			let(
				rx = rx_lx[x][0],
				lx = rx_lx[x][1],
				cu = ruv[x][0],
				cv = ruv[x][1],
				reaction = cu * (cv ^ 2)
			)
			[
				cu + Du * (sum_of_ruv_ul[x][0] + ruv[rx][0]+ ruv[lx][0] - 4 * cu) - reaction + feed * (1 - cu), 
				cv + Dv * (sum_of_ruv_ul[x][1] + ruv[rx][1] + ruv[lx][1] - 4 * cv) + reaction - (feed + kill) * cv
			]
		]
	];

function _reaction_diffusion(feed, kill, generation, uv, Du, Dv, uy_ly, rx_lx, space_x, space_y) = 
    generation == 0 ? uv :
	_reaction_diffusion(feed, kill, generation - 1, 
	    gray_scott(uv, feed, kill, Du, Dv, uy_ly, rx_lx, space_x, space_y), 
		Du, Dv, uy_ly, rx_lx, space_x, space_y
	);
	
function reaction_diffusion(
    feed, kill, generation, space_size = [50, 50], init_size = [10, 10], init_u = 0.5, init_v = 0.25, Du = 0.2, Dv = 0.1) =
	let(
		space_x = space_size.x,
		space_y = space_size.y,
		uv = init(space_x, space_y, init_size.x, init_size.y, init_u, init_v),
		uy_ly = [
			for(y = [0:space_y - 1])
			[(y + 1 + space_y) % space_y, (y - 1 + space_y) % space_y]
		],
		rx_lx = [
			for(x = [0:space_x - 1]) 
			[(x + 1 + space_x) % space_x, (x - 1 + space_x) % space_x]
		]
	)
	_reaction_diffusion(feed, kill, generation, uv, Du, Dv, uy_ly, rx_lx, space_x, space_y);


/*
use <surface/sf_thicken.scad>
use <experimental/reaction_diffusion.scad>

feed = 0.04; 
kill = 0.06;
generation = 1000;
thickness = 0.5;
altitude_scale = 10;
space_size = [50, 50];
init_size = [10, 10];

uv = reaction_diffusion(feed, kill, generation, space_size, init_size);

leng_y = len(uv);
leng_x = len(uv[0]);

points = [
    for(y = [0:leng_y - 1])
	[
	     for(x = [0:leng_x - 1])
		 [x, y, uv[y][x][0] * altitude_scale]
	]
];

sf_thicken(points, thickness);
*/