include <__private__/__edges_from.scad>;
include <__private__/__in_line.scad>;

function _in_shape_in_line_equation(edge, pt) = 
    let(
        x1 = edge[0][0],
        y1 = edge[0][1],
        x2 = edge[1][0],
        y2 = edge[1][1],
        a = (y2 - y1) / (x2 - x1),
        b = y1 - a * x1
    )
    (pt[1] == a * pt[0] + b);

function _in_shape_in_any_edges_sub(edges, leng, pt, i, epsilon) = 
    leng == i ? false : (
        __in_line(edges[i], pt, epsilon) ? true : _in_shape_in_any_edges_sub(edges, leng, pt, i + 1, epsilon)
    );

function _in_shape_in_any_edges(edges, pt, epsilon) = _in_shape_in_any_edges_sub(edges, len(edges), pt, 0, epsilon);
    
function _in_shape_interpolate_x(y, p1, p2) = 
    p1[1] == p2[1] ? p1[0] : (
        p1[0] + (p2[0] - p1[0]) * (y - p1[1]) / (p2[1] - p1[1])
    );
    
function _in_shape_does_pt_cross(pts, i, j, pt) = 
    ((pts[i][1] > pt[1]) != (pts[j][1] > pt[1])) &&
    (pt[0] < _in_shape_interpolate_x(pt[1], pts[i], pts[j]));
    

function _in_shape_sub(shapt_pts, leng, pt, cond, i, j) =
    j == leng ? cond : (
        _in_shape_does_pt_cross(shapt_pts, i, j, pt) ? 
            _in_shape_sub(shapt_pts, leng, pt, !cond, j, j + 1) :
            _in_shape_sub(shapt_pts, leng, pt, cond, j, j + 1)
    );
 
function in_shape(shapt_pts, pt, include_edge = false, epsilon = 0.0001) = 
    let(
        leng = len(shapt_pts),
        edges = __edges_from(points, true)
    )
    _in_shape_in_any_edges(edges, pt, epsilon) ? include_edge : 
    _in_shape_sub(shapt_pts, leng, pt, false, leng - 1, 0);