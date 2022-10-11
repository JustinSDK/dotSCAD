/**
* mz_square_walls.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_square_walls.html
*
**/

use <_impl/_mz_square_walls_impl.scad>

function mz_square_walls(cells, rows, columns, cell_width, left_border = true, bottom_border = true) = 
    let(
        left_walls = echo("mz_square_walls is deprecated. use maze/mz_squarewalls instead.") left_border ? [for(y = [0:rows - 1]) [[0, cell_width * (y + 1)], [0, cell_width * y]]] : [],
        buttom_walls = bottom_border ? [for(x = [0:columns - 1]) [[cell_width * x, 0], [cell_width * (x + 1), 0]]] : []
    )
     concat(
        [
            for(cell = cells) 
            let(wall_pts = _square_walls(cell, cell_width))
            if(wall_pts != []) 
            len(wall_pts) == 4 ? [wall_pts[0], wall_pts[1], wall_pts[3]]: wall_pts
        ]
        , left_walls, buttom_walls
    );