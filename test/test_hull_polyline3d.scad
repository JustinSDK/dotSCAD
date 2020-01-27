use <unittest.scad>;            
use <hull_polyline3d.scad>;

module test_hull_polyline3d_line_segment(index, point1, point2, radius) {
    points = [
        [1, 2, 3], 
        [4, -5, -6], 
        [-1, -3, -5], 
        [0, 0, 0]
    ];
        
    thickness = 1;

    assertEqualPoint(points[index - 1], point1);
    assertEqualPoint(points[index], point2);
    assertEqualNum(thickness, radius * 2);    
} 

module test_hull_polyline3d() {
    echo("==== test_hull_polyline3d ===="); 

    points = [
        [1, 2, 3], 
        [4, -5, -6], 
        [-1, -3, -5], 
        [0, 0, 0]
    ];
        
    thickness = 1;

    hull_polyline3d(
        points = points, 
        thickness = thickness, 
        $fn = 3
    );
}

test_hull_polyline3d();