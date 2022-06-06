/**
* vx_cylinder.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_cylinder.html
*
**/ 

use <_impl/_vx_cylinder_impl.scad> 

function vx_cylinder(r, h, filled = false, thickness = 1) =
    _vx_cylinder_impl(r, h, filled, thickness);