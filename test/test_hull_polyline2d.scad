include <unittest.scad>;

module test_hull_polyline2d() {
    echo("==== test_hull_polyline2d ===="); 

    $fn = 4;
    points = [[1, 2], [-5, -4], [-5, 3], [5, 5]];
    line_width = 1;
            
    include <hull_polyline2d.scad>;
    
    module test_hull_polyline2d_line_segment(index, point1, point2, radius) {
        assertEqualPoint(points[index - 1], point1);
        assertEqualPoint(points[index], point2);
        assertEqualNum(line_width, radius * 2);    
    } 

    hull_polyline2d(
        points = [[1, 2], [-5, -4], [-5, 3], [5, 5]], 
        width = 1
    );
}

test_hull_polyline2d();