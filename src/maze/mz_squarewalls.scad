/**
* mz_squarewalls.scad
*
* @copyright Justin Lin, 2022
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_squarewalls.html
*
**/

use <_impl/_mz_square_walls_impl.scad>

function mz_squarewalls(cells, cell_width, left_border = true, bottom_border = true) = 
    let(
        rows = len(cells),
        columns = len(cells[0]),
        left_walls = left_border ? [for(y = [0:rows - 1]) [[0, cell_width * (y + 1)], [0, cell_width * y]]] : [],
        buttom_walls = bottom_border ? [for(x = [0:columns - 1]) [[cell_width * x, 0], [cell_width * (x + 1), 0]]] : []
    )
     concat(
        [
            for(row = cells, cell = row) 
            let(wall_pts = _square_walls(cell, cell_width))
            if(wall_pts != []) 
            len(wall_pts) == 4 ? [wall_pts[0], wall_pts[1], wall_pts[3]]: wall_pts
        ]
        , left_walls, buttom_walls
    );