module 2_edge_wang_tiles(rows, columns, tile_width) {
	edges = [
		for(y = [0:rows])
		[
			for(x = [0:columns]) 
			[round(rands(0, 1, 1)[0]), round(rands(0, 1, 1)[0])]
		]
	];

	for(y = [0:rows - 1]) {
		for(x = [0:columns - 1]) {
			i = (edges[y + 1][x][0] == 1 ? 1 : 0) +
			(edges[y][x + 1][1] == 1 ? 2 : 0) +
			(edges[y][x][0] == 1 ? 4 : 0) +
			(edges[y][x][1] == 1 ? 8 : 0);
			translate([x, y] * tile_width)
				children(i);
		}
	}
}