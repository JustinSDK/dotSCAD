/**
* cross_sections.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-cross_sections.html
*
**/

use <matrix/m_scaling.scad>
use <matrix/m_translation.scad>
use <matrix/m_rotation.scad>

function cross_sections(shape_pts, path_pts, angles, twist = 0, scale = 1.0) =
    let(
        len_path_pts_minus_one = len(path_pts) - 1,
        sh_pts = len(shape_pts[0]) == 3 ? [for(p = shape_pts) [each p, 1]] : [for(p = shape_pts) [each p, 0, 1]],
        pth_pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) [each p, 0]]
    )
    twist == 0 && scale == 1.0 ?
    [
        for(i = [0:len_path_pts_minus_one])
        let(transform_m = m_translation(pth_pts[i]) * m_rotation(angles[i]))
        [
            for(p = sh_pts) 
            let(transformed = transform_m * p)
            [transformed.x, transformed.y, transformed.z]
        ]
    ] :
    let(
        twist_step = twist / len_path_pts_minus_one,
        scale_step_vt = (is_num(scale) ? let(s = scale - 1) [s, s, 0] : ([each scale, 0] - [1, 1, 0])) / len_path_pts_minus_one,
        one_s = [1, 1, 1]
    )
    [
        for(i = [0:len_path_pts_minus_one])
        let(
            transform_m = m_translation(pth_pts[i]) * 
                          m_rotation(angles[i]) * 
                          m_rotation(twist_step * i) * 
                          m_scaling(scale_step_vt * i + one_s)
        )
        [
            for(p = sh_pts) 
            let(transformed = transform_m * p)
            [transformed.x, transformed.y, transformed.z]
        ]
    ];
