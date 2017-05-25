include <unittest.scad>;

echo("==== test_rounded_square ====");

module test_rounded_square_size_corner() {
    include <rounded_square.scad>;
    
    module test_rounded_square(position, points) {
        assertEqualPoint([25, 25], position);
        assertEqualPoints(
            [[20, -25], [21.9471, -24.6053], [23.5868, -23.4835], [24.6602, -21.8118], [25, -20], [25, 20], [24.6053, 21.9471], [23.4835, 23.5868], [21.8118, 24.6602], [20, 25], [-20, 25], [-21.8118, 24.6602], [-23.4835, 23.5868], [-24.6053, 21.9471], [-25, 20], [-25, -20], [-24.6602, -21.8118], [-23.5868, -23.4835], [-21.9471, -24.6053], [-20, -25]],
            points
        );
    }

    rounded_square(size = 50, corner_r = 5);
}

module test_rounded_square_size_corner_center() {
    include <rounded_square.scad>;
    
    module test_rounded_square(position, points) {
        assertEqualPoint([0, 0], position);
        assertEqualPoints(
             [[20, -12.5], [21.9471, -12.1053], [23.5868, -10.9835], [24.6602, -9.31178], [25, -7.5], [25, 7.5], [24.6053, 9.44709], [23.4835, 11.0868], [21.8118, 12.1602], [20, 12.5], [-20, 12.5], [-21.8118, 12.1602], [-23.4835, 11.0868], [-24.6053, 9.44709], [-25, 7.5], [-25, -7.5], [-24.6602, -9.31178], [-23.5868, -10.9835], [-21.9471, -12.1053], [-20, -12.5]],
            points
        );
    }
    
    rounded_square(
        size = [50, 25],
        corner_r = 5, 
        center = true
    );
}

module test_rounded_square_size_corner_center_fn() {
    include <rounded_square.scad>;
    
    module test_rounded_square(position, points) {
        assertEqualPoint([0, 0], position);
        assertEqualPoints(
             [[20, -12.5], [25, -7.5], [25, 7.5], [20, 12.5], [-20, 12.5], [-25, 7.5], [-25, -7.5], [-20, -12.5]],
            points
        );
    }
    
    $fn = 4;
    rounded_square(
        size = [50, 25],
        corner_r = 5, 
        center = true
    );
}

test_rounded_square_size_corner();
test_rounded_square_size_corner_center();
test_rounded_square_size_corner_center_fn();