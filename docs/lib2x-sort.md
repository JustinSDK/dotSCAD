# sort

Sorts the elements of a list in ascending order. The list is a list-of-list construct, such as `[[a0, a1, a2...], [b0, b1, b2,...], [c0, c1, c2,...],...]`. When sorting, the function looks only at one index position of each sublist. 

From dotSCAD 2.3, when `by` is `"vt"`, it will sort points by zyx (from the last index to the first one).

**Since:** 2.0

## Parameters

- `lt` : The original list.
- `by` : Can be `"x"`、`"y"`、`"z"`, `"idx"` (Default) or `"vt"`. 
- `idx` : When `by` is `"idx"`, the value of `idx` is used. The Default value is 0.

## Examples

    use <util/sort.scad>;

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