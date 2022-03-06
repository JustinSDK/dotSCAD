/**
* mz_hex_walls.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_hex_walls.html
*
**/

use <_impl/_mz_hex_walls.scad>;

function mz_hex_walls(cells, rows, columns, cell_radius, left_border = true, bottom_border = true) = 
    let(
        walls = [for(cell = cells, wall = _build_cell(cell_radius, cell)) wall],
        left_pair_walls = left_border ? [
            for(y = [0:rows - 1]) 
            let(
                cell_p = _cell_position(cell_radius, 0, y),
                walls1 = _top_left(cell_radius),
                walls2 = _bottom_left(cell_radius)
            )
            [
                 [walls1[0] + cell_p, walls1[1] + cell_p], 
                 [walls2[0] + cell_p, walls2[1] + cell_p]
            ]   
        ] : [],
        left_border_walls = [for(pair = left_pair_walls) each pair],
        bottom_pair_walls = bottom_border ? [
            for(x = [0:columns - 1]) 
            let(
                cell_p = _cell_position(cell_radius, x, 0),
                walls1 = _bottom(cell_radius),
                walls2 = [
                    for(pair = (x % 2 == 0 ? [_bottom_left(cell_radius), _bottom_right(cell_radius)] : []))
                    each pair
                ]
            )
            walls2 == [] ? 
                [
                    [walls1[0] + cell_p, walls1[1] + cell_p]
                ] :
                [
                    [walls1[0] + cell_p, walls1[1] + cell_p], 
                    [walls2[0] + cell_p, walls2[1] + cell_p]
                ]   
        ] : [],
        bottom_border_walls = [for(pair = bottom_pair_walls) each pair]
    )
    concat(walls, left_border_walls, bottom_border_walls);