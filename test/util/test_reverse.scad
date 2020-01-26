use <unittest.scad>;
use <util/reverse.scad>;

module test_reverse() {
    echo("==== test_reverse ====");

    lt = [1, 2, 3, 4, 5];

    assert([5, 4, 3, 2, 1] == reverse(lt)); 
}

test_reverse();