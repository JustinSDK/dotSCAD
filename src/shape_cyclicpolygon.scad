/**
* shape_cyclicpolygon.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_cyclicpolygon.html
*
**/

use <__comm__/__frags.scad>;
use <__comm__/__pie_for_rounding.scad>;

function shape_cyclicpolygon(sides, circle_r, corner_r) =
    let(
        frag_a = 360 / sides,
        corner_a = (180 - frag_a),
        corner_circle_a = 180 - corner_a,
        half_corner_circle_a = corner_circle_a / 2,
        corner_circle_center = circle_r - corner_r / sin(corner_a / 2),
        first_corner = [
            for(
                    pt = __pie_for_rounding(
                        corner_r, 
                        -half_corner_circle_a, 
                        half_corner_circle_a, 
                        __frags(corner_r) * corner_circle_a / 360
                    )
               )
               [pt[0] + corner_circle_center, pt[1]]
        ]

    )
    concat(
        first_corner, 
        [
            for(side = 1; side < sides; side = side + 1)
                for(pt = first_corner)
                    let(
                        a = frag_a * side,
                        x = pt[0],
                        y = pt[1],
                        sina = sin(a),
                        cosa = cos(a)
                    )
                    [
                        x * cosa - y * sina,
                        x * sina + y * cosa
                    ]
        ]
    );