/**
* shape_ellipse.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_ellipse.html
*
**/

include <__private__/__frags.scad>;

function shape_ellipse(axes) =
    let(
        frags = __frags(axes[0]),
        step_a = 360 / frags,
        shape_pts = [
            for(a = [0:step_a:360 - step_a]) 
                [axes[0] * cos(a), axes[1] * sin(a)]
        ]
    ) shape_pts;