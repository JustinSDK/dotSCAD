function tile_hitomezashi(size, mask, seed) =
    let(
        rows = size[1], 
        columns = size[0],
		rx = is_undef(seed) ? [for(r = rands(0, 1, columns)) round(r)] : [for(r = rands(0, 1, columns, seed + columns)) round(r)],
		ry = is_undef(seed) ? [for(r = rands(0, 1, rows)) round(r)] : [for(r = rands(0, 1, rows, seed + rows)) round(r)],
		y_range = [0:rows - 1],
		x_range = [0:columns - 1],
        nums = [0, 1, 2, 3],
		m = is_undef(mask) ? [
			for(y = y_range)
				[for(x = x_range) 1]
		] : [
			for(y = rows - 1; y > -1; y = y - 1)
				[for(x = x_range) mask[y][x]]
		]
	)
	[
        for(y = y_range)
            for(x = x_range) 
            if(m[y][x] == 1)
			let(
			    wx = ry[y] == 0 && x % 2 == 1 ? 1 : 
				     ry[y] == 1 && x % 2 == 0 ? 1 : 0,
			    wy = rx[x] == 1 && y % 2 == 0 ? 1 : 
				     rx[x] == 0 && y % 2 == 1 ? 1 : 0
			)
            [x, y, wx + wy * 2]
        
    ];
	