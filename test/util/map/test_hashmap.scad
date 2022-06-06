use <util/map/hashmap.scad>
use <util/map/hashmap_entries.scad>
use <util/map/hashmap_keys.scad>
use <util/map/hashmap_values.scad>
use <util/map/hashmap_put.scad>
use <util/map/hashmap_len.scad>
use <util/map/hashmap_del.scad>
use <util/map/hashmap_get.scad>

module test_hashmap() {
    echo("==== test_hashmap ====");

    m = hashmap([
        ["k1234", 1],
        ["k5678", 2],
        ["k9876", 3],
        ["k4444", 3],
    ]);

    assert(hashmap_len(m) == 4);

    assert(hashmap_keys(m) == ["k9876", "k4444", "k1234", "k5678"]);
    assert(hashmap_values(m) == [3, 3, 1, 2]);

    assert(hashmap_entries(m) == [["k9876", 3], ["k4444", 3], ["k1234", 1], ["k5678", 2]]);
    
    m2 = hashmap_put(m, "k1357", 100);
    assert(hashmap_entries(m2) == [["k9876", 3], ["k4444", 3], ["k1234", 1], ["k5678", 2], ["k1357", 100]]);

    m3 = hashmap_put(m2, "k5678", 200);
    assert(hashmap_entries(m3) == [["k9876", 3], ["k4444", 3], ["k1234", 1], ["k5678", 200], ["k1357", 100]]);

    m4 = hashmap_del(m3, "k4444");
    assert(hashmap_entries(m4) == [["k9876", 3], ["k1234", 1], ["k5678", 200], ["k1357", 100]]);
    assert(hashmap_entries(hashmap_del(m4, "k4444")) == [["k9876", 3], ["k1234", 1], ["k5678", 200], ["k1357", 100]]);    

    assert(hashmap_get(m4, "k1234") == 1);
    assert(hashmap_get(m4, "k0000") == undef);
}

test_hashmap();