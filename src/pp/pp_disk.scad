/**
* pp_disk.scad
*
* @copyright Justin Lin, 2022
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-pp_disk.html
*
**/ 

function pp_disk(radius, value_count, seed = undef) =
    let(
	    seed_undef = is_undef(seed),
		n = value_count * 2,
	    theta = seed_undef ? rands(0, 360, n) : rands(0, 360, n, seed),
		k = radius ^ 2 * (seed_undef ? rands(0, 1, n) : rands(0, 1, n, seed))
	)
	[
	    for(i = [0:value_count - 1])
		[cos(theta[i]), sin(theta[i])] * sqrt(k[i])
	];
	