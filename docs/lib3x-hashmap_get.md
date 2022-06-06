# hashmap_get

This function gets the value of the specified key from a [util/map/hashmap](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap.html). If the key doesn't exist, return `undef`.

**Since:** 3.0

## Parameters

- `map` : The original map.
- `key` : The specified key.
- `eq` : A equality function. If it's ignored, use `==` to compare elements.
- `hash` : A hash function. If it's ignored, convert each element to a string and hash it. 

## Examples

    use <util/map/hashmap.scad>
    use <util/map/hashmap_get.scad>

    m = hashmap([["k1", 10], ["k2", 20], ["k3", 30]]);
    assert(hashmap_get(m, "k2") == 20);