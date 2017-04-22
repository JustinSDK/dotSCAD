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

module line3d(p1, p2, thickness, p1Style = "CAP_CIRCLE", p2Style = "CAP_CIRCLE") {
    r = thickness / 2;

    frags = $fn > 0 ? 
        ($fn >= 3 ? $fn : 3) : 
        max(min(360 / $fa, r * 6.28318 / $fs), 5)
    ;

    remain = frags % 4;
    frags_of_4 = (remain / 4) > 0.5 ? frags - remain + 4 : frags - remain;
    half_fa = 180 / frags_of_4;
    
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
                    circle(r, $fn = frags_of_4);
    }
                
    module capCircle(p) {
        w = r / 1.414;
        translate(p) 
            rotate([0, ay, az]) 
                translate([0, 0, -w]) 
                    linear_extrude(w * 2) 
                        circle(r, $fn = frags_of_4);       
    }

    module capSphere(p) {
        translate(p) 
            rotate([0, ay, az]) 
                sphere(r / cos(half_fa), $fn = frags_of_4);          
    }
    
    module cap(p, style) {
        if(style == "CAP_CIRCLE") {
            capCircle(p);     
        } else if(style == "CAP_SPHERE") { 
            capSphere(p);  
        }       
    }
    
    cap_butt();
    cap(p1, p1Style);
    cap(p2, p2Style);
}