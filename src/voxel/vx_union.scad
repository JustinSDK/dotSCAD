/**
* vx_union.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_union.html
*
**/ 

use <collection/hashset.scad>;

function vx_union(points1, points2) =
    hashset_list(
        hashset(concat(points1, points2))
    );