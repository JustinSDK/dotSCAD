include <unittest.scad>;
include <shape_trapezium.scad>;

echo("==== test_shape_trapezium ====");

expected = [[16.7639, -10], [18.4469, -9.0806], [18.5825, -7.1677], [18.5528, -7.10557], [10.5528, 8.89443], [8.97782, 9.98853], [8.76393, 10], [-8.76393, 10], [-8.97782, 9.98853], [-10.5528, 8.89443], [-18.5528, -7.10557], [-18.5825, -7.1677], [-18.4469, -9.0806], [-16.7639, -10]];

actual = shape_trapezium(
    [40, 20], 
    h = 20,
    corner_r = 2
);

assertEqualPoints(expected, actual);

