use <util/set/hashset.scad>
use <util/set/hashset_elems.scad>
use <util/set/hashset_add.scad>
use <util/set/hashset_del.scad>
use <util/set/hashset_has.scad>
use <util/set/hashset_len.scad>

module test_hashset() {
    echo("==== test_hashset ====");

    s = hashset([1, 2, 3, 4, 5, 2, 3, 5]);
    assert(hashset_elems(s) == [1, 2, 3, 4, 5]);
    assert(hashset_len(s) == 5);

    s2 = hashset_add(s, 9);
    assert(hashset_elems(s2) == [1, 2, 3, 4, 5, 9]);

    assert(!hashset_has(s2, 13));
    
    assert(hashset_elems(hashset_del(s2, 2)) == [1, 3, 4, 5, 9]);
}

test_hashset();