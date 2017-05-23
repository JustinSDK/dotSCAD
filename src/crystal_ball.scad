/**
* crystal_ball.scad
*
* Uses Spherical coordinate system to create a crystal ball. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-crystal_ball.html
*
**/ 

include <__private__/__nearest_multiple_of_4.scad>;
include <__private__/__is_vector.scad>;

module crystal_ball(radius, theta = 360, phi = 180) {
    phis = __is_vector(phi) ? phi : [0, phi];
    
    frags = __frags(radius);

    shape_pts = shape_pie(
        radius, 
        [90 - phis[1], 90 - phis[0]], 
        $fn = __nearest_multiple_of_4(frags)
    );

    // _hole_r = 0.0005 for avoiding warnings
    _hole_r = 0.0005;
    ring_extrude(
        shape_pts, 
        angle = theta, 
        radius = _hole_r, 
        $fn = frags
    );
}