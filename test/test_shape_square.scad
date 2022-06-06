use <unittest.scad>
use <shape_square.scad>

module test_shape_square() {
    echo("==== test_shape_square ====");

    expected = [[20, -25], [21.9471, -24.6053], [23.5868, -23.4835], [24.6602, -21.8118], [25, -20], [25, 20], [24.6053, 21.9471], [23.4835, 23.5868], [21.8118, 24.6602], [20, 25], [-20, 25], [-21.8118, 24.6602], [-23.4835, 23.5868], [-24.6053, 21.9471], [-25, 20], [-25, -20], [-24.6602, -21.8118], [-23.5868, -23.4835], [-21.9471, -24.6053], [-20, -25]];

    actual = shape_square(size = 50, corner_r = 5);

    assertEqualPoints(expected, actual);
}

test_shape_square();