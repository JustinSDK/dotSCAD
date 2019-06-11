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

    // _hole_r = 0.0005 for avoiding warnings when using 2015.03
    // I downloaded 2017.01.20 and found that the problem is solved.
    _hole_r = version_num() >= 20170120 ? 0 : 0.0005;
    ring_extrude(
        shape_pts, 
        angle = theta, 
        radius = _hole_r, 
        $fn = frags
    );

    // hook for testing
    test_crystal_ball_pie(shape_pts);
}

// override it to test
module test_crystal_ball_pie(shape_pts) {

}