use <experimental/_impl/_mz_comm.scad>;

function block_walls(block, block_width) = 
    let(
        loc = [get_x(block) - 1, get_y(block) - 1] * block_width,
        upper = upper_wall(block) || upper_right_wall(block) ? [[0, block_width] + loc, [block_width, block_width] + loc] : [],
        right = right_wall(block) || upper_right_wall(block) ? [[block_width, block_width] + loc, [block_width, 0] + loc] : []
    )
    concat(upper, right); 
