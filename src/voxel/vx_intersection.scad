/**
* vx_intersection.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_intersection.html
*
**/ 

use <../util/sort.scad>;
use <../util/has.scad>;

function vx_intersection(points1, points2) =
    let(
        leng1 = len(points1),
        leng2 = len(points2),
        pts_pair = leng1 > leng2 ? [points1, points2] : [points2, points1],
        sorted = sort(pts_pair[1], by = "vt")
    )
    [for(p = pts_pair[0]) if(has(sorted, p, sorted = true)) p];