/**
* shape_ellipse.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_ellipse.html
*
**/

use <__comm__/__frags.scad>

function shape_ellipse(axes) =
    let(
        axes0 = axes[0],
        axes1 = axes[1],
        frags = __frags(axes0),
        step_a = 360 / frags
    ) 
    [
        for(a = [each [0:frags - 1]] * step_a) 
        [axes0 * cos(a), axes1 * sin(a)]
    ];