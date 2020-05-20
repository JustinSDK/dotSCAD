/**
* vx_cylinder.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_cylinder.html
*
**/ 

use <_impl/_vx_cylinder_impl.scad>; 
use <../util/sort.scad>;
use <../util/dedup.scad>;

function vx_cylinder(r, h, filled = false, thickness = 1) =
    let(all = _vx_cylinder_impl(r, h, filled, thickness))
    dedup(sort(all, by = "vt"), sorted = true);