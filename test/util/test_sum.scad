use <util/sum.scad>

module test_sum() {
    echo("==== test_sum ====");
    
    assert(sum([1, 2, 3, 4, 5]) == 15);
    assert(sum([[1, 2, 3], [4, 5, 6]]) == [5, 7, 9]);
}

test_sum();