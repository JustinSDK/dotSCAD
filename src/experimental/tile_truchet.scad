use <util/choose.scad>

function tile_truchet(size, mask, seed) =
    let(
        rows = size[1], 
        columns = size[0],
		y_range = [0:rows - 1],
		x_range = [0:columns - 1],
        nums = [0, 1, 2, 3],
        ones = [for(x = x_range) 1],
		m = is_undef(mask) ? [
			for(y = y_range)
				ones
		] : [
			for(y = rows - 1; y > -1; y = y - 1)
            let(my = mask[y])
				[for(x = x_range) my[x]]
		]
	)
	is_undef(seed) ? [
        for(y = y_range)
        let(my = m[y])      
            for(x = x_range)  
            if(my[x] == 1)
                [x, y, choose(nums)]
        
    ] : [
        for(y = y_range)  
        let(my = m[y])      
            for(x = x_range) 
            if(my[x] == 1)
            [x, y, choose(nums, x + y * rows + seed)]
    ];