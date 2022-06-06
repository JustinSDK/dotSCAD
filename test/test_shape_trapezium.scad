use <unittest.scad>
use <shape_trapezium.scad>

module test_shape_trapezium() {
    echo("==== test_shape_trapezium ====");

    expected = [[16.7639, -10], [18.4469, -9.0806], [18.5825, -7.1677], [18.5528, -7.1056], [10.5528, 8.8944], [8.9778, 9.9885], [8.7639, 10], [-8.7639, 10], [-8.9778, 9.9885], [-10.5528, 8.8944], [-18.5528, -7.1056], [-18.5825, -7.1677], [-18.4469, -9.0806], [-16.7639, -10]];

    actual = shape_trapezium(
        [40, 20], 
        h = 20,
        corner_r = 2
    );

    assertEqualPoints(expected, actual);
}

test_shape_trapezium();
