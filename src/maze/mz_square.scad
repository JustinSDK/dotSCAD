/**
* mz_square.scad
*
* @copyright Justin Lin, 2022
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_square.html
*
**/

use <_impl/_mz_square_cells_impl.scad>
use <mz_square_initialize.scad>

function mz_square(rows, columns, start = [0, 0], init_cells, x_wrapping = false, y_wrapping = false, seed, directions) = 
    let(
        init_undef = is_undef(init_cells),
        mz = init_undef ? mz_square_initialize(rows, columns) : init_cells
    )
    go_maze( 
        start.x, 
        start.y,   
        mz,  
        len(mz),  
        len(mz[0]), 
        x_wrapping, 
        y_wrapping, 
        seed,
        is_undef(directions) ? function(x, y, cells, seed) rand_dirs(x, y, cells, seed) : directions
    );
