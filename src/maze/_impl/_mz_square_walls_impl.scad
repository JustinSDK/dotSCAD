use <_mz_comm.scad>;

function _square_walls(block, block_width) = 
    let(
        loc = [get_x(block) - 1, get_y(block) - 1] * block_width,
        top = top_wall(block) || top_right_wall(block) ? [[0, block_width] + loc, [block_width, block_width] + loc] : [],
        right = right_wall(block) || top_right_wall(block) ? [[block_width, block_width] + loc, [block_width, 0] + loc] : []
    )
    concat(top, right); 
