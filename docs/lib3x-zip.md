# zip

Make a list that aggregates elements from each of the lists. Returns a list of lists, where the i-th list contains the i-th element from each of the argument lists. The `zip` function stops when the first input list is exhausted. 

**Since:** 2.4

## Parameters

- `lts` : A list of lists.
- `combine` : Rather than listing the elements, the elements are combined using the function. **Since:** 3.0

## Examples

    use <util/zip.scad>
    use <util/sum.scad>

    xs = [10, 20, 30];
    ys = [5, 15, 25];
    zs = [2.5, 7.5, 12.4];

    assert(zip([xs, ys, zs]) == [[10, 5, 2.5], [20, 15, 7.5], [30, 25, 12.4]]);

    sum_up = function(elems) sum(elems);
    assert(zip([xs, ys, zs], sum_up) == [17.5, 42.5, 67.4]);