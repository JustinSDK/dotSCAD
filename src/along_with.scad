/**
* along_with.scad
*
* Puts children along the given path. If there's only one child, 
* it will put the child for each point. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-along_with.html
*
**/ 

include <__private__/__angy_angz.scad>;
include <__private__/__is_vector.scad>;

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

    function _path_angles(i = 0) = 
        i == leng_points_minus_one ?
                [] : 
                concat(
                    [__angy_angz(points[i], points[i + 1])], 
                    _path_angles(i + 1)
                );
            
    function path_angles() = 
       let(angs = _path_angles())
       concat(
           [[0, -angs[0][0], angs[0][1]]], 
           [for(a = angs) [0, -a[0], a[1]]]
       );
       
    angles_defined = angles != undef;
    angs = angles_defined ? angles : path_angles(points);

    module align(i) {
        translate(points[i]) 
            rotate(angs[i])
                rotate(angles_defined ? [0, 0, 0] : [90, 0, -90])
                    rotate(twist_step_a * i) 
                         scale([1, 1, 1] + scale_step_vt * i) 
                             children(0);
    }

    if($children == 1) { 
        for(i = [0:leng_points_minus_one]) {
            align(i) children(0);
        }
    } else {
        for(i = [0:min(leng_points, $children) - 1]) {
            align(i) children(i);
        }
    }

    // hook for testing
    test_along_with_angles(angs);
}

module test_along_with_angles(angles) {
    
}