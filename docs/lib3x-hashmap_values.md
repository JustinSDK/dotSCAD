# hashmap_values

Returns a list containing all values in a [util/map/hashmap](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap.html). 

**Since:** 3.0

## Parameters

- `map` : The map.

## Examples

    use <util/map/hashmap.scad>
    use <util/map/hashmap_values.scad>

    m = hashmap([["k1", 10], ["k2", 20], ["k3", 30]]);

    echo(hashmap_values(m));    // a list contains 10, 20, 30
