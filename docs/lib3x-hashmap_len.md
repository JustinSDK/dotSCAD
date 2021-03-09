# hashmap_len

This function puts a key/value to a [util/map/hashmap](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap.html). It returns a new map containing the key/value.

**Since:** 3.0

## Parameters

- `map` : The map.

## Examples

    use <util/map/hashmap.scad>;
	use <util/map/hashmap_len.scad>;

    m = hashmap([["k1", 10], ["k2", 20], ["k3", 30]]);
    assert(hashmap_len(m) == 3);