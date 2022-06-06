# hashmap

This function maps keys to values. You can use the following to process the returned map. 

- [util/map/hashmap_put](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_put.html) : Puts an element to the map. It returns a new map.
- [util/map/hashmap_get](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_get.html) : Returns the value to which the specified key is mapped, or `undef` if the map contains no mapping for the key.
- [util/map/hashmap_del](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_del.html) : Deletes the mapping for the specified key from a map if present.
- [util/map/hashmap_len](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_len.html) : Returns the length of the map.
- [util/map/hashmap_keys](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_keys.html) : Returns a list containing all keys in the map. 
- [util/map/hashmap_values](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_values.html) : Returns a list containing all values in the map. 
- [util/map/hashmap_entries](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_entries.html) : Returns a list containing all `[key, value]`s in the map. 

**Since:** 3.0

## Parameters

- `kv_lt` : Constructs a new map containing the `[key, value]`s in the specified list. It can be ignored if you want an empty map.
- `eq` : A equality function. If it's ignored, use `==` to compare keys.
- `hash` : A hash function. If it's ignored, convert each key to a string and hash it. 
- `number_of_buckets` : The function uses a hash table internally. Change the number of buckets if you're trying to do optimization. 

## Examples

    use <util/map/hashmap.scad>
	use <util/map/hashmap_len.scad>
    use <util/map/hashmap_put.scad>
    use <util/map/hashmap_get.scad>
    use <util/map/hashmap_del.scad>
    use <util/map/hashmap_keys.scad>
    use <util/map/hashmap_values.scad>
	use <util/map/hashmap_entries.scad>

    m1 = hashmap([["k1", 10], ["k2", 20], ["k3", 30]]);
    assert(hashmap_len(m1) == 3);

    m2 = hashmap_put(m1, "k4", 40);
    assert(hashmap_get(m2, "k4") == 40);

    m3 = hashmap_del(m2, "k1");
    assert(hashmap_get(m3, "k1") == undef);

    assert(hashmap_keys(m3) == ["k2", "k3", "k4"]); 
    assert(hashmap_values(m3) == [20, 30, 40]); 
    assert(hashmap_entries(m3) == [["k2", 20], ["k3", 30], ["k4", 40]]);

Want to simulate class-based OO in OpenSCAD? Here's my experiment.

    use <util/map/hashmap.scad>
    use <util/map/hashmap_get.scad>

    function methods(mths) = hashmap(mths);
    function _(name, instance) = hashmap_get(instance, name);

    function clz_list(data) = function(name) _(name,
        methods([
            ["get", function(i) data[i]],
            ["append", function(n) clz_list([each data, n])]
        ])
    );

    lt1 = clz_list([10, 20]);
    assert(lt1("get")(0) == 10);
    assert(lt1("get")(1) == 20);

    lt2 = lt1("append")(30);
    assert(lt2("get")(0) == 10);
    assert(lt2("get")(1) == 20);
    assert(lt2("get")(2) == 30);

