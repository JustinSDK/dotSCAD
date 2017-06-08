include <unittest.scad>;

module test_hull_polyline3d() {
    echo("==== test_hull_polyline3d ===="); 

    points = [
        [1, 2, 3], 
        [4, -5, -6], 
        [-1, -3, -5], 
        [0, 0, 0]
    ];
        
    thickness = 1;
            
    include <hull_polyline3d.scad>;
    
    module test_line_segment(index, point1, point2, radius) {
        assertEqualPoint(points[index - 1], point1);
        assertEqualPoint(points[index], point2);
        assertEqual(thickness, radius * 2);    
    } 
    
    hull_polyline3d(
        points = points, 
        thickness = thickness, 
        $fn = 3
    );
}

module test_hull_polyline3d_helix() {
    echo("==== test_hull_polyline3d_helix ===="); 

    r = 50;
    points = [
        for(a = [0:180]) 
            [
               r * cos(-90 + a) * cos(a), 
               r * cos(-90 + a) * sin(a), 
               r * sin(-90 + a)
            ]
    ];
        
    thickness = 12;
            
    include <hull_polyline3d.scad>;
    
    module test_line_segment(index, point1, point2, radius) {
        assertEqualPoint(points[index - 1], point1);
        assertEqualPoint(points[index], point2);
        assertEqual(thickness, radius * 2);    
    } 
    
    for(i = [0:7]) {
        rotate(45 * i) 
            hull_polyline3d(points, thickness, $fn = 3);
    }

}

test_hull_polyline3d();
test_hull_polyline3d_helix();