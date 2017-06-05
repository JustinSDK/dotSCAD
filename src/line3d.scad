/**
* line3d.scad
*
* Creates a 3D line from two points. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-line3d.html
*
**/

include <__private__/__frags.scad>;
include <__private__/__nearest_multiple_of_4.scad>;

module line3d(p1, p2, thickness, p1Style = "CAP_CIRCLE", p2Style = "CAP_CIRCLE") {
    r = thickness / 2;

    frags = __nearest_multiple_of_4(__frags(r));
    half_fa = 180 / frags;
    
    dx = p2[0] - p1[0];
    dy = p2[1] - p1[1];
    dz = p2[2] - p1[2];
    
    length = sqrt(pow(dx, 2) + pow(dy, 2) + pow(dz, 2));
    ay = 90 - atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2)));
    az = atan2(dy, dx);

    module cap_butt() {
        translate(p1) 
            rotate([0, ay, az]) 
                linear_extrude(length) 
                    circle(r, $fn = frags);
    }

    module cap_with(p) { 
        translate(p) 
            rotate([0, ay, az]) 
                children();  
    } 

    module cap(p, style) {
        if(style == "CAP_CIRCLE") {
            w = r / 1.414;
            cap_with(p) 
                linear_extrude(w * 2, center = true) 
                    circle(r, $fn = frags);     
        } else if(style == "CAP_SPHERE") { 
            cap_with(p)
                sphere(r / cos(half_fa), $fn = frags);  
        }            
    }
     
    cap_butt();
    cap(p1, p1Style);
    cap(p2, p2Style);
}