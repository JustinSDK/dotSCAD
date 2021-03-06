use <collection/hashset.scad>;
use <collection/hashset_list.scad>;
use <collection/hashset_add.scad>;
use <collection/hashset_del.scad>;
use <collection/hashset_has.scad>;
use <collection/hashset_len.scad>;

module test_hashset() {
    echo("==== test_hashset ====");

    s = hashset([1, 2, 3, 4, 5, 2, 3, 5]);
    assert(hashset_list(s) == [1, 2, 3, 4, 5]);
    assert(hashset_len(s) == 5);

    s2 = hashset_add(s, 9);
    assert(hashset_list(s2) == [1, 2, 3, 4, 5, 9]);

    assert(!hashset_has(s2, 13));
    
    assert(hashset_list(hashset_del(s2, 2)) == [1, 3, 4, 5, 9]);
}

test_hashset();