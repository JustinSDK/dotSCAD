use <unittest.scad>;
use <shape_starburst.scad>;

module test_shape_starburst() {
    echo("==== test_shape_starburst ====");

    expected = [[30, 0], [10.3923, 6], [15, 25.9808], [0, 12], [-15, 25.9808], [-10.3923, 6], [-30, 0], [-10.3923, -6], [-15, -25.9808], [0, -12], [15, -25.9808], [10.3923, -6]];

    actual = shape_starburst(30, 12, 6);

    assertEqualPoints(expected, actual);
}

test_shape_starburst();