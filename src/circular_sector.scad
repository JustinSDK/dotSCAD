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
    
    a_step = 360 / frags;
    
    m = floor(angles[0] / a_step) + 1;
    n = floor(angles[1] / a_step);
    
    points = concat(
        [[0, 0], radius * [cos(angles[0]), sin(angles[0])]],
        [
            for(i = [m:n]) 
                radius * [cos(a_step * i), sin(a_step * i)]
        ],
        [radius *  [cos(angles[1]), sin(angles[1])]]
    );

    polygon(points);
}