# bsearch

The `bsearch` function is a general-purpose function to search a value in a list whose elements must be sorted by zyx (from the last index to the first one).

**Since:**  3.0

## Parameters

- `sorted` : The sorted list.
- `target` : The target vector or a function literal that returns a negative integer, zero, or a positive integer as the element is less than, equal to, or greater than the value you want to search.

## Examples

	use <util/sort.scad>
	use <util/bsearch.scad>

    points = [[1, 1], [3, 4], [7, 2], [5, 2]];
    sorted = sort(points, by = "vt"); //  [[1, 1], [5, 2], [7, 2], [3, 4]]

    assert(bsearch(sorted, [7, 2]) == 2);

    xIs5 = function(elem) elem[0] - 5;
    assert(bsearch(sorted, xIs5) == 1);

    yIs4 = function(elem) elem[1] - 4;
    assert(bsearch(sorted, yIs4) == 3);