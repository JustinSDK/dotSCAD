# hashmap_put

Puts a key/value pair to a [util/map/hashmap](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap.html).

**Since:** 3.0

## Parameters

- `map` : The original map.
- `key` : The specified key.
- `value` : The specified value.
- `eq` : A equality function. If it's ignored, use `==` to compare elements.
- `hash` : A hash function. If it's ignored, convert each element to a string and hash it. 

## Examples

    use <util/map/hashmap.scad>
    use <util/map/hashmap_put.scad>
    use <util/map/hashmap_get.scad>

    m1 = hashmap([["k1", 10], ["k2", 20], ["k3", 30]]);

    m2 = hashmap_put(m1, "k4", 40);
    assert(hashmap_get(m2, "k4") == 40);