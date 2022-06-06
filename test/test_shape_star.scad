use <unittest.scad>
use <shape_star.scad>

module test_shape_star() {
    echo("==== test_shape_star ====");

    expected = [[0, 30], [-6, 10.3923], [-25.9808, 15], [-12, 0], [-25.9808, -15], [-6, -10.3923], [0, -30], [6, -10.3923], [25.9808, -15], [12, 0], [25.9808, 15], [6, 10.3923]];

    actual = shape_star(30, 12, 6);

    assertEqualPoints(expected, actual);
}

test_shape_star();