use <unittest.scad>;
use <collection/hashmap.scad>;
use <collection/hashmap_list.scad>;
use <collection/hashmap_add.scad>;
use <collection/hashmap_len.scad>;

module test_hashmap() {
    echo("==== test_hashmap ====");

    s = hashmap([
        ["k1234", 1],
        ["k5678", 2],
        ["k9876", 3],
        ["k4444", 3],
    ]);

    assert(hashmap_len(s) == 4);

    assert(hashmap_list(s) == [["k9876", 3], ["k4444", 3], ["k1234", 1], ["k5678", 2]]);
    
    s2 = hashmap_add(s, "k1357", 100);
    assert(hashmap_list(s2) == [["k9876", 3], ["k4444", 3], ["k1234", 1], ["k5678", 2], ["k1357", 100]]);

    s3 = hashmap_add(s2, "k5678", 200);
    assert(hashmap_list(s3) == [["k9876", 3], ["k4444", 3], ["k1234", 1], ["k5678", 200], ["k1357", 100]]);
}

test_hashmap();