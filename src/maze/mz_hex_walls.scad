/**
* mz_hex_walls.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_hex_walls.html
*
**/

use <_impl/_mz_hex_walls.scad>

function mz_hex_walls(cells, rows, columns, cell_radius, left_border = true, bottom_border = true) = 
    echo("mz_hex_walls is deprecated. use maze/mz_hexwalls instead.")
    [
        each [for(cell = cells, wall = _build_cell(cell_radius, cell)) wall],

        if(left_border) each [
            for(y = [0:rows - 1]) 
            let(
                cell_p = _cell_position(cell_radius, 0, y),
                walls1 = _build_top_left(cell_radius),
                walls2 = _build_bottom_left(cell_radius)
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
                walls1 = _build_bottom(cell_radius)
            )
            each [
                [walls1[0] + cell_p, walls1[1] + cell_p], 
                if(x % 2 == 0)
                let(walls2 = [each _build_bottom_left(cell_radius), each _build_bottom_right(cell_radius)])
                [walls2[0] + cell_p, walls2[1] + cell_p]
            ]
        ]
    ];
