/**
* arc_shape.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-arc_path.html
*
**/ 

use <__comm__/__frags.scad>
use <__comm__/__ra_to_xy.scad>
use <__comm__/__edge_r.scad>

function arc_path(radius, angle) =
    let(
        a_step = 360 / __frags(radius),
        angles = is_num(angle) ? [0, angle] : angle,
        a0 = angles[0],
        a1 = angles[1],
        m = floor(a0 / a_step) + 1,
        n = floor(a1 / a_step),
        points = [
            __ra_to_xy(__edge_r_begin(radius, a0, a_step, m), a0),
            if(m <= n) each [for(i = m; i <= n; i = i + 1) __ra_to_xy(radius, a_step * i)],
            if(a1 != a_step * n) __ra_to_xy(__edge_r_end(radius, a1, a_step, n), a1)
        ]
    ) points;