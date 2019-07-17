/**
* arc_shape.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-arc_path.html
*
**/ 

include <__comm__/__frags.scad>;
include <__comm__/__ra_to_xy.scad>;
include <__comm__/__edge_r.scad>;

function arc_path(radius, angle) =
    let(
        frags = __frags(radius),
        a_step = 360 / frags,
        angles = is_num(angle) ? [0, angle] : angle,
        m = floor(angles[0] / a_step) + 1,
        n = floor(angles[1] / a_step),
        points = concat([__ra_to_xy(__edge_r_begin(radius, angles[0], a_step, m), angles[0])],
            m > n ? [] : [
                for(i = m; i <= n; i = i + 1)
                    __ra_to_xy(radius, a_step * i)
            ],
            angles[1] == a_step * n ? [] : [__ra_to_xy(__edge_r_end(radius, angles[1], a_step, n), angles[1])])
    ) points;