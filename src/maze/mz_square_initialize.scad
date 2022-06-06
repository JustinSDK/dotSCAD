/**
* mz_square_initialize.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_square_initialize.html
*
**/

use <_impl/_mz_square_initialize.scad>

function mz_square_initialize(rows, columns, mask) = 
    is_undef(mask) ? _rc_maze(rows, columns) : _mz_mask(mask);