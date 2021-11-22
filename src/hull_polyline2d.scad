/**
* hull_polyline2d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-hull_polyline2d.html
*
**/

module hull_polyline2d(points, width = 1) {
    echo("`hull_polyline2d` is deprecated since 3.2. Use `polyline_join` instead.");
    
    half_width = width / 2;
    leng = len(points);
    
    module hull_line2d(index) {
        point1 = points[index - 1];
        point2 = points[index];

        hull() {
            translate(point1) 
                children();
            translate(point2) 
                children();
        }

        // hook for testing
        test_hull_polyline2d_line_segment(index, point1, point2, half_width);
    }

    for(i = [1:leng - 1]) {
        hull_line2d(i)
            circle(half_width);
    }
}

// override it to test
module test_hull_polyline2d_line_segment(index, point1, point2, radius) {

}