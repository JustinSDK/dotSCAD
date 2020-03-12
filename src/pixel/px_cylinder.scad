/**
* px_cylinder.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-px_cylinder.html
*
**/ 

use <pixel/_impl/_px_cylinder_impl.scad>; 
use <util/dedup.scad>;

function px_cylinder(r, h, filled = false, thickness = 1) =
    dedup(_px_cylinder_impl(r, h, filled, thickness));