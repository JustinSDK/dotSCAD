/**
* along_with.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-along_with.html
*
**/ 
 
use <__comm__/__angy_angz.scad>;
use <__comm__/__to3d.scad>;
use <matrix/m_rotation.scad>;

module along_with(points, angles, twist = 0, scale = 1.0, method = "AXIS_ANGLE") {
    pts = len(points[0]) == 3 ? points : [for(p = points) __to3d(p)];
    leng_points = len(points);
    leng_points_minus_one = leng_points - 1;
    twist_step_a = twist / leng_points;

    angles_defined = !is_undef(angles);

    scale_step_vt = is_num(scale) ? 
        let(s =  (scale - 1) / leng_points_minus_one) [s, s, s] :
        [
            (scale.x - 1) / leng_points_minus_one, 
            (scale.y - 1) / leng_points_minus_one,
            is_undef(scale.z) ? 0 : (scale.z - 1) / leng_points_minus_one
        ]; 

    /* 
         Sadly, children(n) cannot be used with inner modules 
         so I have to do things in the first level. Ugly!!
    */

    // >>> begin: modules and functions for "AXIS-ANGLE"

    // get rotation matrice for sections
    identity_matrix = [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
    ];    

    function axis_angle_local_ang_vects(j, pts) = 
        [
            for(i = j; i > 0; i = i - 1) 
            let(
                vt0 = pts[i] - pts[i - 1],
                vt1 = pts[i + 1] - pts[i],
                a = acos((vt0 * vt1) / (norm(vt0) * norm(vt1))),
                v = cross(vt0, vt1)
            )
            [a, v]
        ];

    function axis_angle_cumulated_rot_matrice(i, rot_matrice) = 
        let(
            leng_rot_matrice = len(rot_matrice),
            leng_rot_matrice_minus_one = leng_rot_matrice - 1,
            leng_rot_matrice_minus_two = leng_rot_matrice - 2
        )
        leng_rot_matrice == 0 ? [identity_matrix] : (
            leng_rot_matrice == 1 ? [rot_matrice[0], identity_matrix] : (
                i == leng_rot_matrice_minus_two ? 
               [
                   rot_matrice[leng_rot_matrice_minus_one], 
                   rot_matrice[leng_rot_matrice_minus_two] * rot_matrice[leng_rot_matrice_minus_one]
               ] 
               : axis_angle_cumulated_rot_matrice_sub(i, rot_matrice)
            )
        );

    function axis_angle_cumulated_rot_matrice_sub(i, rot_matrice) = 
        let(
            matrice = axis_angle_cumulated_rot_matrice(i + 1, rot_matrice),
            curr_matrix = rot_matrice[i],
            prev_matrix = matrice[len(matrice) - 1]
        )
        [each matrice, curr_matrix * prev_matrix];

    // align modules

    module axis_angle_align_with_pts_angles(i) {
        translate(pts[i]) 
        rotate(angles[i])
        rotate(twist_step_a * i) 
        scale([1, 1, 1] + scale_step_vt * i) 
            children(0);
    }

    module axis_angle_align_with_pts_rs(a, s) {
        angleyz = __angy_angz(pts[0], pts[1]);
        rotate([0, -angleyz[0], angleyz[1]])
        rotate([0, 0, a - 90])
        scale(s) 
            children(0);
    }
    
    module axis_angle_align_with_local_rotate(j, a, s, cumu_rot_matrice) {
        if(j == 0) {  // first child
            axis_angle_align_with_pts_rs(a, s) 
                children(0);
        }
        else {
            multmatrix(cumu_rot_matrice[j - 1])
            axis_angle_align_with_pts_rs(a, s) 
                children(0);
        }
    } 

    // <<< end: modules and functions for "AXIS-ANGLE"


    // >>> begin: modules and functions for "EULER-ANGLE"

    function _euler_angle_path_angles(pts, end_i) = 
        [for(i = 0; i < end_i; i = i + 1) __angy_angz(pts[i], pts[i + 1])];
            
    function euler_angle_path_angles(children) = 
       let(
           end_i = children == 1 ? leng_points_minus_one : children - 1,
           angs = _euler_angle_path_angles(pts, end_i)
        )
        [
            [0, -angs[0][0], angs[0][1]], 
            each[for(a = angs) [0, -a[0], a[1]]]
        ];

    module euler_angle_align(i, angs) {
        translate(pts[i]) 
        rotate(angs[i])
        rotate(angles_defined ? [0, 0, 0] : [90, 0, -90])
        rotate(twist_step_a * i) 
        scale([1, 1, 1] + scale_step_vt * i) 
            children(0);
    }

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
            cumu_rot_matrice = axis_angle_cumulated_rot_matrice(0, [
                for(ang_vect = axis_angle_local_ang_vects(leng_points - 2, pts)) 
                    m_rotation(ang_vect[0], ang_vect[1])
            ]);

            translate(pts[0])
            axis_angle_align_with_local_rotate(0, 0, [1, 1, 1], cumu_rot_matrice)
                children(0); 

            if($children == 1) { 
                for(i = [0:leng_points - 2]) {
                    translate(pts[i + 1])
                    axis_angle_align_with_local_rotate(i, i * twist_step_a, [1, 1, 1] + scale_step_vt * i, cumu_rot_matrice)
                        children(0);          
                }          
            } else {
                for(i = [0:min(leng_points, $children) - 2]) {
                    translate(pts[i + 1])
                    axis_angle_align_with_local_rotate(i, i * twist_step_a, [1, 1, 1] + scale_step_vt * i, cumu_rot_matrice)
                        children(i + 1);   
                }
            }
        }
    }
    else if(method == "EULER_ANGLE") {
        angs = angles_defined ? angles : euler_angle_path_angles($children);
        
        if($children == 1) { 
            for(i = [0:leng_points_minus_one]) {
                euler_angle_align(i, angs) children(0);
            }
        } else {
            for(i = [0:min(leng_points, $children) - 1]) {
                euler_angle_align(i, angs) children(i);
            }
        }    

        test_along_with_angles(angs, $children);    
    }
}

module test_along_with_angles(angles, children) {

}