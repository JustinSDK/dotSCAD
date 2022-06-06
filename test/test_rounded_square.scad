use <unittest.scad>
include <rounded_square.scad>

module test_rounded_square(position, points) {
    assertEqualPoint([25, 25], position);
    assertEqualPoints(
            [[20, -25], [21.9471, -24.6053], [23.5868, -23.4835], [24.6602, -21.8118], [25, -20], [25, 20], [24.6053, 21.9471], [23.4835, 23.5868], [21.8118, 24.6602], [20, 25], [-20, 25], [-21.8118, 24.6602], [-23.4835, 23.5868], [-24.6053, 21.9471], [-25, 20], [-25, -20], [-24.6602, -21.8118], [-23.5868, -23.4835], [-21.9471, -24.6053], [-20, -25]],
        points
    );
}

module test_rounded_square_size_corner() {
    echo("==== test_rounded_square_size_corner ====");
    rounded_square(size = 50, corner_r = 5);
}

test_rounded_square_size_corner();