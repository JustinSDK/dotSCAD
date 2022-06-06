use <angle_between.scad>

module test_angle_between() {
    echo("==== test_angle_between  ====");
    assert(angle_between([0, 1], [1, 0]) == 90);
    assert(angle_between([0, 1, 0], [1, 0, 0]) == 90);
    assert(round(angle_between([1, 1, 0], [1, 1, sqrt(2)])) == 45);
}

test_angle_between();