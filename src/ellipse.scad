
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

module ellipse(axes) {
    frags = $fn > 0 ? 
        ($fn >= 3 ? $fn : 3) : 
        max(min(360 / $fa, axes[0] * 6.28318 / $fs), 5);    
    
    step_a = 360 / frags;
    polygon(
        [
            for(a = [0:step_a:360 - step_a]) 
                [axes[0] * cos(a), axes[1] * sin(a)]
        ]
    );
}