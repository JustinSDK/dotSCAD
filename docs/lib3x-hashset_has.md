# hashset_has

Returns `true` if a [util/set/hashset](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset.html) contains the specified element. 

**Since:** 3.0

## Parameters

- `set` : The original set.
- `elem` : The element to be checked.
- `eq` : A equality function. If it's ignored, use `==` to compare elements.
- `hash` : A hash function. If it's ignored, convert each element to a string and hash it. 

## Examples

    use <util/set/hashset.scad>
    use <util/set/hashset_has.scad>

    s = hashset([1, 2, 3, 4, 5]);
    assert(hashset_has(s, 3));
