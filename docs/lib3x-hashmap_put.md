# hashmap_put

This function returns the length of a [util/map/hashmap](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap.html).

**Since:** 3.0

## Parameters

- `map` : The original map.

## Examples

    use <util/map/hashmap.scad>;
    use <util/map/hashmap_put.scad>;
    use <util/map/hashmap_get.scad>;

    m1 = hashmap([["k1", 10], ["k2", 20], ["k3", 30]]);

    m2 = hashmap_put(m1, "k4", 40);
    assert(hashmap_get(m2, "k4") == 40);