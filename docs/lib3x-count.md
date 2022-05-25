# count

Returns the number of times `test` return `true` in the list.

**Since:** 3.3

## Parameters

- `lt` : The list.
- `test` : A testing function.

## Examples

    points = [[7, 2, 2], [1, 1, 2], [3, 4, 2], [3, 4, 2], [1, 2, 3]];
    assert(count(points, function(p) norm(p) > 5) == 3);