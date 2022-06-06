use <util/sort.scad>
use <util/bsearch.scad>

module test_bsearch() {
    echo("==== test_bsearch ====");

    points = [[1, 1], [3, 4], [7, 2], [5, 2]];
    sorted = sort(points, by = "vt"); //  [[1, 1], [5, 2], [7, 2], [3, 4]]

    assert(bsearch(sorted, [7, 2]) == 2);

    xIs5 = function(elem) elem[0] - 5;
    assert(bsearch(sorted, xIs5) == 1);

    yIs4 = function(elem) elem[1] - 4;
    assert(bsearch(sorted, yIs4) == 3);
}

test_bsearch();