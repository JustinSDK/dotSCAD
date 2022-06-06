/**
* shape_arc.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_arc.html
*
**/ 

use <__comm__/__frags.scad>
use <__comm__/__ra_to_xy.scad>
use <__comm__/__edge_r.scad>

function shape_arc(radius, angle, width, width_mode = "LINE_CROSS") =
    let(
        w_offset = width_mode == "LINE_CROSS"  ? [width / 2, -width / 2] : 
                   width_mode == "LINE_INWARD" ? [0, -width] : [width, 0],
        a_step = 360 / __frags(radius),
        half_a_step = a_step / 2,
        angles = is_num(angle) ? [0, angle] : angle,
        a0 = angles[0],
        a1 = angles[1],
        m = floor(a0 / a_step) + 1,
        n = floor(a1 / a_step),
        r_outer = radius + w_offset[0],
        r_inner = radius + w_offset[1],
        points = [
            // outer arc path
            __ra_to_xy(__edge_r_begin(r_outer, a0, a_step, m), a0),
            each [for(i = m; i <= n; i = i + 1)  __ra_to_xy(r_outer, a_step * i)],
            if(a1 != a_step * n) each [
                __ra_to_xy(__edge_r_end(r_outer, a1, a_step, n), a1),
            // inner arc path
                __ra_to_xy(__edge_r_end(r_inner, a1, a_step, n), a1)
            ],
            // inner arc path
            each [
                for(i = m; i <= n; i = i + 1)
                __ra_to_xy(r_inner, a_step * (n + m - i))

            ],
            __ra_to_xy(__edge_r_begin(r_inner, a0, a_step, m), a0)
        ]
    ) points;