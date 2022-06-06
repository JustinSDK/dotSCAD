/**
* vx_curve.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_curve.html
*
**/ 

use <_impl/_vx_curve_impl.scad>
use <../util/dedup.scad>

include <../__comm__/_pt2_hash.scad>
include <../__comm__/_pt3_hash.scad>

function vx_curve(points, tightness = 0) = 
    let(leng = len(points))
    dedup([
        each [
            for(i = [0:leng - 4])
                let(
                    pts = _vx_catmull_rom_spline_4pts([for(j = [i:i + 3]) points[j]], tightness)
                )
                for(i = [0:len(pts) - 2]) pts[i]    
        ],
        points[leng - 2]
    ], hash = len(points[0]) == 2 ? _pt2_hash : _pt3_hash);