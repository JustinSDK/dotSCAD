/**
* vx_line.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_line.html
*
**/ 

use <_impl/_vx_line_impl.scad>

function vx_line(p1, p2) = _vx_line_impl(p1, p2);