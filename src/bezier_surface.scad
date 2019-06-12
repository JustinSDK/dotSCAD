/**
* bezier_surface.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bezier_surface.html
*
**/ 

function bezier_surface(t_step, ctrl_pts) =
    let(pts =  [
        for(i = 0; i < len(ctrl_pts); i = i + 1)
            bezier_curve(t_step, ctrl_pts[i])
    ]) 
    [for(x = 0; x < len(pts[0]); x = x + 1)
        bezier_curve(t_step,  
                [for(y = [0:len(pts) - 1]) pts[y][x]]
        ) 
    ];