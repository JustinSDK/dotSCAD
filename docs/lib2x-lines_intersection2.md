# lines_intersection2

Find the intersection of two line segments. Return `[]` if lines don't intersect.

**Since:** 2.4

## Parameters

- `line1` : Two points of 2D line1.
- `line2` : Two points of 2D line2.
- `ext` : Default to `false`, which doesn't extend a line to an intersection with another line. 
- `epsilon` : An upper bound on the relative error due to rounding in floating point arithmetic. Default to 0.0001.

## Examples

    use <lines_intersection2.scad>;

    line1 = [[0, 0], [0, 10]];
    line2 = [[5, 0], [-5, 5]];
    line3 = [[5, 0], [2.5, 5]];

    assert(lines_intersection2(line1, line2) == [0, 2.5]);
    assert(lines_intersection2(line1, line3, ext = true) == [0, 10]);
