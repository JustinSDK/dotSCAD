/**
* stereographic_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-stereographic_extrude.html
*
**/

module stereographic_extrude(shadow_side_leng, convexity = 1) {
    half_side_length = shadow_side_leng / 2;
    outer_sphere_r = half_side_length / 3;

    x = 2 * outer_sphere_r;
    y = sqrt(2) * half_side_length;

    inner_sphere_r = outer_sphere_r * y / norm([x, y]);
    
    intersection() { 
        translate([0, 0, outer_sphere_r]) 
        difference() {
            sphere(outer_sphere_r);
            sphere((outer_sphere_r + inner_sphere_r) / 2);
            
            translate([0, 0, outer_sphere_r / 2]) 
            linear_extrude(outer_sphere_r) 
                circle(inner_sphere_r / 2);
        }
     
        linear_extrude(outer_sphere_r * 2, scale = 0.01, convexity = convexity) 
            children();
    }

    // hook for testing
    test_stereographic_extrude_rs(outer_sphere_r, inner_sphere_r);
}

// override for testing
module test_stereographic_extrude_rs(outer_sphere_r, inner_sphere_r) {

}