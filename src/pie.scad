/**
* pie.scad
*
* Creates a pie (circular sector). You can pass a 2 element vector to define the central angle. Its $fa, $fs and $fn parameters are consistent with the circle module.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-pie.html
*
**/

include <__private__/__frags.scad>;
include <__private__/__is_vector.scad>;
include <__private__/__ra_to_xy.scad>;
 
module pie(radius, angle) {
    
    a_step = 360 / __frags(radius);
    
    angles = __is_vector(angle) ? angle : [0, angle];

    m = floor(angles[0] / a_step) + 1;
    n = floor(angles[1] / a_step);
    
    half_a_step = a_step / 2;
    leng = radius * cos(half_a_step);    

    function edge_r_begin(a) =
        leng / cos((m - 0.5) * a_step - a);

    function edge_r_end(a) =      
        leng / cos((n + 0.5) * a_step - a);    
    
    points = concat(
        [[0, 0], __ra_to_xy(edge_r_begin(angles[0]), angles[0])],
        m > n ? [] : [for(i = [m:n]) __ra_to_xy(radius, a_step * i)],
        angles[1] == a_step * n ? [] : [__ra_to_xy(edge_r_end(angles[1]), angles[1])]
    );

    polygon(points);
}