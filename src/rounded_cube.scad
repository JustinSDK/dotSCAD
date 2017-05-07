/**
* rounded_cube.scad
*
* Creates a rounded cube in the first octant. 
* When center is true, the cube is centered on the origin.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-rounded_cube.html
*
**/

include <__private__/__is_vector.scad>;
include <__private__/__frags.scad>;

module rounded_cube(size, corner_r, center = false) {
    is_vt = __is_vector(size);
    x = is_vt ? size[0] : size;
    y = is_vt ? size[1] : size;
    z = is_vt ? size[2] : size;

    frags = __frags(corner_r);

    remain = frags % 4;
    corner_frags = (remain / 4) > 0.5 ? frags - remain + 4 : frags - remain;
    edge_d = corner_r * cos(180 / corner_frags);

    half_x = x / 2;
    half_y = y / 2;
    half_z = z / 2;
    
    half_l = half_x - edge_d;
    half_w = half_y - edge_d;
    half_h = half_z - edge_d;
    
    half_cube_leng = size / 2;
    half_leng = half_cube_leng - edge_d;
    
    translate(center ? [0, 0, 0] : [half_x, half_y, half_z]) hull() {
            translate([-half_l, -half_w, half_h]) 
                sphere(corner_r, $fn = corner_frags);
            translate([half_l, -half_w, half_h]) 
                sphere(corner_r, $fn = corner_frags);
            translate([half_l, half_w, half_h]) 
                sphere(corner_r, $fn = corner_frags);
            translate([-half_l, half_w, half_h]) 
                sphere(corner_r, $fn = corner_frags);

            translate([-half_l, -half_w, -half_h]) 
                sphere(corner_r, $fn = corner_frags);
            translate([half_l, -half_w, -half_h]) 
                sphere(corner_r, $fn = corner_frags);
            translate([half_l, half_w, -half_h]) 
                sphere(corner_r, $fn = corner_frags);
            translate([-half_l, half_w, -half_h]) 
                sphere(corner_r, $fn = corner_frags);        
    }
}