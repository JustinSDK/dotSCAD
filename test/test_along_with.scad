include <unittest.scad>;

module test_along_with_default_angles() {
    echo("==== test_along_with_default_angles  ====");

    include <along_with.scad>;
    include <circle_path.scad>;

    $fn = 24;

    points = circle_path(radius = 50);
    
    module test_along_with_angles(angles) {
        expected_angles = [[0, 0, 97.5], [0, 0, 97.5], [0, 0, 112.5], [0, 0, 127.5], [0, 0, 142.5], [0, 0, 157.5], [0, 0, 172.5], [0, 0, -172.5], [0, 0, -157.5], [0, 0, -142.5], [0, 0, -127.5], [0, 0, -112.5], [0, 0, -97.5], [0, 0, -82.5], [0, 0, -67.5], [0, 0, -52.5], [0, 0, -37.5], [0, 0, -22.5], [0, 0, -7.5], [0, 0, 7.5], [0, 0, 22.5], [0, 0, 37.5], [0, 0, 52.5], [0, 0, 67.5]];
        
        assertEqual($fn, len(angles));
        assertEqualPoints(expected_angles, angles);
        
    }

    along_with(points) 
        sphere(5, center = true);

}

module test_along_with_children() {
    echo("==== test_along_with_children  ====");

    include <along_with.scad>;
    include <circle_path.scad>;

    $fn = 24;

    points = circle_path(radius = 50);
    
    module test_along_with_angles(angles) {
        expected_angles = [[0, 0, 97.5], [0, 0, 97.5], [0, 0, 112.5], [0, 0, 127.5], [0, 0, 142.5], [0, 0, 157.5], [0, 0, 172.5], [0, 0, -172.5]];
        
        assertEqual(8, len(angles)); 
        assertEqualPoints(expected_angles, angles);

    }

    along_with(points) {
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