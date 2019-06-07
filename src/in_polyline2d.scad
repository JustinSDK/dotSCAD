include <__private__/__in_line2d.scad>;

function _in_polyline2d_sub(line_pts, pt, epsilon, iend, i = 0) = 
    i == iend ? false : (
        __in_line2d([line_pts[i], line_pts[i + 1]], pt, epsilon) ? true :
            _in_polyline2d_sub(line_pts, pt, epsilon, iend, i + 1)
    );

function in_polyline2d(line_pts, pt, epsilon = 0.0001) = _in_polyline2d_sub(line_pts, pt, epsilon, len(line_pts) - 1);
    