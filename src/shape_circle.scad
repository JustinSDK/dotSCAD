/**
* shape_circle.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_circle.html
*
**/

use <__comm__/__frags.scad>;

function shape_circle(radius, n) =
    let(
        _frags = __frags(radius),
        step_a = 360 / _frags,
        end = (is_undef(n) || n > _frags) ? _frags - 1: n - 1
    )
    [for(a = [0:step_a:end * step_a]) [radius * cos(a), radius * sin(a)]];
