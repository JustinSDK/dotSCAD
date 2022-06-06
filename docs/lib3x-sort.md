# sort

Sorts the elements of a list in ascending order. The list is a list-of-list construct, such as `[[a0, a1, a2...], [b0, b1, b2,...], [c0, c1, c2,...],...]`. When sorting, the function looks only at one index position of each sublist. 

**Since:** 2.0

## Parameters

- `lt` : The original list.
- `by` : Can be `"x"`、`"y"`、`"z"`, or `"idx"` (Default). `"vt"`. From dotSCAD 2.3, when `by` is `"vt"`, it will sort points by zyx (from the last index to the first one). From dotSCAD 3.0, `by` supports a function literal that compares its two arguments for order. Returns a negative integer, zero, or a positive integer as the first argument is less than, equal to, or greater than the second.
- `idx` : When `by` is `"idx"`, the value of `idx` is used. The Default value is 0.

## Examples

    use <util/sort.scad>

    assert(
        [[2, 0, 0], [5, 0, 0], [7, 0, 0], [9, 0, 0], [10, 0, 0]] == 
        sort([[10, 0, 0], [5, 0, 0], [7, 0, 0], [2, 0, 0], [9, 0, 0]])
    );

    assert(
        [[2, 0, 0], [5, 0, 0], [7, 0, 0], [9, 0, 0], [10, 0, 0]] == 
        sort([[10, 0, 0], [5, 0, 0], [7, 0, 0], [2, 0, 0], [9, 0, 0]], by = "x")
    );

    assert(
        [[0, 2, 0], [0, 5, 0], [0, 7, 0], [0, 9, 0], [0, 10, 0]] == 
        sort([[0, 10, 0], [0, 5, 0], [0, 7, 0], [0, 2, 0], [0, 9, 0]], by = "idx", idx = 1)
    );

    ascending = function(e1, e2) e1 - e2;
    descending = function(e1, e2) e2 - e1;
    assert(sort([2, 1, 3, 5, 4], by = ascending) == [1, 2, 3, 4, 5]);
    assert(sort([2, 1, 3, 5, 4], by = descending) == [5, 4, 3, 2, 1]);