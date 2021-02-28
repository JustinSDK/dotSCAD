use <_mz_square_comm.scad>;

function _square_walls(cell, cell_width) = 
    let(
        loc = [get_x(cell), get_y(cell)] * cell_width,
        top = top_wall(cell) || top_right_wall(cell) ? [[0, cell_width] + loc, [cell_width, cell_width] + loc] : [],
        right = right_wall(cell) || top_right_wall(cell) ? [[cell_width, cell_width] + loc, [cell_width, 0] + loc] : []
    )
    concat(top, right); 
