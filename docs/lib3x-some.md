# some

The `some` function tests whether at least one element in the list passes the test implemented by the provided function. 

**Since:** 3.0

## Parameters

- `lt` : the list.
- `test` : a test function that accepts an element and returns `true` or `false`.

## Examples

    use <util/some.scad>
   
    isOdd = function(elem) elem % 2 == 1;
    assert(some([1, 30, 39, 29, 10, 13], isOdd));