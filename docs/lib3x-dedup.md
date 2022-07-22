# dedup

Eliminating duplicate copies of repeating vectors. 

**Since:** 2.3

## Parameters

- `lt` : A list of vectors.
- `eq` : A equality function. If it's ignored, use `==` to compare elements. **Since: ** 3.0
- `hash` : A hash function. If it's ignored, convert each element to a string and hash it. **Since: ** 3.0
- `number_of_buckets` : The function uses a hash table internally. Change the number of buckets if you're trying to do optimization. **Since: ** 3.0

## Examples

    use <util/dedup.scad>

    eq = function(e1, e2) e1[0] == e2[0] && e1[1] == e2[1] && e1[2] == e2[2];

    points = [[1, 1, 2], [3, 4, 2], [7, 2, 2], [3, 4, 2], [1, 2, 3]];
    assert(
        dedup([[1, 1, 2], [3, 4, 2], [7, 2, 2], [3, 4, 2], [1, 2, 3]]) 
            == [[1, 1, 2], [3, 4, 2], [7, 2, 2], [1, 2, 3]]
    );

    assert(
        dedup([[1, 1, 2], [3, 4, 2], [7, 2, 2], [3, 4, 2], [1, 2, 3]], eq = eq) 
            == [[1, 1, 2], [3, 4, 2], [7, 2, 2], [1, 2, 3]]
    );