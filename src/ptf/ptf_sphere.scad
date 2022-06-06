/**
* ptf_sphere.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_sphere.html
*
**/ 

use <ptf_rotate.scad>

function ptf_sphere(size, point, radius, angle = [180, 360]) =
    let(
        z = is_undef(point.z) ? 0 : point.z, 
        rza = angle[0] / size.y * point.y
    )
    ptf_rotate(
        (radius + z) * [cos(rza), sin(rza), 0], 
        [90 - angle[1] / size.x * point.x, 90, 0]
    );