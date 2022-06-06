/**
* polyline3d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-polyline3d.html
*
**/

use <line3d.scad>

module polyline3d(points, diameter, startingStyle = "CAP_CIRCLE", endingStyle = "CAP_CIRCLE") {
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
        
        line3d(p1, p2, diameter, 
               p1Style = p1Style, p2Style = p2Style);       
    }

    if(leng_pts == 2) {
        line3d(points[0], points[1], diameter, startingStyle, endingStyle);
    }
    else {
        for(i = [1:leng_pts - 1]) {
            line_segment(i);
        }
    }
}