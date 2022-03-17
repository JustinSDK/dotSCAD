/**
* vx_union.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_union.html
*
**/ 

use <../__comm__/_pt3_hash.scad>;
use <../util/set/hashset.scad>;
use <../util/set/hashset_elems.scad>;

function vx_union(points1, points2) = 
    hashset_elems(
        hashset(concat(points1, points2), hash = function(p) _pt3_hash(p))
    );