include <unittest.scad>;

module test_rounded_cube_size_corner() {
    echo("==== test_rounded_cube_size_corner ===="); 
    
    size = 20;
    corner_r = 5;
    
    include <rounded_cube.scad>;
            
    module test_rounded_edge_corner_center(corner_frags, corners, center_pts) {
        half_size = size / 2;
        
        assert(corner_frags % 4 == 0);
        
        expected_corners = [[5.0961, 5.0961, 5.0961], [-5.0961, 5.0961, 5.0961], [5.0961, -5.0961, 5.0961], [-5.0961, -5.0961, 5.0961], [5.0961, 5.0961, -5.0961], [-5.0961, 5.0961, -5.0961], [5.0961, -5.0961, -5.0961], [-5.0961, -5.0961, -5.0961]];
        
        assertEqualPoints(expected_corners, corners);
        
        assertEqualPoint(
            [half_size, half_size, half_size], 
            center_pts
        );
    }
    
    rounded_cube(size, corner_r);
}

module test_rounded_cube_size_center() {
    echo("==== test_rounded_cube_size_corner ===="); 
    
    size = [50, 25, 15];
    corner_r = 5;
    
    include <rounded_cube.scad>;
            
    module test_rounded_edge_corner_center(corner_frags, corners, center_pts) {
        
        assert(corner_frags % 4 == 0);
        
        expected_corners = [[20.0961, 7.5961, 2.5961], [-20.0961, 7.5961, 2.5961], [20.0961, -7.5961, 2.5961], [-20.0961, -7.5961, 2.5961], [20.0961, 7.5961, -2.5961], [-20.0961, 7.5961, -2.5961], [20.0961, -7.5961, -2.5961], [-20.0961, -7.5961, -2.5961]];
        
        assertEqualPoints(expected_corners, corners);
        
        assertEqualPoint(
            [0, 0, 0], 
            center_pts
        );
    }
    
    rounded_cube(size, corner_r, center = true);
}

module test_rounded_cube_size_center_fn() {
    echo("==== test_rounded_cube_size_center_fn ===="); 
    
    $fn = 8;
    
    size = [50, 25, 15];
    corner_r = 5;
    
    include <rounded_cube.scad>;
            
    module test_rounded_edge_corner_center(corner_frags, corners, center_pts) {
        
        assert(corner_frags == $fn);
        
        expected_corners = [[20.3806, 7.8806, 2.8806], [-20.3806, 7.8806, 2.8806], [20.3806, -7.8806, 2.8806], [-20.3806, -7.8806, 2.8806], [20.3806, 7.8806, -2.8806], [-20.3806, 7.8806, -2.8806], [20.3806, -7.8806, -2.8806], [-20.3806, -7.8806, -2.8806]];
        
        assertEqualPoints(expected_corners, corners);
        
        assertEqualPoint(
            [0, 0, 0], 
            center_pts
        );
    }
    
    rounded_cube(size, corner_r, center = true);
}

test_rounded_cube_size_corner();
test_rounded_cube_size_center();
test_rounded_cube_size_center_fn();