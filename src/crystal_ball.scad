/**
* crystal_ball.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-crystal_ball.html
*
**/ 

include <__private__/__nearest_multiple_of_4.scad>;

module crystal_ball(radius, theta = 360, phi = 180) {
    phis = is_num(phi) ? [0, phi] : phi;
    
    frags = __frags(radius);

    shape_pts = shape_pie(
        radius, 
        [90 - phis[1], 90 - phis[0]], 
        $fn = __nearest_multiple_of_4(frags)
    );

    ring_extrude(
        shape_pts, 
        angle = theta, 
        radius = 0, 
        $fn = frags
    );

    // hook for testing
    test_crystal_ball_pie(shape_pts);
}

// override it to test
module test_crystal_ball_pie(shape_pts) {

}