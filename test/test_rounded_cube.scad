use <unittest.scad>
include <rounded_cube.scad>

module test_rounded_edge_corner_center(corner_frags, corners, center_pts) {
    size = 20;
    half_size = size / 2;
    
    assert(corner_frags % 4 == 0);
    
    expected_corners = [[5.0961, 5.0961, 5.0961], [-5.0961, 5.0961, 5.0961], [5.0961, -5.0961, 5.0961], [-5.0961, -5.0961, 5.0961], [5.0961, 5.0961, -5.0961], [-5.0961, 5.0961, -5.0961], [5.0961, -5.0961, -5.0961], [-5.0961, -5.0961, -5.0961]];
    
    assertEqualPoints(expected_corners, corners);
    
    assertEqualPoint(
        [half_size, half_size, half_size], 
        center_pts
    );
}

module test_rounded_cube_size_corner() {
    echo("==== test_rounded_cube_size_corner ===="); 
    
    size = 20;
    corner_r = 5;
                
    rounded_cube(size, corner_r);
}

test_rounded_cube_size_corner();