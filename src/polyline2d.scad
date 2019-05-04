/**
* polyline2d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-polyline2d.html
*
**/

module polyline2d(points, width, startingStyle = "CAP_SQUARE", endingStyle = "CAP_SQUARE") {
    leng_pts = len(points);

    module line_segment(index) {
        styles = index == 1 ? [startingStyle, "CAP_ROUND"] : (
            index == leng_pts - 1 ? ["CAP_BUTT", endingStyle] : [
                "CAP_BUTT", "CAP_ROUND"
            ]
        );

        p1 = points[index - 1];
        p2 = points[index];
        p1Style = styles[0];
        p2Style = styles[1];
        
        line2d(points[index - 1], points[index], width, 
               p1Style = p1Style, p2Style = p2Style);

        // hook for testing
        test_line_segment(index, p1, p2, width, p1Style, p2Style);
    }

    module polyline2d_inner(index) {
        if(index < leng_pts) {
            line_segment(index);
            polyline2d_inner(index + 1);
        } 
    }

    polyline2d_inner(1);
}

// override it to test
module test_line_segment(index, point1, point2, width, p1Style, p2Style) {

}