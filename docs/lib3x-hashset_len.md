# hashset_len

Returns the length of the elements in a [util/set/hashset](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset.html).

**Since:** 3.0

## Parameters

- `set` : The set.

## Examples

    use <util/set/hashset.scad>
    use <util/set/hashset_len.scad>

    s = hashset([1, 2, 3, 4, 5]);
    assert(hashset_len(s) == 5);
