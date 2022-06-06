# hashset_elems

Returns a list containing all elements in a [util/set/hashset](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset.html). No guarantees to the order.

**Since:** 3.0

## Parameters

- `set` : The set.

## Examples

    use <util/set/hashset.scad>
    use <util/set/hashset_elems.scad>

    s = hashset([1, 2, 3, 4, 5]);
    assert(hashset_elems(s) == [1, 2, 3, 4, 5]); 

