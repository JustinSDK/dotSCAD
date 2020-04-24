/**
* ptf_x_twist.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_x_twist.html
*
**/ 

use <ptf_rotate.scad>;

function ptf_x_twist(size, point, angle) =
    let(
        xlen = size[0],
        ylen = size[1],
        y_offset = ylen / 2,
        a_step = angle / xlen,
        y_centered = [point[0], point[1], is_undef(point[2]) ? 0 : point[2]] + [0, -y_offset, 0]
    )
    ptf_rotate(y_centered, [point[0] * a_step, 0, 0]) + [0, y_offset, 0];