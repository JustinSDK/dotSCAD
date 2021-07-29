// wang tiles - 2 edges

function tile_w2e(rows, columns, mask, seed) =
    let(
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
		],
		m = is_undef(mask) ? [
			for(y = [0:rows - 1])
				[for(x = [0:columns - 1]) 1]
		] : [
			for(y = rows - 1; y > -1; y = y - 1)
				[for(x = [0:columns - 1]) mask[y][x]]
		],
		/*
			1
			. － .
		8 |    | 2
			. － .
			4
		*/
		tiles = [
			for(y = [0:rows - 1])
				for(x = [0:columns - 1])
				if(m[y][x] == 1)
					[x, y, 
						(edges[y + 1][x][0] == 1 ? 1 : 0) +
						(edges[y][x + 1][1] == 1 ? 2 : 0) +
						(edges[y][x][0] == 1 ? 4 : 0) +
						(edges[y][x][1] == 1 ? 8 : 0)
					]
		]
	)
	tiles;