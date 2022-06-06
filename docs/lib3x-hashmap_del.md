# hashmap_del

This function deletes the mapping for the specified key from a [util/map/hashmap](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap.html) if present. It returns a new map without the key/value.

**Since:** 3.0

## Parameters

- `map` : The original map.
- `key` : The specified key.
- `eq` : A equality function. If it's ignored, use `==` to compare elements.
- `hash` : A hash function. If it's ignored, convert each element to a string and hash it. 

## Examples

    use <util/map/hashmap.scad>
    use <util/map/hashmap_get.scad>
    use <util/map/hashmap_del.scad>

    m1 = hashmap([["k1", 10], ["k2", 20], ["k3", 30]]);
    m2 = hashmap_del(m1, "k1");
    assert(hashmap_get(m2, "k1") == undef);