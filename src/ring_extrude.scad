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
include <__private__/__ra_to_xy.scad>;

module ring_extrude(shape_pts, radius, angle = 360, twist = 0, scale = 1.0, triangles = "SOLID") {

    a_step = 360 / __frags(radius);
    n = floor(angle / a_step);

    function end_r() =      
        radius * cos(a_step / 2) / cos((n + 0.5) * a_step - angle);

    angs = [for(a = [0:a_step:n * a_step]) [90, 0, a]];
    pts = [for(a = angs) __ra_to_xy(radius, a[2])];

    is_angle_frag_end = angs[len(angs) - 1][2] == angle;
    
    angles = is_angle_frag_end ? angs : concat(angs, [[90, 0, angle]]);
    points = is_angle_frag_end ? pts : concat(pts, [__ra_to_xy(end_r(), angle)]);

    polysections(
        cross_sections(shape_pts, points, angles, twist, scale),
        triangles = triangles
    );
}