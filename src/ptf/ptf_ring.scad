/**
* ptf_ring.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_ring.html
*
**/ 

use <ptf_rotate.scad>
use <ptf_y_twist.scad>

function ptf_ring(size, point, radius, angle = 360, twist = 0) = 
    let(twisted = ptf_y_twist(size, point, twist))
    ptf_rotate([radius + twisted.x, 0, twisted.z], angle / size.y * twisted.y);