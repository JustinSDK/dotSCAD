use <util/count.scad>

module test_count() {
    echo("==== test_count ====");

    points = [[7, 2, 2], [1, 1, 2], [3, 4, 2], [3, 4, 2], [1, 2, 3]];
    assert(count(points, function(p) norm(p) > 5) == 3);
}

test_count();