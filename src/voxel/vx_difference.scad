/**
* vx_difference.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_difference.html
*
**/ 

use <../util/set/hashset.scad>;
use <../util/set/hashset_has.scad>;
use <../__comm__/_pt3_hash.scad>;

function vx_difference(points1, points2) =
    let(
        hash = function(p) _pt3_hash(p),
        set = hashset(points2, hash = hash)
    )
    [for(p = points1) if(!hashset_has(set, p, hash = hash)) p];