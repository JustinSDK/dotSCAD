/**
* mz_square_get.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_square_get.html
*
**/

include <_impl/_mz_square_cell_constants.scad>

function mz_square_get(cell, query) = 
    let(
        i = search(query, [
            ["x", 0],
            ["y", 1],
            ["t", 2]
 	    ])[0]
    )
    i != 2 ? cell[i] : CELL_TYPE[cell[i]];