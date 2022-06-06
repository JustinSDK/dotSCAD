use <util/zip.scad>
use <util/sum.scad>

module test_zip() {
    echo("==== test_zip ====");

    xs = [10, 20, 30];
    ys = [5, 15, 25];
    zs = [2.5, 7.5, 12.4];

    assert(zip([xs, ys, zs]) == [[10, 5, 2.5], [20, 15, 7.5], [30, 25, 12.4]]);

    sum_up = function(elems) sum(elems);
    assert(zip([xs, ys, zs], sum_up) == [17.5, 42.5, 67.4]);
}

test_zip();