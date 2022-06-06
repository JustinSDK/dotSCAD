include <_impl/_mz_cube_constants.scad>

function mz_cube_get(cell, query) = 
    let(
        i = search(query, [
            ["x", 0],
            ["y", 1],
            ["z", 2],
            ["t", 3]
 	    ])[0]
    )
    i != 3 ? cell[i] : CELL_TYPE[cell[i]];