use <unittest.scad>
use <contours.scad>

module test_contours() {
    echo("==== test_contours  ====");

    min_value =  1;
    max_value = 360;
    resolution = 10;

    function f(x, y) = sin(x) * cos(y) * 30;

    points = [
        for(y = [min_value:resolution:max_value])
            [
                for(x = [min_value:resolution:max_value]) 
                    [x, y, f(x, y)]
            ]
    ];

    assertEqualPoints([[21, 89.9963, 0], [31, 89.9963, 0]], contours(points, 0)[10]);
    assertEqualPoints( [[11, 31], [11, 41], [1, 41], [1, 31]], contours(points, [0, 5])[10]);
}

test_contours();