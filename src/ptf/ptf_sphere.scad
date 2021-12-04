/**
* ptf_sphere.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_sphere.html
*
**/ 

use <ptf_rotate.scad>;

function ptf_sphere(size, point, radius, angle = [180, 360]) =
    let(
        z = is_undef(point.z) ? 0 : point.z,
        za = angle[0],  
        xa = angle[1], 
        za_step = za / size.y,
        rza = za_step * point.y,
        rzpt = [(radius + z) * cos(rza), (radius + z) * sin(rza), 0],       
        rxpt = ptf_rotate(rzpt, [90 - xa / size.x * point.x, 90, 0])   
    )
    rxpt;