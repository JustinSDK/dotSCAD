/**
* ring_extrude.scad
*
* Rotational extrusion spins a 2D shape around the Z-axis.  
* It's similar to the built-in `rotate_extrude`; however, it supports angle, twist and scale options.
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-ring_extrude.html
*
**/

include <__private__/__frags.scad>;

module ring_extrude(shape_pts, radius, angle = 360, twist = 0, scale = 1.0, triangles = "SOLID") {
    frags = __frags(radius);
    
    angle_step = 360 / frags;
    as = [for(a = [0:angle_step:angle]) [90, 0, a]];

    angles = as[len(as) - 1][2] == angle ? as : concat(as, [[90, 0, angle]]);
    pts = [for(a = angles) [radius * cos(a[2]), radius * sin(a[2])]];
    
    polysections(
        cross_sections(shape_pts, pts, angles, twist, scale),
        triangles = triangles
    );
}