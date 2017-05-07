
/**
* ellipse.scad
*
* Creates an ellipse.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-ellipse.html
*
**/

include <__private__/__frags.scad>;

module ellipse(axes) { 
    step_a = 360 / __frags(axes[0]);
    polygon(
        [
            for(a = [0:step_a:360 - step_a]) 
                [axes[0] * cos(a), axes[1] * sin(a)]
        ]
    );
}