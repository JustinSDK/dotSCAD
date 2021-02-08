use <util/dedup.scad>;
use <util/sort.scad>;

module test_dedup() {
    echo("==== test_dedup ====");

    points = [[1, 1, 2], [3, 4, 2], [7, 2, 2], [3, 4, 2], [1, 2, 3]];
    assert(
        dedup([[1, 1, 2], [3, 4, 2], [7, 2, 2], [3, 4, 2], [1, 2, 3]]) 
            == [[1, 1, 2], [3, 4, 2], [7, 2, 2], [1, 2, 3]]
    );
    
    assert(
        dedup(sort([[1, 1, 2], [3, 4, 2], [7, 2, 2], [3, 4, 2], [1, 2, 3]]), sorted = true) 
            == [[1, 1, 2], [1, 2, 3], [3, 4, 2], [7, 2, 2]]
    );
}

test_dedup();