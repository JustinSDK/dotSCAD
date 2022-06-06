# hashset

This function models the mathematical set, backed by a hash table. You can use the following to process the returned set. 

- [util/set/hashset_add](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_add.html) : Adds an element to the set. It returns a new set.
- [util/set/hashset_has](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_has.html) : Returns `true` if the set contains the specified element. 
- [util/set/hashset_del](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_del.html) : Deletes the specified element. It returns a new set.
- [util/set/hashset_len](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_len.html) : Returns the length of the set.
- [util/set/hashset_elems](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_elems.html) : Returns a list containing all elements in the set. No guarantees to the order.

**Since:** 3.0

## Parameters

- `lt` : Constructs a new set containing the elements in the specified list. It can be ignored if you want an empty set.
- `eq` : A equality function. If it's ignored, use `==` to compare elements.
- `hash` : A hash function. If it's ignored, convert each element to a string and hash it. 
- `number_of_buckets` : The function uses a hash table internally. Change the number of buckets if you're trying to do optimization. 

## Examples

    use <util/set/hashset.scad>
    use <util/set/hashset_add.scad>
    use <util/set/hashset_has.scad>
    use <util/set/hashset_del.scad>
    use <util/set/hashset_len.scad>
    use <util/set/hashset_elems.scad>

    s1 = hashset([1, 2, 3, 4, 5, 2, 3, 5]);
    assert(hashset_len(s1) == 5);

    s2 = hashset_add(s1, 9);
    assert(hashset_has(s2, 9));

    s3 = hashset_del(s2, 2);
    assert(!hashset_has(s3, 2));

    assert(hashset_elems(s3) == [1, 3, 4, 5, 9]); 
