/**
* path_extrude.scad
*
* It extrudes a 2D shape along a path. 
* This module is suitable for a path created by a continuous function.
* It depends on the rotate_p function and the polysections module. 
* Remember to include "rotate_p.scad" and "polysections.scad".
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-path_extrude.html
*
**/

include <__private__/__is_vector.scad>;
include <__private__/__to3d.scad>;
include <__private__/__angy_angz.scad>;
include <__private__/__length_between.scad>;

module path_extrude(shape_pts, path_pts, triangles = "SOLID", twist = 0, scale = 1.0, closed = false) {
    sh_pts = len(shape_pts[0]) == 3 ? shape_pts : [for(p = shape_pts) __to3d(p)];
    pth_pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) __to3d(p)];

    len_path_pts = len(pth_pts);    
    len_path_pts_minus_one = len_path_pts - 1;     

    scale_step_vt = __is_vector(scale) ? 
        [(scale[0] - 1) / len_path_pts_minus_one, (scale[1] - 1) / len_path_pts_minus_one] :
        [(scale - 1) / len_path_pts_minus_one, (scale - 1) / len_path_pts_minus_one];

    scale_step_x = scale_step_vt[0];
    scale_step_y = scale_step_vt[1];
    twist_step = twist / len_path_pts_minus_one;

    function section(p1, p2, i) = 
        let(
            length = __length_between(p1, p2),
            angy_angz = __angy_angz(p1, p2),
            ay = -angy_angz[0],
            az = angy_angz[1]
        )
        [
            for(p = sh_pts) 
                let(scaled_p = [p[0] * (1 + scale_step_x * i), p[1] * (1 + scale_step_y * i), p[2]])
                rotate_p(
                     rotate_p(
                         rotate_p(scaled_p, twist_step * i), [90, 0, -90]
                     ) + [i == 0 ? 0 : length, 0, 0], 
                     [0, ay, az]
                ) + p1
        ];
    
    function path_extrude_inner(index) =
       index == len_path_pts ? [] :
           concat(
               [section(pth_pts[index - 1], pth_pts[index],  index)],
               path_extrude_inner(index + 1)
           );

    function calculated_sections() =
        let(sections = path_extrude_inner(1))
        closed && pth_pts[0] == pth_pts[len_path_pts_minus_one] ?
            concat(sections, [sections[0]]) : // round-robin
            concat([section(pth_pts[0], pth_pts[1], 0)], sections);
   
   sections = calculated_sections();

    polysections(
        sections,
        triangles = triangles
    );   

    // hook for testing
    test_path_extrude(sections);
}

// override to test
module test_path_extrude(sections) {

}