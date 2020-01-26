include <unittest.scad>;
include <util/sort.scad>;

module test_sort() {
    echo("==== test_sort ====");

    assertEqualPoints(
        [[2, 0, 0], [5, 0, 0], [7, 0, 0], [9, 0, 0], [10, 0, 0]], 
        sort([[10, 0, 0], [5, 0, 0], [7, 0, 0], [2, 0, 0], [9, 0, 0]], by = "x")
    );

    assertEqualPoints(
        [[2, 0, 0], [5, 0, 0], [7, 0, 0], [9, 0, 0], [10, 0, 0]], 
        sort([[10, 0, 0], [5, 0, 0], [7, 0, 0], [2, 0, 0], [9, 0, 0]], by = "idx", idx = 0)
    );

    assertEqualPoints(
        [[0, 2, 0], [0, 5, 0], [0, 7, 0], [0, 9, 0], [0, 10, 0]], 
        sort([[0, 10, 0], [0, 5, 0], [0, 7, 0], [0, 2, 0], [0, 9, 0]], by = "y")
    );
}

test_sort();
