# lines_intersection

Find the intersection of two line segments. Return `[]` if lines don't intersect.

**Since:** 2.4

## Parameters

- `line1` : Two points of 2D or 3D line1.
- `line2` : Two points of 2D or 3D line2.
- `ext` : Default to `false`, which doesn't extend a line to an intersection with another line. 
- `epsilon` : An upper bound on the relative error due to rounding in floating point arithmetic. Default to 0.0001.

## Examples

    use <lines_intersection.scad>

    line1 = [[0, 0], [0, 10]];
    line2 = [[5, 0], [-5, 5]];
    line3 = [[5, 0], [2.5, 5]];

    assert(lines_intersection(line1, line2) == [0, 2.5]);
    assert(lines_intersection(line1, line3, ext = true) == [0, 10]);

    line4 = [[0, 0, 0], [10, 10, 10]];
    line5 = [[10, 0, 0], [0, 10, 10]];
    assert(lines_intersection(line4, line5) == [5, 5, 5]);