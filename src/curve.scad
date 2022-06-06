/**
* crystal_ball.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-curve.html
*
**/ 

use <_impl/_catmull_rom_spline.scad>

function curve(t_step, points, tightness = 0) = 
    let(leng = len(points))
    [
        each [
            for(i = [0:leng - 4])
            let(pts = _catmull_rom_spline_4pts(t_step, [for(j = [i:i + 3]) points[j]], tightness))
                for(i = [0:len(pts) - 2]) pts[i]    
        ],
        points[leng - 2]
    ];