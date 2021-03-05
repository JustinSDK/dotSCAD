# dedup

Eliminating duplicate copies of repeating vectors. If `lt` has a large number of elements, sorting `lt` first and setting `sorted` to `true` will be faster.

**Since:** 2.3

## Parameters

- `lt` : A list of vectors.
- `eq` : A equality function. If it's ignored, use `==` to compare elements. **Since: ** 3.0
- `hash` : A hash function. If it's ignored, convert each element to a string and hash it. **Since: ** 3.0

## Examples

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

    sorted = sort([[1, 1, 2], [3, 4, 2], [7, 2, 2], [3, 4, 2], [1, 2, 3]]);

    assert(
        dedup(sorted, sorted = true) == [[1, 1, 2], [1, 2, 3], [3, 4, 2], [7, 2, 2]]
    );

    assert(
        dedup(sorted, sorted = true, eq = eq) == [[1, 1, 2], [1, 2, 3], [3, 4, 2], [7, 2, 2]]
    );