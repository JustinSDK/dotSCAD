use <unittest.scad>
include <rounded_cylinder.scad>

module test_center_half_trapezium(center_pt, shape_pts) {
    h = 25;
    assertEqualPoint([0, 0, h / 2], center_pt);
    
    expected_shape = [[0, -12.5], [15.5689, -12.5], [17.424, -11.8577], [18.4847, -10.2057], [18.3543, -8.3858], [10.7543, 10.6142], [9.469, 12.098], [7.9689, 12.5], [0, 12.5]];
    
    assertEqualPoints(expected_shape, shape_pts);
}

module test_rounded_cylinder() {
    echo("==== test_rounded_cylinder ====");

    h = 25;
    
    rounded_cylinder(
        radius = [20, 10], 
        h = h, 
        round_r = 3
    );        
}

test_rounded_cylinder();
