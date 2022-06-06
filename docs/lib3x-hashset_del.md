# hashset_del

This function dels an element from a [util/set/hashset](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset.html).It returns a new set without the specified element.

**Since:** 3.0

## Parameters

- `set` : The original set.
- `elem` : The element to be deleted.
- `eq` : A equality function. If it's ignored, use `==` to compare elements.
- `hash` : A hash function. If it's ignored, convert each element to a string and hash it. 

## Examples

    use <util/set/hashset.scad>
    use <util/set/hashset_del.scad>
    use <util/set/hashset_has.scad>

    s1 = hashset([1, 2, 3, 4, 5]);
    s2 = hashset_del(s1, 3);
    assert(!hashset_has(s2, 3));
