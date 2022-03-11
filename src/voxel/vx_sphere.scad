/**
* vx_sphere.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_sphere.html
*
**/ 

function vx_sphere(radius, filled = false, thickness = 1) = 
    let(range = [-radius: radius - 1])
    filled ? [
        for(z = range, y = range, x = range)
        let(v = [x, y, z])
        if(v * v < radius ^ 2) v
    ] :
    let(ishell = radius * radius - 2 * thickness * radius)
    [
        for(z = range, y = range, x = range)
        let(
            v = [x, y, z],
            vv = v * v
        )
        if(vv < radius ^ 2 && vv > ishell) v    
    ];
    