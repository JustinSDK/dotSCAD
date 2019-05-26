include <__private__/__edges_from.scad>;

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
    
function _in_shape_in_edge(edge, pt) =
    let(
        maxx = max([edge[0][0], edge[1][0]]),
        minx = min([edge[0][0], edge[1][0]]),
        maxy = max([edge[0][1], edge[1][1]]),
        miny = min([edge[0][1], edge[1][1]])
    )
    pt[0] >= minx && pt[0] <= maxx && pt[1] >= miny && pt[1] <= maxy &&
    ((edge[1] - edge[0])[0] == 0 ? (pt[0] == edge[0][0]) : _in_shape_in_line_equation(edge, pt));

function _in_shape_in_any_edges_sub(edges, leng, pt, i) = 
    leng == i ? false : (
        _in_shape_in_edge(edges[i], pt) ? true : _in_shape_in_any_edges_sub(edges, leng, pt, i + 1)
    );

function _in_shape_in_any_edges(edges, pt) = _in_shape_in_any_edges_sub(edges, len(edges), pt, 0);
    

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
 
function in_shape(shapt_pts, pt, include_edge = false) = 
    let(
        leng = len(shapt_pts),
        edges = __edges_from(points)
    )
    _in_shape_in_any_edges(edges, pt) ? include_edge : 
    _in_shape_sub(shapt_pts, leng, pt, false, leng - 1, 0);