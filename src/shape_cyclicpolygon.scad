/**
* shape_cyclicpolygon.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_cyclicpolygon.html
*
**/

use <__comm__/__frags.scad>
use <__comm__/__pie_for_rounding.scad>

function shape_cyclicpolygon(sides, circle_r, corner_r) =
    let(
        frag_a = 360 / sides,
        corner_a = 180 - frag_a,
        corner_circle_a = 180 - corner_a,
        half_corner_circle_a = corner_circle_a / 2,
        corner_circle_center = [circle_r - corner_r / sin(corner_a / 2), 0],
        first_corner = [
            for(
                pt = __pie_for_rounding(
                    corner_r, 
                    -half_corner_circle_a, 
                    half_corner_circle_a, 
                    __frags(corner_r) * corner_circle_a / 360
                )
            )
            pt + corner_circle_center
        ]

    )
    concat(
        first_corner, 
        [
            for(side = 1; side < sides; side = side + 1)
            let(
                a = frag_a * side,
                sina = sin(a),
                cosa = cos(a)
            )
            // for(pt = first_corner) [pt.x * cosa - pt.y * sina, pt.x * sina + pt.y * cosa]
            each first_corner * [[cosa,  sina], [-sina, cosa]]
        ]
    );