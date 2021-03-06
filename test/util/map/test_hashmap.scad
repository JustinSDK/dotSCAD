use <util/map/hashmap.scad>;
use <util/map/hashmap_entries.scad>;
use <util/map/hashmap_put.scad>;
use <util/map/hashmap_len.scad>;
use <util/map/hashmap_del.scad>;
use <util/map/hashmap_get.scad>;

module test_hashmap() {
    echo("==== test_hashmap ====");

    s = hashmap([
        ["k1234", 1],
        ["k5678", 2],
        ["k9876", 3],
        ["k4444", 3],
    ]);

    assert(hashmap_len(s) == 4);

    assert(hashmap_entries(s) == [["k9876", 3], ["k4444", 3], ["k1234", 1], ["k5678", 2]]);
    
    s2 = hashmap_put(s, "k1357", 100);
    assert(hashmap_entries(s2) == [["k9876", 3], ["k4444", 3], ["k1234", 1], ["k5678", 2], ["k1357", 100]]);

    s3 = hashmap_put(s2, "k5678", 200);
    assert(hashmap_entries(s3) == [["k9876", 3], ["k4444", 3], ["k1234", 1], ["k5678", 200], ["k1357", 100]]);

    s4 = hashmap_del(s3, "k4444");
    assert(hashmap_entries(s4) == [["k9876", 3], ["k1234", 1], ["k5678", 200], ["k1357", 100]]);
    assert(hashmap_entries(hashmap_del(s4, "k4444")) == [["k9876", 3], ["k1234", 1], ["k5678", 200], ["k1357", 100]]);    

    assert(hashmap_get(s4, "k1234") == 1);
    assert(hashmap_get(s4, "k0000") == undef);
}

test_hashmap();