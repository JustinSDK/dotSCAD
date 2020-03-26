/**
* ptf_y_twist.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_y_twist.html
*
**/ 

use <ptf/ptf_rotate.scad>;

function ptf_y_twist(size, point, angle) =
    let(
        xlen = size[0],
        ylen = size[1],
        x_offset = xlen / 2,
        a_step = angle / ylen,
        x_centered = [point[0], point[1], is_undef(point[2]) ? 0 : point[2]] + [-x_offset, 0, 0]
    )
    ptf_rotate(x_centered, [0, point[1] * a_step, 0]) + [x_offset, 0, 0];