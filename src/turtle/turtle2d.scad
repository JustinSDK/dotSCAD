/**
* turtle2d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-turtle2d.html
*
**/ 

use <_impl/_turtle2d_impl.scad>

function turtle2d(cmd, arg1, arg2, arg3) = 
    _turtle2d_impl(cmd, arg1, arg2, arg3);
