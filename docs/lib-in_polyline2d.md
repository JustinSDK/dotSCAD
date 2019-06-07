# in_polyline2d

Checks wether a point is on a line.

**Since:** 1.3

## Parameters

- `line_pts` : The line points.
- `pt` : The point to be checked.
- `epsilon` : An upper bound on the relative error due to rounding in floating point arithmetic. Default to 0.0001.

## Examples

    include <in_polyline2d.scad>;

    pts = [
        [0, 0],
        [10, 0],
        [10, 10]
    ];

    echo(in_polyline2d(pts, [-2, -3]));  // false
    echo(in_polyline2d(pts, [5, 0]));    // true
    echo(in_polyline2d(pts, [10, 5]));   // true
    echo(in_polyline2d(pts, [10, 15]));  // false