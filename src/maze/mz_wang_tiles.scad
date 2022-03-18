/**
* mz_wang_tiles.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_wang_tiles.html
*
**/

use <../__comm__/_pt2_hash.scad>;
use <_impl/_mz_wang_tiles_impl.scad>;
use <mz_square_cells.scad>;
use <mz_square_get.scad>;
use <../util/sort.scad>;
use <../util/set/hashset.scad>;
use <../util/set/hashset_elems.scad>;

function mz_wang_tiles(rows, columns, start = [0, 0], init_cells, seed) =
    let(
        cells = mz_square_cells(  
            rows, columns,
            init_cells = init_cells,
            seed = seed
        ),
        all = concat(
            [
                for(cell = cells)
                let(
                    x = cell.x,
                    y = cell.y,
                    type = mz_square_get(cell, "t"),
                    pts = type == "TOP_WALL" ? _mz_wang_tiles_top(x, y) :
                          type == "RIGHT_WALL" ? _mz_wang_tiles_right(x, y) :
                          type == "TOP_RIGHT_WALL"  || type == "MASK" ? _mz_wang_tiles_top_right(x, y) : []
                )
                each pts
            ],
            [for(x = [0:columns - 1]) [x * 2 + 1, 0]],
            [for(y = [0:rows - 1]) [0, y * 2 + 1]]
        ),
        dot_pts = sort(hashset_elems(hashset(all, hash = function(p) _pt2_hash(p))), by = "vt")
    )
    [
        for(y = [0:rows - 1], x = [0:columns - 1])
            [x, y, _mz_wang_tile_type(dot_pts, x, y)]
    ];