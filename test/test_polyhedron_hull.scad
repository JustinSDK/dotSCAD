include <polyhedron_hull.scad>

module test_polyhedron_hull() {
    echo("==== test_polyhedron_hull ====");
    polyhedron_hull([
        [1, 1, 1],
        [1, 1, 0],
        [-1, 1, 0],
        [-1, -1, 0],
        [1, -1, 0],
        [0, 0, 1],
        [0, 0, -1]
    ]);
}


module test_convex_hull3(vts_faces) {
    assert(vts_faces ==  [[[-1, -1, 0], [-1, 1, 0], [0, 0, -1], [0, 0, 1], [1, -1, 0], [1, 1, 0], [1, 1, 1]], [[2, 1, 0], [3, 0, 1], [4, 2, 0], [4, 0, 3], [5, 1, 2], [5, 2, 4], [6, 3, 1], [6, 1, 5], [6, 4, 3], [6, 5, 4]]]);
}

test_polyhedron_hull();