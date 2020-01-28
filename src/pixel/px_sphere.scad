/**
* px_sphere.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-px_sphere.html
*
**/ 

function px_sphere(radius, filled = false, thickness = 1) = 
    let(range = [-radius: radius - 1])
    filled ? [
        for(z = range)
            for(y = range)        
               for(x = range)
                   let(v = [x, y, z])
                   if(norm(v) < radius) v
    ] :
    let(ishell = radius * radius - 2 * thickness * radius)
    [
        for(z = range)
            for(y = range)        
               for(x = range)
                   let(
                       v = [x, y, z],
                       leng = norm(v)
                   )
                   if(leng < radius && (leng * leng) > ishell) v    
    ];
    