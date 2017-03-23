/**
* circular_sector.scad
*
* Create a circular sector. You can pass a 2 element vector to define the central angle. Its $fa, $fs and $fn parameters are consistent with the circle module.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-circular_sector.html
*
**/


module circular_sector(radius, angles) {
    frags = $fn > 0 ? 
        ($fn >= 3 ? $fn : 3) : 
        max(min(360 / $fa, radius * 2 * 3.14159 / $fs), 5)
    ;
    
    echo(frags);
    
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