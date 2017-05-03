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

module path_extrude(shape_pts, path_pts, triangles = "RADIAL", twist = 0, scale = 1.0, round_robin = false) {

    s_pts = to3d(shape_pts);
    pth_pts = to3d(path_pts);

    len_path_pts = len(pth_pts);    
    len_path_pts_minus_one = len_path_pts - 1;     

    scale_step_vt = len(scale) == 2 ? 
        [(scale[0] - 1) / len_path_pts_minus_one, (scale[1] - 1) / len_path_pts_minus_one] :
        [(scale - 1) / len_path_pts_minus_one, (scale - 1) / len_path_pts_minus_one];

    scale_step_x = scale_step_vt[0];
    scale_step_y = scale_step_vt[1];
    twist_step = twist / len_path_pts_minus_one;

    function to3d(pts) = 
        len(pts[0]) == 3 ? pts : [for(p = pts) [p[0], p[1], 0]];

    function first_section() = 
        let(
            p1 = pth_pts[0],
            p2 = pth_pts[1],
            dx = p2[0] - p1[0],
            dy = p2[1] - p1[1],
            dz = p2[2] - p1[2],
            ay = 90 - atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2))),
            az = atan2(dy, dx)
        )
        [
            for(p = s_pts) 
                rotate_p(p, [0, ay, az]) + p1
        ];

    function section(p1, p2, i) = 
        let(
            dx = p2[0] - p1[0],
            dy = p2[1] - p1[1],
            dz = p2[2] - p1[2],
            length = sqrt(pow(dx, 2) + pow(dy, 2) + pow(dz, 2)),
            ay = 90 - atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2))),
            az = atan2(dy, dx)
        )
        [
            for(p = s_pts) 
                let(scaled_p = [p[0] * (1 + scale_step_x * i), p[1] * (1 + scale_step_y * i), p[2]])
                rotate_p(
                     rotate_p(scaled_p, twist_step * i) + [0, 0, length], 
                     [0, ay, az]
                ) + p1
        ];
    
    function path_extrude_inner(index) =
       index == len_path_pts ? [] :
           concat(
               [section(pth_pts[index - 1], pth_pts[index],  index)],
               path_extrude_inner(index + 1)
           );

    if(round_robin && pth_pts[0] == pth_pts[len_path_pts_minus_one]) {
        // round-robin
        sections = path_extrude_inner(1);
        polysections(
            concat(sections, [sections[0]]),
            triangles = triangles
        );   
    } else {
        polysections(
            concat([first_section()], path_extrude_inner(1)),
            triangles = triangles
        ); 
    }
}
