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
        xlen = size[0],
        // ignored
        // ylen = size[1],
        y = point[0],
        z = point[1],
        x = is_undef(point[2]) ? 0 : point[2],
        a_step = angle / xlen,
        a = a_step * y,
        r = radius + x
    )
    [r * cos(a), r * sin(a), z];