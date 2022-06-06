use <util/swap.scad>

module test_swap() {
    echo("==== test_swap ====");
    
    assert(swap([10, 20, 30, 40], 1, 3) == [10, 40, 30, 20]);
}

test_swap();