/**
* polyline2d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-polyline2d.html
*
**/

use <line2d.scad>;
use <pie.scad>;

module polyline2d(points, width = 1, startingStyle = "CAP_SQUARE", endingStyle = "CAP_SQUARE", joinStyle = "JOIN_ROUND") {
    leng_pts = len(points);

    s_styles = [startingStyle, "CAP_BUTT"];
    e_styles = ["CAP_BUTT", endingStyle];
    default_styles = ["CAP_BUTT", "CAP_BUTT"];

    fn = $fn == 0 ? 12 : $fn;

    module line_segment(index) {
        styles = index == 1 ? s_styles : 
                 index == leng_pts - 1 ? e_styles : 
                 default_styles;

        p1 = points[index - 1];
        p2 = points[index];
        p1Style = styles[0];
        p2Style = styles[1];
        
        line2d(points[index - 1], points[index], width, 
               p1Style = p1Style, p2Style = p2Style);
    }

    module joins(line, radius, i_end, i) {
        if(i < i_end) {
            p1 = line[i];
            p2 = line[i + 1];
            p3 = line[i + 2];
            v1 = p2 - p1;
            v2 = p3 - p2;
            c = cross(v1, v2);  // c > 0: ct_clk

            normv1xv2 = sqrt(v1 * v1 * v2 * v2);
            cosa = (v1 * v2) / normv1xv2;
            sina = -c / normv1xv2;
            
            translate(p2) 
            rotate(atan2(v1.y, v1.x) + (c > 0 ? -90 : asin(cosa))) {
                if(joinStyle == "JOIN_ROUND") {
                    a = acos(cosa);
                    pie(
                        radius = radius, 
                        angle = [0, a], 
                        $fn = fn * 360 / a
                    ); 
                } else if(joinStyle == "JOIN_MITER") {
                    tana2 = sina / (1 + cosa); // tan(a / 2)
                    polygon(radius * [[0, 0], [1, 0], [1, tana2], [cosa, sina]]);    
                } else { // "JOIN_BEVEL"
                    polygon(radius * [[0, 0], [1, 0], [cosa, sina]]);
                }
            }
  
            joins(line, radius, i_end, i + 1);        
        }
    }

    if(leng_pts == 2) {
        line2d(points[0], points[1], width, startingStyle, endingStyle);
    }
    else {
        for(i = [1:leng_pts - 1]) {
            line_segment(i);
        }
        joins(points, width / 2, leng_pts - 2, 0);
    }
}