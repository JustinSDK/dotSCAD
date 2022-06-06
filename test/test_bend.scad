use <unittest.scad>
include <bend.scad>
 
module test_bend_tri_frag(points, angle) {
    expected_points = [[0, 0], [0.1927, 1.9566], [0.3854, 0], [0, 0]];
    expected_angle = 11.25;
    
    assertEqualPoints(expected_points, points);
    assertEqualNum(expected_angle, angle);
}

module test_bend() {
    echo("==== test_bend_tri_frag ====");
    x = 9.25;
    y = 9.55;
    z = 1;  

    bend(size = [x, y, z], angle = 270)
        linear_extrude(z) text("A");
}

test_bend();