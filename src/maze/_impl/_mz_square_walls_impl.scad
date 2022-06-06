use <_mz_square_comm.scad>

function _square_walls(cell, cell_width) = 
    let(loc = [cell.x, cell.y] * cell_width)
    [
        if(top_wall(cell) || top_right_wall(cell)) each [[0, cell_width] + loc, [cell_width, cell_width] + loc],
        if(right_wall(cell) || top_right_wall(cell)) each [[cell_width, cell_width] + loc, [cell_width, 0] + loc]
    ]; 
