/**
* ptf_x_twist.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_x_twist.html
*
**/ 

use <ptf_rotate.scad>

function ptf_x_twist(size, point, angle) =
    let(
        y_offset = size.y / 2,
        y_centered = [point.x, point.y, is_undef(point.z) ? 0 : point.z] + [0, -y_offset, 0]
    )
    ptf_rotate(y_centered, [point.x * angle / size.x, 0, 0]) + [0, y_offset, 0];