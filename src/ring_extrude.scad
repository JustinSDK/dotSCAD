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

    angles = __is_vector(angle) ? angle : [0, angle];

    m = floor(angles[0] / a_step) + 1;
    n = floor(angles[1] / a_step);

    leng = radius * cos(a_step / 2);

    begin_r =
        leng / cos((m - 0.5) * a_step - angles[0]);

    end_r =      
        leng / cos((n + 0.5) * a_step - angles[1]);

    angs = concat(
        [[90, 0, angles[0]]], 
        m > n ? [] : [for(i = [m:n]) [90, 0, a_step * i]]
    );
    pts = concat(
        [__ra_to_xy(begin_r, angles[0])],
        m > n ? [] : [for(i = [m:n]) __ra_to_xy(radius, a_step * i)]
    ); 

    is_angle_frag_end = angs[len(angs) - 1][2] == angles[1];
    
    all_angles = is_angle_frag_end ? 
        angs :  
        concat(angs, [[90, 0, angles[1]]]);
        
    all_points = is_angle_frag_end ? 
        pts :
        concat(pts, [__ra_to_xy(end_r(), angles[1])]);

    polysections(
        cross_sections(shape_pts, all_points, all_angles, twist, scale),
        triangles = triangles
    );
}