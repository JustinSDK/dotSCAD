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

        // hook for testing
        test_polyline2d_line_segment(index, p1, p2, width, p1Style, p2Style);
    }

    module lines(index) {
        if(index < leng_pts) {
            line_segment(index);
            lines(index + 1);
        } 
    }

    function angle(p1, p2, p3) = 
        let(
            v1 = p2 - p1,
            v2 = p3 - p2
        )
        acos((v1 * v2) / (norm(v1) * norm(v2)));

    module joins(line, radius, i_end, i) {
        if(i < i_end) {
            p1 = line[i];
            p2 = line[i + 1];
            p3 = line[i + 2];
            v1 = p2 - p1;
            v2 = p3 - p2;
            c = cross(v1, v2);  // c > 0: ct_clk

            a = angle(p1, p2, p3);
            v1a = atan2(v1[1], v1[0]);

            ra = c > 0 ? (-90 + v1a) : (90 + v1a - a);
            if(joinStyle == "JOIN_ROUND") {
                translate(p2) 
                rotate(ra) 
                    pie(
                        radius = radius, 
                        angle = [0, a], 
                        $fn = fn * 360 / a
                    ); 
            } else if(joinStyle == "JOIN_MITER") {
                translate(p2) 
                rotate(ra) 
                    polygon([[0, 0], [radius, 0], [radius, radius * tan(a / 2)], [radius * cos(a), radius * sin(a)]]);    
            } else { // "JOIN_BEVEL"
                translate(p2) 
                rotate(ra) 
                    polygon([[0, 0], [radius, 0], [radius * cos(a), radius * sin(a)]]);
            }
  
            joins(line, radius, i_end, i + 1);        
        }
    }

    if(leng_pts == 2) {
        line2d(points[0], points[1], width, startingStyle, endingStyle);
    }
    else {
        lines(1);
        joins(points, width / 2, leng_pts - 2, 0);
    }
}

// override it to test
module test_polyline2d_line_segment(index, point1, point2, width, p1Style, p2Style) {

}