/**
* ptf_ring.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_ring.html
*
**/ 

use <ptf/ptf_rotate.scad>;
use <ptf/ptf_y_twist.scad>;

function ptf_ring(size, point, radius, angle = 360, twist = 0) = 
    let(
        yleng = size[1],
        a_step = angle / yleng,
        twisted = ptf_y_twist(size, point, twist)
    )
    ptf_rotate([radius + twisted[0], 0, twisted[2]], a_step * twisted[1]);