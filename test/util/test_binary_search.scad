use <util/sorted.scad>
use <util/binary_search.scad>

module test_binary_search() {
    echo("==== test_binary_search ====");

    points = [[1, 1], [3, 4], [7, 2], [5, 2]];
    lt = sorted(points); // [[1, 1], [3, 4], [5, 2], [7, 2]]

    assert(binary_search(lt, [7, 2]) == 3);

    xIs5 = function(elem) elem[0] - 5;
    assert(binary_search(lt, xIs5) == 2);

    yIs4 = function(elem) elem[1] - 4;
    assert(binary_search(lt, yIs4) == 1);
}

test_binary_search();