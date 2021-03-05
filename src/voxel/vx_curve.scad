/**
* vx_curve.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_curve.html
*
**/ 

use <_impl/_vx_curve_impl.scad>;
use <../util/dedup.scad>;

function vx_curve(points, tightness = 0) = 
    let(
        leng = len(points),
        pts = concat(
            [
                for(i = [0:leng - 4])
                    let(
                        pts = _vx_catmull_rom_spline_4pts([for(j = [i:i + 3]) points[j]], tightness)
                    )
                    for(i = [0:len(pts) - 2]) pts[i]    
            ],
            [points[leng - 2]]
        )
    )
    dedup(pts);