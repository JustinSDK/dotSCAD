use <util/every.scad>

module test_every() {
    echo("==== test_every ====");

    assert(every([1, 2, 3, 4, 5], function(elem) elem > 0));
    assert(!every([1, 2, 3, 4, 5], function(elem) elem > 3));
}

test_every();