# find_index

Returns the index of the first element in the list that satisfies the testing function. If no element passed the test, it returns -1.

**Since:** 3.0

## Parameters

- `lt` : The list.
- `test` : the testing function.

## Examples

    use <util/find_index.scad>
    
    assert(find_index([10, 20, 30, 40], function(e) e > 10) == 1);