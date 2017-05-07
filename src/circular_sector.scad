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
    
    half_a_step = a_step / 2;
    leng = radius * cos(half_a_step);    

    function unit_xy(a) = [cos(a), sin(a)];  

    function edge_r_begin(a) =
        leng / cos((m - 0.5) * a_step - a);

    function edge_r_end(a) =      
        leng / cos((n + 0.5) * a_step - a);    
    
    points = concat(
        [[0, 0], edge_r_begin(angles[0]) * unit_xy(angles[0])],
        [
            for(i = [m:n]) 
                radius * unit_xy(a_step * i)
        ],
        [edge_r_end(angles[1]) * unit_xy(angles[1])]
    );

    polygon(points);
}