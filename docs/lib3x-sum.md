# sum

Use `+` to sum up all elements in a list.

**Since:** 2.4

## Parameters

- `lt` : a list of elements that can be applied by `+`.

## Examples

    use <util/sum.scad>

    assert(sum([1, 2, 3, 4, 5]) == 15);
    assert(sum([[1, 2, 3], [4, 5, 6]]) == [5, 7, 9]);
