/**
* rounded_cylinder.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-rounded_cylinder.html
*
**/

use <__comm__/__half_trapezium.scad>

module rounded_cylinder(radius, h, round_r, convexity = 2, center = false) {  
    r_corners = __half_trapezium(radius, h, round_r);
    half_h = h / 2;
    shape_pts = [[0, -half_h], each r_corners, [0, half_h]];

    center_pt = center ? [0, 0, 0] : [0, 0, half_h];

    translate(center_pt) 
    rotate(180) 
    rotate_extrude(convexity = convexity) 
        polygon(shape_pts);

    // hook for testing
    test_center_half_trapezium(center_pt, shape_pts);
}

// override it to test
module test_center_half_trapezium(center_pt, shape_pts) {
    
}
