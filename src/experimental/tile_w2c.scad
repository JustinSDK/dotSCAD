// wang tiles - 2 corners

function tile_w2c(size, mask, seed) =
    let(
		rows = size[1], 
		columns = size[0],
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
		  8    1
		  . － . 
		  |    | 
		  . － .
		  4    2
		*/
		tiles = [
			for(y = y_range)
			let(my = m[y])
				for(x = x_range)
				if(my[x] == 1)
					[x, y, 
						(corners[(y + 1) % rows][(x + 1) % columns] == 1 ? 1 : 0) +
						(corners[y][(x + 1) % columns] == 1 ? 2 : 0) +
						(corners[y][x] == 1 ? 4 : 0) +
						(corners[(y + 1) % rows][x] == 1 ? 8 : 0)
					]
		]
	)
	tiles;