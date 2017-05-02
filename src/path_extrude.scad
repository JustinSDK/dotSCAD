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

module path_extrude(shape_pts, path_pts, triangles = "RADIAL", scale = 1.0) {
    function first_section() = 
        let(
            p1 = path_pts[0],
            p2 = path_pts[1],
            dx = p2[0] - p1[0],
            dy = p2[1] - p1[1],
            dz = p2[2] - p1[2],
            ay = 90 - atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2))),
            az = atan2(dy, dx)
        )
        [
            for(p = shape_pts) 
                rotate_p(p, [0, ay, az]) + p1
        ];

    len_path_pts = len(path_pts);  
    scale_step = (scale - 1) / (len_path_pts - 1);

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
            for(p = shape_pts) 
                rotate_p(p * (1 + scale_step * i) + [0, 0, length], [0, ay, az]) + p1
        ];
    

    
    
    function path_extrude_inner(index) =
       index == len_path_pts ? [] :
           concat(
               [section(path_pts[index - 1], path_pts[index],  index)],
               path_extrude_inner(index + 1)
           );

    polysections(
        concat([first_section()], path_extrude_inner(1)),
        triangles = triangles
    );    
}
