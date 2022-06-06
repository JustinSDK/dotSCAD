/**
* ptf_y_twist.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_y_twist.html
*
**/ 

use <ptf_rotate.scad>

function ptf_y_twist(size, point, angle) =
    let(
        x_offset = size.x / 2,
        x_centered = [point.x, point.y, is_undef(point.z) ? 0 : point.z] + [-x_offset, 0, 0]
    )
    ptf_rotate(x_centered, [0, point.y * angle / size.y, 0]) + [x_offset, 0, 0];