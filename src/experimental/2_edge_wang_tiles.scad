module 2_edge_wang_tiles(rows, columns, tile_width, mask, seed) {
	edges = is_undef(seed) ? [
		for(y = [0:rows])
		[
			for(x = [0:columns]) 
			let(rs = rands(0, 1, 2))
			[round(rs[0]), round(rs[1])]
		]
	] : [
		for(y = [0:rows])
		[
			for(x = [0:columns]) 
			let(rs = rands(0, 1, 2, seed + y * columns + x))
			[round(rs[0]), round(rs[1])]
		]
	];

	m = is_undef(mask) ? [
		for(y = [0:rows - 1])
		    [for(x = [0:columns - 1]) 1]
	] : [
		for(y = rows - 1; y > -1; y = y - 1)
		    [for(x = [0:columns - 1]) mask[y][x]]
	];

	/*
		  1
		. － .
	  8 |    | 2
		. － .
		   4
	*/

    half_w = tile_width / 2;
    translate([half_w, half_w])
	for(y = [0:rows - 1]) {
		for(x = [0:columns - 1]) {
			if(m[y][x] == 1) {
				i = (edges[y + 1][x][0] == 1 ? 1 : 0) +
					(edges[y][x + 1][1] == 1 ? 2 : 0) +
					(edges[y][x][0] == 1 ? 4 : 0) +
					(edges[y][x][1] == 1 ? 8 : 0);
				translate([x, y] * tile_width)
					children(i);
			}
		}
	}
}