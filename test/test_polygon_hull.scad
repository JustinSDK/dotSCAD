include <polygon_hull.scad>

module test_polygon_hull() {
    echo("==== test_polygon_hull ====");
    polygon_hull([
        [1, 1],
        [1, 0],
        [0, 1],
        [-2, 1],
        [-1, -1]
    ]);
}


module test_convex_hull2(poly) {
    assert(poly == [[-2, 1], [-1, -1], [1, 0], [1, 1]]);
}

test_polygon_hull();