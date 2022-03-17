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
use <mz_square_initialize.scad>;
use <mz_square_get.scad>;
use <../util/sort.scad>;
use <../util/dedup.scad>;

function mz_hamiltonian(rows, columns, start = [0, 0], init_cells, seed) =
    let(
        r = is_undef(init_cells) ? rows : len(init_cells),
        c = is_undef(init_cells) ? columns : len(init_cells[0]),
        cells = mz_square_cells(
            r, c,
            init_cells = init_cells,
            start = start,
            seed = seed
        ),
        all = concat(
            [
                for(cell = cells)
                let(
                    x = cell.x,
                    y = cell.y,
                    type = mz_square_get(cell, "t")
                )
                each if(type == "TOP_WALL") _mz_hamiltonian_top(x, y) else
                     if(type == "RIGHT_WALL") _mz_hamiltonian_right(x, y) else
                     if(type == "TOP_RIGHT_WALL") _mz_hamiltonian_top_right(x, y) else 
                     if(type == "MASK") _mz_hamiltonian_mask(x, y)
                     
            ],
            [for(x = [0:c * 2 - 1]) [x, 0]],
            [for(y = [0:r * 2 - 1]) [0, y]]
        ),
        dot_pts = dedup(sort(all, by = "vt"))
    )
    _mz_hamiltonian_travel(dot_pts, start * 3, r * c * 4);