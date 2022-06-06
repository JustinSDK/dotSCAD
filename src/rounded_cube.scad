/**
* rounded_cube.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-rounded_cube.html
*
**/

use <__comm__/__frags.scad>
use <__comm__/__nearest_multiple_of_4.scad>

module rounded_cube(size, corner_r, center = false) {
    dimension = is_num(size) ? [size, size, size] : size;
    half_dim = dimension / 2;

    $fn = __nearest_multiple_of_4(__frags(corner_r));
    edge_d = corner_r * cos(180 / $fn);

    half_dim_m_edge = half_dim - [edge_d, edge_d, edge_d];
        
    pair = [1, -1];
    corners = [
        for(z = pair, y = pair, x = pair) 
        [
            half_dim_m_edge.x * x, 
            half_dim_m_edge.y * y, 
            half_dim_m_edge.z * z
        ]
    ];

    module corner(i) {
        translate(corners[i]) 
            sphere(corner_r);        
    }

    center_pts = center ? [0, 0, 0] : half_dim;
    
    // Don't use `hull() for(...) {...}` because it's slow.
    translate(center_pts) 
    hull() {
        corner(0);
        corner(1);
        corner(2);
        corner(3);
        corner(4);
        corner(5);
        corner(6);
        corner(7);      
    }

    // hook for testing
    test_rounded_edge_corner_center($fn, corners, center_pts);
}

// override it to test
module test_rounded_edge_corner_center(corner_frags, corners, center_pts) {

}