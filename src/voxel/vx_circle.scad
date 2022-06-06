/**
* vx_circle.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_circle.html
*
**/ 

use <_impl/_vx_circle_impl.scad>
use <../util/set/hashset.scad>
use <../util/set/hashset_elems.scad>

include <../__comm__/_pt2_hash.scad>

function vx_circle(radius, filled = false) = 
    hashset_elems(
        hashset(_vx_circle_impl(radius, filled), hash = _pt2_hash)
    );