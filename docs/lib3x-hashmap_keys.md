# hashmap_keys

Returns a list containing all keys in a [util/map/hashmap](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap.html). 

**Since:** 3.0

## Parameters

- `map` : The map.

## Examples

    use <util/map/hashmap.scad>
    use <util/map/hashmap_keys.scad>

    m = hashmap([["k1", 10], ["k2", 20], ["k3", 30]]);

    echo(hashmap_keys(m));    // a list contains "k1", "k2", "k3"
