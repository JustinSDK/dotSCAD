/**
* mz_square_cells.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_square_cells.html
*
**/

use <_impl/_mz_square_cells_impl.scad>;
use <mz_square_initialize.scad>;

function mz_square_cells(rows, columns, start = [0, 0], init_cells, x_wrapping = false, y_wrapping = false, seed) = 
    let(
        init_undef = is_undef(init_cells),
        mz = init_undef ? mz_square_initialize(rows, columns) : init_cells,
        rc = init_undef ? [rows, columns] : [len([for(cell = mz) if(cell.y == 0) undef]), len([for(cell = mz) if(cell.x == 0) undef])]
    )
    go_maze( 
        start.x, 
        start.y,   
        mz,  
        rc[0], rc[1], 
        x_wrapping, 
        y_wrapping, 
        seed
    );
