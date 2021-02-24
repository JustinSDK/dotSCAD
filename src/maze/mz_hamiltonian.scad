/**
* mz_hamiltonian.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_hamiltonian.html
*
**/

use <_impl/_mz_hamiltonian_impl.scad>;
use <mz_square_cells.scad>;
use <mz_square_get.scad>;
use <../util/sort.scad>;
use <../util/dedup.scad>;

function mz_hamiltonian(rows, columns, start = [0, 0], seed) =
    let(
        cells = mz_square_cells(  
            rows, columns,
            seed = seed
        ),
        all = concat(
            [
                for(cell = cells)
                let(
                    x = mz_square_get(cell, "x"),
                    y = mz_square_get(cell, "y"),
                    type = mz_square_get(cell, "t"),
                    pts = type == "TOP_WALL" ? _mz_hamiltonian_top(x, y) :
                          type == "RIGHT_WALL" ? _mz_hamiltonian_right(x, y) :
                          type == "TOP_RIGHT_WALL" ? _mz_hamiltonian_top_right(x, y) : []
                )
                each pts
            ],
            [for(x = [0:columns * 2 - 1]) [x, 0]],
            [for(y = [0:rows * 2 - 1]) [0, y]]
        ),
        dot_pts = dedup(sort(all, by = "vt"), sorted = true)
    )
    _mz_hamiltonian_travel(dot_pts, start, rows * columns * 4);