/**
* sphere_spiral.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sphere_spiral.html
*
**/ 

use <ptf/ptf_rotate.scad>;

function sphere_spiral(radius, za_step, z_circles = 1, begin_angle = 0, end_angle = 0, vt_dir = "SPI_DOWN", rt_dir = "CT_CLK") = 
    let(
        a_end = 90 * z_circles - end_angle
    )
    [
        for(a = begin_angle; a <= a_end; a = a + za_step) 
            let(
                ya = vt_dir == "SPI_DOWN" ? (-90 + 2 * a / z_circles) : (90 + 2 * a / z_circles),
                za = (rt_dir == "CT_CLK" ? 1 : -1) * a,
                ra = [0, ya, za]
            )
            [ptf_rotate([radius, 0, 0], ra), ra]
    ];