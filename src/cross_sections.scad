/**
* cross_sections.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-cross_sections.html
*
**/

use <__comm__/__to3d.scad>;

use <matrix/m_scaling.scad>;
use <matrix/m_translation.scad>;
use <matrix/m_rotation.scad>;

function cross_sections(shape_pts, path_pts, angles, twist = 0, scale = 1.0) =
    let(
        len_path_pts_minus_one = len(path_pts) - 1,
        sh_pts = len(shape_pts[0]) == 3 ? shape_pts : [for(p = shape_pts) __to3d(p)],
        pth_pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) __to3d(p)],
        scale_step_vt = is_num(scale) ? 
            [(scale - 1) / len_path_pts_minus_one, (scale - 1) / len_path_pts_minus_one] :
            [(scale[0] - 1) / len_path_pts_minus_one, (scale[1] - 1) / len_path_pts_minus_one],
        twist_step = twist / len_path_pts_minus_one
    )
    [
        for(i = 0; i <= len_path_pts_minus_one; i = i + 1)
        let(
            transform_m = m_translation(pth_pts[i]) * 
                          m_rotation(angles[i]) * 
                          m_rotation(twist_step * i) * 
                          m_scaling([1 + scale_step_vt.x * i, 1 + scale_step_vt.y * i, 1])
        )
        [
            for(p = sh_pts) 
            let(transformed = transform_m * [each p, 1])
            [transformed.x, transformed.y, transformed.z]
        ]
    ];
