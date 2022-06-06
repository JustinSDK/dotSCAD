use <util/shuffle.scad>

module test_shuffle() {
    echo("==== test_shuffle ====");
    assert(shuffle([1, 2, 3, 4], seed = 1) == [3, 1, 4, 2]);
}

test_shuffle();