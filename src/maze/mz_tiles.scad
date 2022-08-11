/**
* mz_tiles.scad
*
* @copyright Justin Lin, 2022
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_tiles.html
*
**/

use <mz_square_get.scad>

function mz_tiles(cells, left_border = true, bottom_border = true) =
    let(
        rows = len(cells),
        columns = len(cells[0]),
        edges = [
            for(y = 0; y <= rows; y = y + 1)
            [
                for(x = 0; x <= columns; x = x + 1) 
                if(y == 0 && x == 0)
                    [0, 0]
                else if(y == 0)
                    let(type = mz_square_get(cells[rows - 1][x - 1], "t")) 
                    [
                        bottom_border ? 0 : type == "NO_WALL" || type == "RIGHT_WALL" ? 1 : 0, 
                        0
                    ]
                else if(x == 0)
                    let(type = mz_square_get(cells[y - 1][columns - 1], "t")) 
                    [
                        0, 
                        left_border ? 0 : type == "NO_WALL" || type == "TOP_WALL" ? 1 : 0
                    ]
                else
                    let(type = mz_square_get(cells[y - 1][x - 1], "t")) 
                    [
                        type == "NO_WALL" || type == "RIGHT_WALL" ? 1 : 0,
                        type == "NO_WALL" || type == "TOP_WALL"   ? 1 : 0
                    ]
            ]
        ],
        _mz_tile_type = function(edges, cx, cy)
            let(x = cx + 1, y = cy + 1)
            (edges[y][x][0] == 1     ? 1 : 0) +
            (edges[y][x][1] == 1     ? 2 : 0) +
            (edges[y - 1][x][0] == 1 ? 4 : 0) +
            (edges[y][x - 1][1] == 1 ? 8 : 0)
    )
    [
        for(y = [0:rows - 1], x = [0:columns - 1])
        [x, y, _mz_tile_type(edges, x, y)]
    ];