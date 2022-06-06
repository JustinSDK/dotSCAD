# sorted

Sorts a list. It uses comparison operators between elements by default.

**Since:** 3.3

## Parameters

- `lt` : The original list.
- `cmp` : A function literal that compares its two arguments for order. Returns a negative integer, zero, or a positive integer as the first argument is less than, equal to, or greater than the second.
- `key` : Specifies a function of one argument that is used to extract a comparison key from each element.
- `reverse` : Default to `false`. If set to `true`, then the list elements are sorted as if each comparison were reversed.

## Examples

    use <util/sorted.scad>

    assert([1, 2, 3, 4, 5, 6] == sorted([1, 6, 2, 5, 4, 3]));
    assert([6, 5, 4, 3, 2, 1] == sorted([1, 6, 2, 5, 4, 3], reverse = true));

    assert(["b", "c", "d", "m", "x"] == sorted(["x", "c", "b", "d", "m"]));
    assert(["x", "m", "d", "c", "b"] == sorted(["x", "c", "b", "d", "m"], reverse = true));

    assert(
        [[2, 0, 0], [5, 0, 0], [7, 0, 0], [9, 0, 0], [10, 0, 0]] == 
        sorted([[2, 0, 0], [5, 0, 0], [7, 0, 0], [9, 0, 0], [10, 0, 0]])
    );

    assert(
        [[2, 0, 0], [5, 0, 0], [7, 0, 0], [9, 0, 0], [10, 0, 0]] == 
        sorted([[10, 0, 0], [5, 0, 0], [7, 0, 0], [2, 0, 0], [9, 0, 0]], cmp = function(a, b) a[0] - b[0])
    );

    ascending = function(e1, e2) e1 - e2;
    descending = function(e1, e2) e2 - e1;
    assert(sorted([2, 1, 3, 5, 4], ascending) == [1, 2, 3, 4, 5]);
    assert(sorted([2, 1, 3, 5, 4], ascending, reverse = true) == [5, 4, 3, 2, 1]);
    assert(sorted([2, 1, 3, 5, 4], descending) == [5, 4, 3, 2, 1]);

    assert(
        [[2, 0, 0], [5, 0, 0], [7, 0, 0], [9, 0, 0], [10, 0, 0]] == 
        sorted([[10, 0, 0], [5, 0, 0], [7, 0, 0], [2, 0, 0], [9, 0, 0]], key = function(elem) elem.x)
    );

    assert(
        [[10, 0, 0], [9, 0, 0], [7, 0, 0], [5, 0, 0], [2, 0, 0]] == 
        sorted([[10, 0, 0], [5, 0, 0], [7, 0, 0], [2, 0, 0], [9, 0, 0]], key = function(elem) elem.x, reverse = true)
    );