# zip

Make a list that aggregates elements from each of the lists. Returns a list of lists, where the i-th list contains the i-th element from each of the argument lists. The `zip` function stops when the first input list is exhausted. 

**Since:** 2.4

## Parameters

- `lts` : a list of lists.

## Examples

    use <util/zip.scad>;

    xs = [10, 20, 30];
    ys = [5, 15, 25];
    zs = [2.5, 7.5, 12.4];

    assert(zip([xs, ys, zs]) == [[10, 5, 2.5], [20, 15, 7.5], [30, 25, 12.4]]);