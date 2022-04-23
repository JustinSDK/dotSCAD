// wang tiles - 2 edges

function tile_w2e(size, mask, seed) =
    let(
		rows = size[1], 
		columns = size[0],
		y_range = [0:rows - 1],
		x_range = [0:columns - 1],
		/*
		     1 |
		       |___
			(x,y)  0
		*/
		edges = is_undef(seed) ? [
			for(y = y_range)
			[
				for(x = x_range) 
				let(rs = rands(0, 1, 2))
				[round(rs[0]), round(rs[1])]
			]
		] : [
			for(y = y_range)
			[
				for(x = x_range) 
				let(rs = rands(0, 1, 2, seed + y * columns + x))
				[round(rs[0]), round(rs[1])]
			]
		],
		ones = [for(x = x_range) 1],
		m = is_undef(mask) ? [
			for(y = y_range)
				ones
		] : [
			for(y = rows - 1; y > -1; y = y - 1)
			let(my = mask[y])
				[for(x = x_range) my[x]]
		],
		/*
			1
		  . － .
		8 |    | 2
		  . － .
			4
		*/
		tiles = [
			for(y = y_range)
			let(my = m[y])
				for(x = x_range)
				if(my[x] == 1)
					[x, y, 
						(edges[(y + 1) % rows][x][0] == 1 ? 1 : 0) +
						(edges[y][(x + 1) % columns][1] == 1 ? 2 : 0) +
						(edges[y][x][0] == 1 ? 4 : 0) +
						(edges[y][x][1] == 1 ? 8 : 0)
					]
		]
	)
	tiles;