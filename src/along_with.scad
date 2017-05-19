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

module along_with(points, angles) {
    function _path_angles(path_pts, leng_path_pts, i = 0) = 
        i == leng_path_pts - 1 ?
                [] : 
                concat(
                    [__angy_angz(path_pts[i], path_pts[i + 1])], 
                    _path_angles(path_pts, leng_path_pts, i + 1)
                );
            
    function path_angles(path_pts) = 
       let(
           leng_path_pts = len(path_pts),
           angs = _path_angles(path_pts, leng_path_pts)
       )
       concat(
           [[0, -angs[0][0], angs[0][1]]], 
           [for(a = angs) [0, -a[0], a[1]]]
       );
       
    angles_defined = angles != undef;
    angs = angles_defined ? angles : path_angles(path_pts);

    module align(i) {
        translate(points[i]) 
            rotate(angs[i])
                if(angles_defined) {
                    children(0);
                } else {
                    rotate([90, 0, -90])  
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