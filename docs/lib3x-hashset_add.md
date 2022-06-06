# hashset_add

This function adds an element to a [util/set/hashset](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset.html). It returns a new set containing the added element.

**Since:** 3.0

## Parameters

- `set` : The original set.
- `elem` : Adds the specified element to the specified set.
- `eq` : A equality function. If it's ignored, use `==` to compare elements.
- `hash` : A hash function. If it's ignored, convert each element to a string and hash it. 

## Examples

    use <util/set/hashset.scad>
    use <util/set/hashset_add.scad>
    use <util/set/hashset_has.scad>

    s1 = hashset([1, 2, 3, 4, 5]);
    s2 = hashset_add(s1, 9);
    assert(hashset_has(s2, 9));
