/**
* ptf_bend.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_bend.html
*
**/ 

function ptf_bend(size, point, radius, angle) = 
    let(
        // ignored: size.y,
        x = is_undef(point.z) ? 0 : point.z,
        a = angle / size.x * point.x,
        r = radius + x
    )
    [r * cos(a), r * sin(a), point.y];