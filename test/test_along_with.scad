use <unittest.scad>;
use <shape_circle.scad>;
include <along_with.scad>;

module test_along_with_angles(angles, children) {
    if(children == 1) {
        // ==== test_along_with_default_angles  ====
        expected_angles = [[0, 0, 97.5], [0, 0, 97.5], [0, 0, 112.5], [0, 0, 127.5], [0, 0, 142.5], [0, 0, 157.5], [0, 0, 172.5], [0, 0, -172.5], [0, 0, -157.5], [0, 0, -142.5], [0, 0, -127.5], [0, 0, -112.5], [0, 0, -97.5], [0, 0, -82.5], [0, 0, -67.5], [0, 0, -52.5], [0, 0, -37.5], [0, 0, -22.5], [0, 0, -7.5], [0, 0, 7.5], [0, 0, 22.5], [0, 0, 37.5], [0, 0, 52.5], [0, 0, 67.5]];
        assert($fn == len(angles));
        assertEqualPoints(expected_angles, angles);
    }
    else {
        // ==== test_along_with_children ====
        expected_angles = [[0, 0, 97.5], [0, 0, 97.5], [0, 0, 112.5], [0, 0, 127.5], [0, 0, 142.5], [0, 0, 157.5], [0, 0, 172.5], [0, 0, -172.5]];
        assert(8 == len(angles)); 
        assertEqualPoints(expected_angles, angles);
    }
}

module test_along_with_default_angles() {
    echo("==== test_along_with_default_angles  ====");

    $fn = 24;
    points = shape_circle(radius = 50);
    along_with(points, method = "EULER_ANGLE") 
        sphere(5);
}

module test_along_with_children() {
    echo("==== test_along_with_children ====");
    
    $fn = 24;
    points = shape_circle(radius = 50);    
    along_with(points, method = "EULER_ANGLE") {
        linear_extrude(10, center = true) text("A", valign = "center", halign = "center");
        linear_extrude(5, center = true) circle(2);
        sphere(1);
        cube(5);
        linear_extrude(10, center = true) text("A", valign = "center", halign = "center");
        linear_extrude(5, center = true) circle(2);
        sphere(1);
        cube(5);        
    }
}

test_along_with_default_angles();
test_along_with_children();