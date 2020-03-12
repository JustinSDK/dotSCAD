/**
* path_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-path_extrude.html
*
**/

use <__comm__/__to3d.scad>;
use <__comm__/__angy_angz.scad>;
use <rotate_p.scad>;
use <sweep.scad>;
use <matrix/m_rotation.scad>;

module path_extrude(shape_pts, path_pts, triangles = "SOLID", twist = 0, scale = 1.0, closed = false, method = "AXIS_ANGLE") {
    sh_pts = len(shape_pts[0]) == 3 ? shape_pts : [for(p = shape_pts) __to3d(p)];
    pth_pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) __to3d(p)];
        
    len_path_pts = len(pth_pts);
    len_path_pts_minus_one = len_path_pts - 1;
    
    module axis_angle_path_extrude() {
        twist_step_a = twist / len_path_pts;

        function scale_pts(pts, s) = [
            for(p = pts) [p[0] * s[0], p[1] * s[1], p[2] * s[2]]
        ];
        
        function translate_pts(pts, t) = [
            for(p = pts) [p[0] + t[0], p[1] + t[1], p[2] + t[2]]
        ];
            
        function rotate_pts(pts, a, v) = [for(p = pts) rotate_p(p, a, v)];

        scale_step_vt = is_num(scale) ? 
            let(s =  (scale - 1) / len_path_pts_minus_one) [s, s, s] : 
            [
                (scale[0] - 1) / len_path_pts_minus_one, 
                (scale[1] - 1) / len_path_pts_minus_one,
                is_undef(scale[2]) ? 0 : (scale[2] - 1) / len_path_pts_minus_one
            ];   

        // get rotation matrice for sections

        function local_ang_vects(j) = 
            [
                for(i = j; i > 0; i = i - 1) 
                let(
                    vt0 = pth_pts[i] - pth_pts[i - 1],
                    vt1 = pth_pts[i + 1] - pth_pts[i],
                    a = acos((vt0 * vt1) / (norm(vt0) * norm(vt1))),
                    v = cross(vt0, vt1)
                )
                [a, v]
            ];

        rot_matrice = [
            for(ang_vect = local_ang_vects(len_path_pts - 2)) 
                m_rotation(ang_vect[0], ang_vect[1])
        ];

        leng_rot_matrice = len(rot_matrice);
        leng_rot_matrice_minus_one = leng_rot_matrice - 1;
        leng_rot_matrice_minus_two= leng_rot_matrice - 2;

        identity_matrix = [
            [1, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 1, 0],
            [0, 0, 0, 1]
        ];

        function cumulated_rot_matrice(i) = 
            leng_rot_matrice == 0 ? [identity_matrix] : (
                leng_rot_matrice == 1 ? [rot_matrice[0], identity_matrix] : 
                    (
                        i == leng_rot_matrice_minus_two ? 
                        [
                            rot_matrice[leng_rot_matrice_minus_one], 
                            rot_matrice[leng_rot_matrice_minus_two] * rot_matrice[leng_rot_matrice_minus_one]
                        ] 
                        : cumulated_rot_matrice_sub(i))
            );

        function cumulated_rot_matrice_sub(i) = 
            let(
                matrice = cumulated_rot_matrice(i + 1),
                curr_matrix = rot_matrice[i],
                prev_matrix = matrice[len(matrice) - 1]
            )
            concat(matrice, [curr_matrix * prev_matrix]);

        cumu_rot_matrice = cumulated_rot_matrice(0);

        // get all sections

        function init_section(a, s) =
            let(angleyz = __angy_angz(pth_pts[0], pth_pts[1]))
            rotate_pts(
                rotate_pts(
                    rotate_pts(
                        scale_pts(sh_pts, s), a
                    ), [90, 0, -90]
                ), [0, -angleyz[0], angleyz[1]]
            );
            
        function local_rotate_section(j, init_a, init_s) =
            j == 0 ? 
                init_section(init_a, init_s) : 
                local_rotate_section_sub(j, init_a, init_s);
        
        function local_rotate_section_sub(j, init_a, init_s) = 
            let(
                vt0 = pth_pts[j] - pth_pts[j - 1],
                vt1 = pth_pts[j + 1] - pth_pts[j],
                ms = cumu_rot_matrice[j - 1]
            )
            [
                for(p = init_section(init_a, init_s)) 
                    [
                        [ms[0][0], ms[0][1], ms[0][2]] * p,
                        [ms[1][0], ms[1][1], ms[1][2]] * p,
                        [ms[2][0], ms[2][1], ms[2][2]] * p
                    ]
            ];        

        sections =
            let(
                fst_section = 
                    translate_pts(local_rotate_section(0, 0, [1, 1, 1]), pth_pts[0]),
                end_i = len_path_pts - 1,
                remain_sections = [
                    for(i = 0; i < end_i; i = i + 1) 
                        translate_pts(
                            local_rotate_section(i, i * twist_step_a, [1, 1, 1] + scale_step_vt * i),
                            pth_pts[i + 1]
                        )
                ]
            ) concat([fst_section], remain_sections);

        calculated_sections =
            closed && pth_pts[0] == pth_pts[len_path_pts_minus_one] ?
                concat(sections, [sections[0]]) : // round-robin
                sections;
        
        sweep(
            calculated_sections,
            triangles = triangles
        );   

        // hook for testing
        test_path_extrude(sections, method);        
    }

    module euler_angle_path_extrude() {
        scale_step_vt = is_num(scale) ? 
            [(scale - 1) / len_path_pts_minus_one, (scale - 1) / len_path_pts_minus_one] : 
            [(scale[0] - 1) / len_path_pts_minus_one, (scale[1] - 1) / len_path_pts_minus_one];

        scale_step_x = scale_step_vt[0];
        scale_step_y = scale_step_vt[1];
        twist_step = twist / len_path_pts_minus_one;

        function section(p1, p2, i) = 
            let(
                length = norm(p1 - p2),
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
        
        path_extrude_inner =
            [
                for(i = 1; i < len_path_pts; i = i + 1)
                    section(pth_pts[i - 1], pth_pts[i],  i)
            ];

        calculated_sections =
            closed && pth_pts[0] == pth_pts[len_path_pts_minus_one] ?
                concat(path_extrude_inner, [path_extrude_inner[0]]) : // round-robin
                concat([section(pth_pts[0], pth_pts[1], 0)], path_extrude_inner);

        sweep(
            calculated_sections,
            triangles = triangles
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