# every

The `every` function tests whether all elements in the list pass the test implemented by the provided function. 

**Since:** 3.0

## Parameters

- `lt` : the list.
- `test` : a test function that accepts an element and returns `true` or `false`.

## Examples

    use <util/every.scad>
   
    biggerThanZero = function(elem) elem > 0;
    assert(every([1, 30, 39, 29, 10, 13], biggerThanZero));