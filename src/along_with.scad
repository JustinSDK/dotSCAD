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

module along_with(points, angles, twist = 0) {
    leng_points = len(points);
    twist_step_a = twist / leng_points;
    echo(twist_step_a);

    function _path_angles(i = 0) = 
        i == leng_points - 1 ?
                [] : 
                concat(
                    [__angy_angz(points[i], points[i + 1])], 
                    _path_angles(i + 1)
                );
            
    function path_angles(points) = 
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
                if(angles_defined) {
                     rotate(twist_step_a * i) 
                         children(0);
                } else {
                    rotate([90, 0, -90])  
                        rotate(twist_step_a * i) 
                            children(0);                    
                }
        }

    if($children == 1) { 
        for(i = [0:len(points) - 1]) {
            align(i) children(0);
        }
    } else {
        for(i = [0:min(len(points), $children) - 1]) {
            align(i) children(i);
        }
    }
}