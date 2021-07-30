use <util/choose.scad>;

function tile_truchet(size, mask, seed) =
    let(
        rows = size[1], 
        columns = size[0],
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
	is_undef(seed) ? [
        for(y = y_range)
            for(x = x_range) 
            if(m[y][x] == 1)
                [x, y, choose(nums)]
        
    ] : [
        for(y = y_range)        
            for(x = x_range) 
            if(m[y][x] == 1)
                [x, y, choose(nums, x + y * rows + seed)]
    ];