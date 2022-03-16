/**
* mz_hexwalls.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_hexwalls.html
*
**/

use <_impl/_mz_hex_walls.scad>;
use <../util/find_index.scad>;

function mz_hexwalls(cells, cell_radius, left_border = true, bottom_border = true) = 
    let(
        columns = find_index(cells, function(cell) cell.y != 0),
        rows = len(cells) / columns
    )
    [
        each [for(cell = cells, wall = _build_cell(cell_radius, cell)) wall],

        if(left_border) each [
            for(y = [0:rows - 1]) 
            let(
                cell_p = _cell_position(cell_radius, 0, y),
                walls1 = _top_left(cell_radius),
                walls2 = _bottom_left(cell_radius)
            )
            each [
                [walls1[0] + cell_p, walls1[1] + cell_p], 
                [walls2[0] + cell_p, walls2[1] + cell_p]
            ]   
        ],

        if(bottom_border) each [
            for(x = [0:columns - 1]) 
            let(
                cell_p = _cell_position(cell_radius, x, 0),
                walls1 = _bottom(cell_radius)
            )
            each [
                [walls1[0] + cell_p, walls1[1] + cell_p], 
                if(x % 2 == 0)
                let(walls2 = [each _bottom_left(cell_radius), each _bottom_right(cell_radius)])
                [walls2[0] + cell_p, walls2[1] + cell_p]
            ]
        ]
    ];
