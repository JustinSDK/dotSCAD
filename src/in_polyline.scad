include <__private__/__to3d.scad>;
include <__private__/__in_line2d.scad>;

function _in_polyline_sub(pts, pt, epsilon, iend, i = 0) = 
    i == iend ? false : (
        __in_line2d([pts[i], pts[i + 1]], pt, epsilon) ? true :
            _in_polyline_sub(pts, pt, epsilon, iend, i + 1)
    );

function in_polyline(line_pts, pt, epsilon = 0.0001) = 
    let(
        pts = len(line_pts[0]) == 2 ? [for(pt = line_pts) __to3d(pt)] : line_pts,
        pt3d = len(pt) == 2 ? __to3d(pt) : pt
    )
    _in_polyline_sub(pts, pt3d, epsilon, len(pts) - 1);
    