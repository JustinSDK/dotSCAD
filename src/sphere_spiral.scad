/**
* sphere_spiral.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sphere_spiral.html
*
**/ 

use <ptf/ptf_rotate.scad>

function sphere_spiral(radius, za_step, z_circles = 1, begin_angle = 0, end_angle = 0, vt_dir = "SPI_DOWN", rt_dir = "CT_CLK") = 
    let(
        a_end = 90 * z_circles - end_angle,
        p = [radius, 0, 0],
        ya_base = vt_dir == "SPI_DOWN" ? -90 : 90,
        za_sign = rt_dir == "CT_CLK" ? 1 : -1
    )
    [
        for(a = begin_angle; a <= a_end; a = a + za_step) 
        let(ra = [0, ya_base + 2 * a / z_circles, za_sign * a])
        [ptf_rotate(p, ra), ra]
    ];