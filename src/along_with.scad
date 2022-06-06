/**
* along_with.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-along_with.html
*
**/ 
 
use <__comm__/__angy_angz.scad>
use <__comm__/__to3d.scad>
use <matrix/m_rotation.scad>

module along_with(points, angles, twist = 0, scale = 1.0, method = "AXIS_ANGLE") {
    pts = len(points[0]) == 3 ? points : [for(p = points) __to3d(p)];
    leng_points = len(points);
    leng_points_minus_one = leng_points - 1;
    twist_step_a = twist / leng_points;
    
    scale_one = [1, 1, 1];


    scale_step_vt = (
        is_num(scale) ? 
        let(s = scale - 1) [s, s, s] : 
        len(scale) == 2 ? [each (scale - [1, 1]), 0]:
                          scale - scale_one
    ) / leng_points_minus_one; 

    /* 
         Sadly, children(n) cannot be used with inner modules 
         so I have to do things in the first level. Ugly!!
    */

    // >>> begin: modules and functions for "AXIS-ANGLE"

    identity_matrix = [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
    ];    

    function axis_angle_cumulated_rot_matrice(rot_matrice, leng) = 
        [
            for(
                i = leng - 1, m = rot_matrice[i]; 
                i > -1; 
                i = i - 1, m = i == -1 ? undef : rot_matrice[i] * m
            )
            m
        ];

    module axis_angle_align_with_pts_angles(i) {
        translate(pts[i]) 
        rotate(twist_step_a * i + angles[i])
        scale(scale_one + scale_step_vt * i) 
            children(0);
    }

    angleyz_pts01 = __angy_angz(pts[0], pts[1]);
    module axis_angle_align_with_pts_rs(a, s) {
        rotate([0, -angleyz_pts01[0], angleyz_pts01[1]])
        rotate(a - 90)
        scale(s) 
            children(0);
    }
    
    module axis_angle_align_with_local_rotate(j, a, s, cumu_rot_matrice) {
        multmatrix(cumu_rot_matrice[j - 1])
        axis_angle_align_with_pts_rs(a, s) 
            children(0);
    } 

    // <<< end: modules and functions for "AXIS-ANGLE"


    // >>> begin: modules and functions for "EULER-ANGLE"

    function _euler_angle_path_angles(pts, end_i) = 
        [
            for(i = 0; i < end_i; i = i + 1) 
            let(ayz = __angy_angz(pts[i], pts[i + 1]))
            [0, -ayz[0], ayz[1]]
        ];
            
    function euler_angle_path_angles(children) = 
       let(
           end_i = children == 1 ? leng_points_minus_one : children - 1,
           angs = _euler_angle_path_angles(pts, end_i)
        )
        [angs[0], each angs];

    module euler_angle_align(i, angs, look_at) {
        translate(pts[i]) 
        rotate(angs[i])
        rotate(look_at)
        rotate(twist_step_a * i) 
        scale(scale_one + scale_step_vt * i) 
            children(0);
    }

    angles_defined = !is_undef(angles);

    // <<< end: modules and functions for "EULER-ANGLE"

    if(method == "AXIS_ANGLE") {
        if(angles_defined) {
            if($children == 1) { 
                for(i = [0:leng_points_minus_one]) {
                    axis_angle_align_with_pts_angles(i) children(0);
                }
            } else {
                for(i = [0:min(leng_points, $children) - 1]) {
                    axis_angle_align_with_pts_angles(i) children(i);
                }
            }
        }
        else {
            // get rotation matrice for sections
            rot_matrice = [
                for(i = leng_points - 2; i > 0; i = i - 1) 
                let(
                    vt0 = pts[i] - pts[i - 1],
                    vt1 = pts[i + 1] - pts[i],
                    a = acos((vt0 * vt1) / sqrt((vt0 * vt0) * (vt1 * vt1))),
                    v = cross(vt0, vt1)
                )
                m_rotation(a, v)
            ];

            leng = len(rot_matrice);
            cumu_rot_matrice = leng <= 1 ? [each rot_matrice, identity_matrix] :
                                           axis_angle_cumulated_rot_matrice(rot_matrice, leng);
    
            x_90 = [90, 0, 0];

            for(i = [0, 1]) {
                translate(pts[i])
                axis_angle_align_with_pts_rs(0, scale_one + scale_step_vt * i) 
                rotate(x_90)
                    children(0); 
            }
            
            if($children == 1) { 
                for(i = [1:leng_points - 2]) {
                    translate(pts[i + 1])
                    axis_angle_align_with_local_rotate(i, i * twist_step_a, scale_one + scale_step_vt * (i + 1), cumu_rot_matrice)
                    rotate(x_90)
                        children(0);          
                }          
            } else {
                for(i = [1:min(leng_points, $children) - 2]) {
                    translate(pts[i + 1])
                    axis_angle_align_with_local_rotate(i, i * twist_step_a, scale_one + scale_step_vt * (i + 1), cumu_rot_matrice)
                    rotate(x_90)
                        children(i + 1);   
                }
            }
        }
    }
    else if(method == "EULER_ANGLE") {
        angs = angles_defined ? 
                   (is_list(angles) ? angles : [for(angle = angles) [0, 0, angle]]) :
                   euler_angle_path_angles($children);
        
        look_at = angles_defined ? [0, 0, 0] : [90, 0, -90];

        if($children == 1) { 
            for(i = [0:leng_points_minus_one]) {
                euler_angle_align(i, angs, look_at) children(0);
            }
        } else {
            for(i = [0:min(leng_points, $children) - 1]) {
                euler_angle_align(i, angs, look_at) children(i);
            }
        }    

        test_along_with_angles(angs, $children);    
    }
}

module test_along_with_angles(angles, children) {

}