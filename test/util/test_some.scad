use <util/some.scad>

module test_some() {
    echo("==== test_some ====");

    assert(some([1, 2, 3, 4, 5], function(elem) elem > 3));
    assert(!some([1, 2, 3, 4, 5], function(elem) elem > 5));
}

test_some();