/**
* ptf_sphere.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_sphere.html
*
**/ 

use <ptf/ptf_rotate.scad>;

function ptf_sphere(size, point, radius, angle = [180, 360]) =
    let(
        x = point[0],
        y = point[1],
        z = is_undef(point[2]) ? 0 : point[2],
        za = angle[0],  
        xa = angle[1], 
        xlen = size[0],
        ylen = size[1],
        za_step = za / ylen,
        rza = za_step * y,
        rzpt = [(radius + z) * cos(rza), (radius + z) * sin(rza), 0],       
        rxpt = ptf_rotate(rzpt, [90 - xa / xlen * x, 90, 0])   
    )
    rxpt;