/**
* vx_circle.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_circle.html
*
**/ 

use <_impl/_vx_circle_impl.scad>;
use <collection/hashset.scad>;
use <collection/hashset_list.scad>;

function vx_circle(radius, filled = false) = 
    let(all = _vx_circle_impl(radius, filled))
    hashset_list(
        hashset(all)
    );