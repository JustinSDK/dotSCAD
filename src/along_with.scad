/**
* along_with.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-along_with.html
*
**/ 

include <__private__/__angy_angz.scad>;
include <__private__/__is_vector.scad>;
include <__private__/__to3d.scad>;

module along_with(points, angles, twist = 0, scale = 1.0) {
    leng_points = len(points);
    leng_points_minus_one = leng_points - 1;
    twist_step_a = twist / leng_points;
        
    function scale_step() =
        let(s =  (scale - 1) / leng_points_minus_one)
        [s, s, s];

    scale_step_vt = __is_vector(scale) ? 
        [
            (scale[0] - 1) / leng_points_minus_one, 
            (scale[1] - 1) / leng_points_minus_one,
            scale[2] == undef ? 0 : (scale[2] - 1) / leng_points_minus_one
        ] : scale_step(); 
    
    module align_with_pts_angles(i) {
        translate(points[i]) 
            rotate(angles[i])
                rotate(twist_step_a * i) 
                        scale([1, 1, 1] + scale_step_vt * i) 
                            children(0);
    }

    module align_with_pts_init(a, s) {
        angleyz = __angy_angz(points[0], points[1]);
        rotate([0, -angleyz[0], angleyz[1]])
            rotate([90, 0, -90])
                rotate(a)
                    scale(s) 
                        children(0);
    }
    
    module align_with_pts_local_rotate(j, init_a, init_s) {
        if(j == 0) {  // first child
            align_with_pts_init(init_a, init_s) 
                children(0);
        }
        else {
            vt0 = points[j] - points[j - 1];
            vt1 = points[j + 1] - points[j];
            a = acos((vt0 * vt1) / (norm(vt0) * norm(vt1)));     
            rotate(a, cross(vt0, vt1)) 
                align_with_pts_local_rotate(j - 1, init_a, init_s) 
                    children(0);
        }
    }

    if(angles != undef) {
        if($children == 1) { 
            for(i = [0:leng_points_minus_one]) {
                align_with_pts_angles(i) children(0);
            }
        } else {
            for(i = [0:min(leng_points, $children) - 1]) {
                align_with_pts_angles(i) children(i);
            }
        }
    }
    else {
        translate(points[0])
            align_with_pts_local_rotate(0, 0, [1, 1, 1])
                children(0); 

        if($children == 1) { 
            for(i = [0:leng_points - 2]) {
                translate(points[i + 1])
                    align_with_pts_local_rotate(i, i * twist_step_a, [1, 1, 1] + scale_step_vt * i)
                        children(0);          
            }          
        } else {
            for(i = [0:min(leng_points, $children) - 2]) {
                translate(points[i + 1])
                    align_with_pts_local_rotate(i, i * twist_step_a, [1, 1, 1] + scale_step_vt * i)
                        children(i + 1);   
            }
        }
    }

}