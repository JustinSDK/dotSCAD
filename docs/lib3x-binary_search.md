# binary_search

A general-purpose function to search a value in a sorted list.

**Since:**  3.3

## Parameters

- `sorted` : The sorted list.
- `target` : The target element or a function literal that returns a negative integer, zero, or a positive integer as the element is less than, equal to, or greater than the value you want to search.
- `lo` : Default to 0. The lower bound to be searched.
- `hi` : Default to the end of the list. The higher bound to be searched.

## Examples

    use <util/sorted.scad>
    use <util/binary_search.scad>

    points = [[1, 1], [3, 4], [7, 2], [5, 2]];
    lt = sorted(points); // [[1, 1], [3, 4], [5, 2], [7, 2]]

    assert(binary_search(lt, [7, 2]) == 3);

    xIs5 = function(elem) elem[0] - 5;
    assert(binary_search(lt, xIs5) == 2);

    yIs4 = function(elem) elem[1] - 4;
    assert(binary_search(lt, yIs4) == 1);