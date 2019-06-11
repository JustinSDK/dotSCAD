/**
* cross_sections.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-cross_sections.html
*
**/

include <__private__/__to3d.scad>;

function cross_sections(shape_pts, path_pts, angles, twist = 0, scale = 1.0) =
    let(
        len_path_pts_minus_one = len(path_pts) - 1,
        sh_pts = len(shape_pts[0]) == 3 ? shape_pts : [for(p = shape_pts) __to3d(p)],
        pth_pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) __to3d(p)],
        scale_step_vt = is_num(scale) ? 
            [(scale - 1) / len_path_pts_minus_one, (scale - 1) / len_path_pts_minus_one] :
            [(scale[0] - 1) / len_path_pts_minus_one, (scale[1] - 1) / len_path_pts_minus_one]
            ,
        scale_step_x = scale_step_vt[0],
        scale_step_y = scale_step_vt[1],
        twist_step = twist / len_path_pts_minus_one
    )
    [
        for(i = [0:len_path_pts_minus_one])
            [
                for(p = sh_pts) 
                let(scaled_p = [p[0] * (1 + scale_step_x * i), p[1] * (1 + scale_step_y * i), p[2]])
                    rotate_p(
                        rotate_p(scaled_p, twist_step * i)
                        , angles[i]
                    ) + pth_pts[i]
            ]
    ];
