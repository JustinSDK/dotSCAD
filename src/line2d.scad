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

module line2d(p1, p2, width, p1Style = "CAP_SQUARE", p2Style =  "CAP_SQUARE") {
    half_width = 0.5 * width;    

    atan_angle = atan2(p2[1] - p1[1], p2[0] - p1[0]);
    leng = sqrt(pow(p2[0] - p1[0], 2) + pow(p2[1] - p1[1], 2));

    translate(p1) 
        rotate(atan_angle) 
            translate([0, -width / 2]) 
                square([leng, width]);

    frags = __frags(half_width);
        
    remain = frags % 4;
    end_frags = (remain / 4) > 0.5 ? frags - remain + 4 : frags - remain;
        
    module square_end(point) {
        translate(point) 
            rotate(atan_angle) 
                square(width, center = true);    
    }

    module round_end(point) {
        translate(point) 
            rotate(atan_angle) 
                circle(half_width, center = true, $fn = end_frags);    
    }
    
    if(p1Style == "CAP_SQUARE") {
        square_end(p1);
    } else if(p1Style == "CAP_ROUND") {
        round_end(p1);
    }
    
    if(p2Style == "CAP_SQUARE") {
        square_end(p2);
    } else if(p2Style == "CAP_ROUND") {
        round_end(p2);
    }
}