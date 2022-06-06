/**
* bezier_surface.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-bezier_surface.html
*
**/ 

use <bezier_curve.scad>
use <matrix/m_transpose.scad>

function bezier_surface(t_step, ctrl_pts) =
    let(
        _ = echo("`bezier_surface` is deprecated since 3.1. Use `sf_splines` instead."),
        leng_ctrl_pts = len(ctrl_pts),
        pts =  [
        for(i = 0; i < leng_ctrl_pts; i = i + 1)
            bezier_curve(t_step, ctrl_pts[i])
        ],
        leng_pts0 = len(pts[0]),
        leng_pts = len(pts)
    ) 
    m_transpose([for(x = 0; x < leng_pts0; x = x + 1)
        bezier_curve(
            t_step,  
            [for(y = 0; y < leng_pts; y = y + 1) pts[y][x]]
        ) 
    ]);