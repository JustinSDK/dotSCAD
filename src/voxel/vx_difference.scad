/**
* vx_difference.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_difference.html
*
**/ 

use <../util/sort.scad>;
use <../util/has.scad>;

function vx_difference(points1, points2) =
    let(sorted = sort(points2, by = "vt"))
    [for(p = points1) if(!has(sorted, p, sorted = true)) p];