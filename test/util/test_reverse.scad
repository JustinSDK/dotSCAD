use <util/reverse.scad>

module test_reverse() {
    echo("==== test_reverse ====");

    assert([5, 4, 3, 2, 1] == reverse([1, 2, 3, 4, 5])); 
}

test_reverse();