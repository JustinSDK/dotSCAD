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
include <__private__/__nearest_multiple_of_4.scad>;

module rounded_cube(size, corner_r, center = false) {
    is_vt = __is_vector(size);
    x = is_vt ? size[0] : size;
    y = is_vt ? size[1] : size;
    z = is_vt ? size[2] : size;

    corner_frags = __nearest_multiple_of_4(__frags(corner_r));
    edge_d = corner_r * cos(180 / corner_frags);

    half_x = x / 2;
    half_y = y / 2;
    half_z = z / 2;
    
    half_l = half_x - edge_d;
    half_w = half_y - edge_d;
    half_h = half_z - edge_d;
    
    half_cube_leng = size / 2;
    half_leng = half_cube_leng - edge_d;
    
    corners = [
        for(x = [-1, 1]) 
            for(y = [-1, 1]) 
            for(z = [-1, 1]) 
                [half_l * x, -half_w * y, half_h * z]
    ];

    module corner(i) {
        translate(corners[i]) 
            sphere(corner_r, $fn = corner_frags);        
    }

    center_pts = center ? [0, 0, 0] : [half_x, half_y, half_z];

    translate(center_pts) hull() {
            corner(0);
            corner(1);
            corner(2);
            corner(3);
            corner(4);
            corner(5);
            corner(6);
            corner(7);      
    }

}