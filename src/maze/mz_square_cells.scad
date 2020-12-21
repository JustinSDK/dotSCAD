/**
* mz_square_cells.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-mz_square_cells.html
*
**/

use <_impl/_mz_cells_impl.scad>;
use <mz_square_initialize.scad>;

function mz_square_cells(rows, columns, start = [0, 0], init_cells, x_wrapping = false, y_wrapping = false, seed) = 
    go_maze( 
        start[0], start[1],   
        is_undef(init_cells) ? mz_square_initialize(rows, columns) : init_cells,  
        rows, columns, x_wrapping, y_wrapping, seed
    );
