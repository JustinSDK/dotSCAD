/**
* polyline3d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-polyline3d.html
*
**/

use <line3d.scad>;

module polyline3d(points, thickness, startingStyle = "CAP_CIRCLE", endingStyle = "CAP_CIRCLE") {
    leng_pts = len(points);
    
    s_styles = [startingStyle, "CAP_BUTT"];
    e_styles = ["CAP_SPHERE", endingStyle];
    default_styles = ["CAP_SPHERE", "CAP_BUTT"];

    module line_segment(index) {
        styles = index == 1 ? s_styles : 
                 index == leng_pts - 1 ? e_styles : 
                 default_styles;

        p1 = points[index - 1];
        p2 = points[index];
        p1Style = styles[0];
        p2Style = styles[1];        
        
        line3d(p1, p2, thickness, 
               p1Style = p1Style, p2Style = p2Style);

        // hook for testing
        test_polyline3d_line3d_segment(index, p1, p2, thickness, p1Style, p2Style);               
    }

    module polyline3d_inner(index) {
        if(index < leng_pts) {
            line_segment(index);
            polyline3d_inner(index + 1);
        }
    }

    polyline3d_inner(1);
}

// override it to test
module test_polyline3d_line3d_segment(index, point1, point2, thickness, p1Style, p2Style) {

}