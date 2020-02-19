use <experimental/_impl/_mz_walls_impl.scad>;

function mz_walls(blocks, rows, columns, block_width, left_border = true, bottom_border = true) = 
    let(
        left_walls = left_border ? [for(y = [0:rows - 1]) [[0, block_width * (y + 1)], [0, block_width * y]]] : [],
        buttom_walls = bottom_border ? [for(x = [0:columns - 1]) [[block_width * x, 0], [block_width * (x + 1), 0]]] : []
    )
     concat(
        [
            for(block = blocks) 
            let(pts = block_walls(block, block_width))
            if(pts != []) pts
        ]
        , left_walls, buttom_walls
    );