// wang tiles - 2 corners

function tile_w2c(rows, columns, mask, seed) =
    let(
		y_range = [0:rows - 1],
		x_range = [0:columns - 1],
		corners = is_undef(seed) ? [
			for(y = y_range)
			[
				for(x = x_range) 
				round(rands(0, 1, 1)[0])
			]
		] : [
			for(y = y_range)
			[
				for(x = x_range) 
				round(rands(0, 1, 1, seed + y * columns + x)[0])
			]
		],
		m = is_undef(mask) ? [
			for(y = y_range)
				[for(x = x_range) 1]
		] : [
			for(y = rows - 1; y > -1; y = y - 1)
				[for(x = x_range) mask[y][x]]
		],
		/*
		  8    1
		  . － . 
		  |    | 
		  . － .
		  4    2
		*/
		tiles = [
			for(y = y_range)
				for(x = x_range)
				if(m[y][x] == 1)
					[x, y, 
						(corners[(y + 1) % rows][(x + 1) % columns] == 1 ? 1 : 0) +
						(corners[y][(x + 1) % columns] == 1 ? 2 : 0) +
						(corners[y][x] == 1 ? 4 : 0) +
						(corners[(y + 1) % rows][x] == 1 ? 8 : 0)
					]
		]
	)
	tiles;