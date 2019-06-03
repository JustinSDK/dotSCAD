# in_line

Checks wether a point is on a line.

**Since:** 1.3

## Parameters

- `line_pts` : The line points.
- `pt` : The point to be checked.
- `epsilon` : An upper bound on the relative error due to rounding in floating point arithmetic. Default to 0.0001.

## Examples

    include <in_line.scad>;

    pts = [
        [0, 0],
        [10, 0],
        [10, 10]
    ];

    echo(in_line(pts, [-2, -3]));  // false
    echo(in_line(pts, [5, 0]));    // true
    echo(in_line(pts, [10, 5]));   // true
    echo(in_line(pts, [10, 15]));  // false