/**
* line2d.scad
*
* Creates a line from two points.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-line2d.html
*
**/

include <__private__/__frags.scad>;
include <__private__/__nearest_multiple_of_4.scad>;

module line2d(p1, p2, width, p1Style = "CAP_SQUARE", p2Style =  "CAP_SQUARE") {
    half_width = 0.5 * width;    

    atan_angle = atan2(p2[1] - p1[1], p2[0] - p1[0]);
    leng = sqrt(pow(p2[0] - p1[0], 2) + pow(p2[1] - p1[1], 2));

    frags = __nearest_multiple_of_4(__frags(half_width));
        
    module square_end(point) {
        translate(point) 
            rotate(atan_angle) 
                square(width, center = true);

        // hook for testing
        cap(point, "CAP_SQUARE");
    }

    module round_end(point) {
        translate(point) 
            rotate(atan_angle) 
                circle(half_width, center = true, $fn = frags);    

        // hook for testing
        cap(point, "CAP_ROUND");                
    }
    
    if(p1Style == "CAP_SQUARE") {
        square_end(p1);
    } else if(p1Style == "CAP_ROUND") {
        round_end(p1);
    }

    translate(p1) 
        rotate(atan_angle) 
            translate([0, -width / 2]) 
                square([leng, width]);
    
    if(p2Style == "CAP_SQUARE") {
        square_end(p2);
    } else if(p2Style == "CAP_ROUND") {
        round_end(p2);
    }

    // hook for testing
    test_line2d_line(atan_angle, leng, width, frags);
}

module cap(point, style) {
}

module test_line2d_line(angle, length, width, frags) {
}

