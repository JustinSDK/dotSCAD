/**
* line2d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-line2d.html
*
**/

use <__comm__/__frags.scad>
use <__comm__/__nearest_multiple_of_4.scad>

module line2d(p1, p2, width = 1, p1Style = "CAP_SQUARE", p2Style =  "CAP_SQUARE") {
    half_width = 0.5 * width;    

    v = p2 - p1;
    leng = norm(v);
    c = v.x / leng;
    s = v.y/ leng;
    rotation_m = [
        [c, -s, 0, 0],
        [s, c, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
    ];

    frags = __nearest_multiple_of_4(__frags(half_width));
        
    module square_end(point) {
        translate(point) 
        multmatrix(rotation_m) 
            square(width, center = true);

        // hook for testing
        test_line2d_cap(point, "CAP_SQUARE");
    }

    module round_end(point) {
        translate(point) 
        multmatrix(rotation_m) 
            circle(half_width, $fn = frags);    

        // hook for testing
        test_line2d_cap(point, "CAP_ROUND");                
    }
    
    if(p1Style == "CAP_SQUARE") {
        square_end(p1);
    } else if(p1Style == "CAP_ROUND") {
        round_end(p1);
    }

    translate(p1) 
    multmatrix(rotation_m) 
    translate([0, -width / 2]) 
        square([leng, width]);
    
    if(p2Style == "CAP_SQUARE") {
        square_end(p2);
    } else if(p2Style == "CAP_ROUND") {
        round_end(p2);
    }

    // hook for testing
    test_line2d_line(leng, width, frags);
}

// override them to test
module test_line2d_cap(point, style) {
}

module test_line2d_line(length, width, frags) {
}

