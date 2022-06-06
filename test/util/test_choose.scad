use <util/choose.scad>

module test_choose() {
    echo("==== test_choose ====");

    lt = [[1, true], [2, true], [3, true], [4, true], [5, true]];
    c = choose(lt);
    assert(c[1]);
}

test_choose();