/**
* shape_circle.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_circle.html
*
**/

use <__comm__/__frags.scad>;

function shape_circle(radius, n) =
    let(
        _frags = __frags(radius),
        step_a = 360 / _frags,
        end_a = 360 - step_a * ((is_undef(n) || n > _frags) ? 1 : _frags - n + 1)
    )
    [
        for(a = 0; a <= end_a; a = a + step_a)
            [radius * cos(a), radius * sin(a)]
    ];
