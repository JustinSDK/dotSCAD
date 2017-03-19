/**
* polyline3d.scad
*
* Creates a 3D polyline from a list of `[x, y, z]` coordinates. 
* It depends on the line3d module so you have to include line3d.scad.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-polyline3d.html
*
**/

module polyline3d(points, thickness, startingStyle = "CAP_CIRCLE", endingStyle = "CAP_CIRCLE", fn = 24) {
    module line_segment(index) {
        styles = index == 1 ? [startingStyle, "CAP_BUTT"] : (
            index == len(points) - 1 ? ["CAP_SPHERE", endingStyle] : [
                "CAP_SPHERE", "CAP_BUTT"
            ]
        );
        
        line3d(points[index - 1], points[index], thickness, 
               p1Style = styles[0], p2Style = styles[1], 
               fn = fn);
    }

    module polyline3d_inner(points, index) {
        if(index < len(points)) {
            line_segment(index);
            polyline3d_inner(points, index + 1);
        }
    }

    polyline3d_inner(points, 1);
}