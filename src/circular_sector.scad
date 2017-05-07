/**
* circular_sector.scad
*
* Creates a circular sector. You can pass a 2 element vector to define the central angle. Its $fa, $fs and $fn parameters are consistent with the circle module.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-circular_sector.html
*
**/

include <__private__/__frags.scad>;

module circular_sector(radius, angles) {
    frags = __frags(radius);
    
    r = radius / cos(180 / frags);
    step = -360 / frags; 

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius);
        polygon(points);
    }
}