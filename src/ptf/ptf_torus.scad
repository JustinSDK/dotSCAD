/**
* ptf_torus.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_torus.html
*
**/ 

use <ptf_rotate.scad>

function ptf_torus(size, point, radius, angle = [360, 360], twist = 0) =
    let(
        R = radius[0],
        r = radius[1] + (is_undef(point.z) ? 0 : point.z),
        A = angle[0],
        a = angle[1],
        ya = 180 - point.x * a / size.x + twist / size.y * point.y
    ) 
    ptf_rotate(
        [r * cos(ya) + R + r, 0, r * sin(ya)], 
        A / size.y * point.y
    );