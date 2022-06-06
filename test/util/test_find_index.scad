use <util/find_index.scad>

module test_find_index() {
    echo("==== test_find_index ====");
    assert(find_index([10, 20, 30, 40], function(e) e > 10) == 1);
    assert(find_index([10, 20, 30, 40], function(e) e > 50) == -1);
}

test_find_index();