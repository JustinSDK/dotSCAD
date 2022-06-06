/**
* line3d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-line3d.html
*
**/

use <__comm__/__frags.scad>
use <__comm__/__nearest_multiple_of_4.scad>

module line3d(p1, p2, diameter = 1, p1Style = "CAP_CIRCLE", p2Style = "CAP_CIRCLE") {
    r = diameter / 2;

    frags = __nearest_multiple_of_4(__frags(r));
    half_fa = 180 / frags;
    
    v = p2 - p1;
    length = norm(v);
    ay = 90 - atan2(v.z, norm([v.x, v.y]));
    az = atan2(v.y, v.x);

    angles = [0, ay, az];

    module cap_with(p) { 
        translate(p) 
        rotate(angles) 
            children();  
    } 

    module cap_butt() {
        cap_with(p1)                 
        linear_extrude(length) 
            circle(r, $fn = frags);
        
        // hook for testing
        test_line3d_butt(p1, r, frags, length, angles);
    }

    module cap(p, style) {
        if(style == "CAP_CIRCLE") {
            cap_leng = r / 1.414;
            cap_with(p) 
            linear_extrude(cap_leng * 2, center = true) 
                circle(r, $fn = frags);

            // hook for testing
            test_line3d_cap(p, r, frags, cap_leng, angles);
        } else if(style == "CAP_SPHERE") { 
            cap_leng = r / cos(half_fa);
            cap_with(p)
                sphere(cap_leng, $fn = frags);  
            
            // hook for testing
            test_line3d_cap(p, r, frags, cap_leng, angles);
        }            
    }


    cap_butt();
    cap(p1, p1Style);
    cap(p2, p2Style);
}

// Override them to test
module test_line3d_butt(p, r, frags, length, angles) {

}

module test_line3d_cap(p, r, frags, cap_leng, angles) {
    
}