/**
* path_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-path_extrude.html
*
**/

use <__comm__/__to3d.scad>
use <__comm__/__angy_angz.scad>
use <sweep.scad>
use <matrix/m_scaling.scad>
use <matrix/m_translation.scad>
use <matrix/m_rotation.scad>

module path_extrude(shape_pts, path_pts, triangles = "SOLID", twist = 0, scale = 1.0, closed = false, method = "AXIS_ANGLE") {
    sh_pts = len(shape_pts[0]) == 3 ? [for(p = shape_pts) [each p, 1]] : [for(p = shape_pts) [p.x, p.y, 0, 1]];
    pth_pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) __to3d(p)];
        
    len_path_pts = len(pth_pts);
    len_path_pts_minus_one = len_path_pts - 1;

    m_rot_90_0_n90 = m_rotation([90, 0, -90]);
    one = [1, 1, 1];
    
    module axis_angle_path_extrude() {
        twist_step_a = twist / len_path_pts;
        
        function translate_pts(pts, t) = [for(p = pts) p + t];

        scale_step_vt = (
            is_num(scale) ? 
            let(s = scale - 1) [s, s, s] : 
            len(scale) == 2 ? [each (scale - [1, 1]), 0]:
                              scale - one
        ) / len_path_pts_minus_one;

        identity_matrix = [
            [1, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 1, 0],
            [0, 0, 0, 1]
        ];
        
        // get rotation matrice for sections
        rot_matrice = [
            for(i = len_path_pts - 2; i > 0; i = i - 1) 
            let(
                vt0 = pth_pts[i] - pth_pts[i - 1],
                vt1 = pth_pts[i + 1] - pth_pts[i],
                a = acos((vt0 * vt1) / sqrt(vt0 * vt0 * vt1 * vt1)),
                v = cross(vt0, vt1)
            )
            m_rotation(a, v)
        ];

        leng_rot_matrice = len(rot_matrice);
        cumu_rot_matrice = leng_rot_matrice <= 1 ? 
            [each rot_matrice, identity_matrix] :
            [
                for(
                    i = leng_rot_matrice - 1, m = rot_matrice[i]; 
                    i > -1; 
                    i = i - 1, m = i == -1 ? undef : rot_matrice[i] * m
                )
                m
            ];

        // get all sections
        angleyz_pts01 = __angy_angz(pth_pts[0], pth_pts[1]);
        function init_section(a, s) =
            let(transform_m = m_rotation([0, -angleyz_pts01[0], angleyz_pts01[1]]) * m_rot_90_0_n90 * m_rotation(a) * m_scaling(s))
            [
                for(p = sh_pts) 
                let(transformed = transform_m * p)
                [transformed.x, transformed.y, transformed.z]
            ];
            
        function local_rotate_section(j, init_a, init_s) = 
            let(
                ms = cumu_rot_matrice[j - 1],
                ms0 = ms[0],
                ms1 = ms[1],
                ms2 = ms[2],
                ms0p = [ms0[0], ms0[1], ms0[2]],
                ms1p = [ms1[0], ms1[1], ms1[2]],
                ms2p = [ms2[0], ms2[1], ms2[2]]
            )
            [
                for(p = init_section(init_a, init_s)) 
                [ms0p * p, ms1p * p, ms2p * p]
            ];        

        sections =
            let(
                fst_section = translate_pts(init_section(0, one), pth_pts[0]),
                snd_section = translate_pts(init_section(0, one + scale_step_vt), pth_pts[1]),
                end_i = closed ? len_path_pts - 2 : len_path_pts - 1,
                remain_sections = [
                    for(i = 1; i < end_i; i = i + 1) 
                        translate_pts(
                            local_rotate_section(i, i * twist_step_a, one + scale_step_vt * (i + 1)),
                            pth_pts[i + 1]
                        )
                ]
            ) [fst_section, snd_section, each remain_sections];

        calculated_sections =
            closed && pth_pts[0] == pth_pts[len_path_pts_minus_one] ?
                [each sections, sections[0]] : // round-robin
                sections;
        
        sweep(
            calculated_sections,
            triangles
        );   

        // hook for testing
        test_path_extrude(sections, method);        
    }

    module euler_angle_path_extrude() {
        scale_step_vt = ((is_num(scale) ? [scale, scale] : scale) - [1, 1]) / len_path_pts_minus_one;

        twist_step = twist / len_path_pts_minus_one;

        function section(p1, p2, i) = 
            let(
                angy_angz = __angy_angz(p1, p2),
                ay = -angy_angz[0],
                az = angy_angz[1],
                transform_m = m_translation(p1) * 
                              m_rotation([0, ay, az]) * 
                              m_translation([i == 0 ? 0 : norm(p1 - p2), 0, 0]) * 
                              m_rot_90_0_n90 * 
                              m_rotation(twist_step * i) * 
                              m_scaling([1 + scale_step_vt.x * i, 1 + scale_step_vt.y * i, 1])
            )
            [
                for(p = sh_pts) 
                let(transformed = transform_m * p)
                [transformed.x, transformed.y, transformed.z]
            ];
        
        path_extrude_inner = [
            for(i = 1; i < len_path_pts; i = i + 1)
            section(pth_pts[i - 1], pth_pts[i],  i)
        ];

        calculated_sections =
            closed && pth_pts[0] == pth_pts[len_path_pts_minus_one] ?
                [each path_extrude_inner, path_extrude_inner[0]] : // round-robin
                [section(pth_pts[0], pth_pts[1], 0), each path_extrude_inner];

        sweep(
            calculated_sections,
            triangles
        );   

        // hook for testing
        test_path_extrude(calculated_sections, method);
    }

    if(method == "AXIS_ANGLE") {
        axis_angle_path_extrude();
    }
    else if(method == "EULER_ANGLE") {
        euler_angle_path_extrude();
    } 
}

// override to test
module test_path_extrude(sections, method) {

}