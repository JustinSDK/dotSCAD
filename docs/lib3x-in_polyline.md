# in_polyline

Checks whether a point is on a line.

**Since:** 1.3

## Parameters

- `line_pts` : The line points.
- `pt` : The point to be checked.
- `epsilon` : An upper bound on the relative error due to rounding in floating point arithmetic. Default to 0.0001.

## Examples

    use <in_polyline.scad>;

    pts = [
        [0, 0],
        [10, 0],
        [10, 10]
    ];

    echo(in_polyline(pts, [-2, -3]));  // false
    echo(in_polyline(pts, [5, 0]));    // true
    echo(in_polyline(pts, [10, 5]));   // true
    echo(in_polyline(pts, [10, 15]));  // false

----

    use <in_polyline.scad>;

    pts = [
        [10, 0, 10],
        [20, 0, 10],
        [20, 10, 10]
    ]; 

    echo(in_polyline(pts, [10, 0, 10]));  // true
    echo(in_polyline(pts, [15, 0, 10]));  // true
    echo(in_polyline(pts, [15, 1, 10]));  // false
    echo(in_polyline(pts, [20, 11, 10])); // false    