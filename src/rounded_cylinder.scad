/**
* rounded_cylinder.scad
*
* Creates a rounded cylinder. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-rounded_cylinder.html
*
**/

include <__private__/__is_vector.scad>;
include <__private__/__frags.scad>;
include <__private__/__pie_for_rounding.scad>;
include <__private__/__half_trapezium.scad>;

module rounded_cylinder(radius, h, round_r, convexity = 2, center = false) {  
    r_corners = __half_trapezium(radius, h, round_r);
    
    shape_pts = concat(
        [[0, -h/2]],
        r_corners,           
        [[0, h/2]]
    );

    center_pt = center ? [0, 0, 0] : [0, 0, h/2];

    translate(center ? [0, 0, 0] : [0, 0, h/2]) 
        rotate(180) 
            rotate_extrude(convexity = convexity) 
                polygon(shape_pts);

    
}

