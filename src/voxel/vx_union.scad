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
use <../util/dedup.scad>;

function vx_union(points1, points2) = 
    let(
        pts = concat(points1, points2),
        number_of_buckets = ceil(sqrt(len(pts))),
        hash = _pt3_hash(number_of_buckets)
    )
    dedup(pts, hash = hash, number_of_buckets = number_of_buckets);