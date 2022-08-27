/**
* mz_square_cells.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_square_cells.html
*
**/

use <_impl/_mz_square_cells_impl.scad>
use <mz_square_initialize.scad>

function mz_square_cells(rows, columns, start = [0, 0], init_cells, x_wrapping = false, y_wrapping = false, seed) = 
    let(
        init_undef = is_undef(init_cells),
        mz = init_undef ? mz_square_initialize(rows, columns) : init_cells,
        r = len(mz),
        c = len(mz[0]),
        directions = function(x, y, cells, seed) rand_dirs(x, y, cells, seed),
        generated = go_maze( 
            start.x, 
            start.y,   
            mz,  
            r, c, 
            x_wrapping, 
            y_wrapping, 
            directions, 
            seed
        )
    )
    [for(row = generated) each row];
