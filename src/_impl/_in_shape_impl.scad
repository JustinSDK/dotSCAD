use <__comm__/__in_line.scad>;

function _in_shape_in_line_equation(edge, pt) = 
    let(
        p0 = edge[0],
        v = edge[1] - p0
    )
    pt.y == (v.y / v.x) * (pt.x - p0.x) + p0.y;

function _in_shape_in_any_edges(edges, pt, epsilon) = 
    let(
        leng = len(edges),
        maybe_last = [for(i = 0; i < leng && !__in_line(edges[i], pt, epsilon); i = i + 1) i][leng - 1] 
    )
    is_undef(maybe_last);

function _in_shape_interpolate_x(y, p1, p2) = 
    p1.y == p2.y ? p1.x : 
    let(v = p2 - p1) p1.x + v.x * (y - p1.y) / v.y;
    
function _in_shape_does_pt_cross(pts, i, j, pt) = 
    let(pi = pts[i], pj = pts[j])
    ((pi.y - pt.y) * (pj.y - pt.y) < 0) && (pt.x < _in_shape_interpolate_x(pt.y, pi, pj));
    
function _in_shape_sub(shapt_pts, leng, pt, cond, i, j) =
    j == leng ? cond : _in_shape_sub(shapt_pts, leng, pt,  _in_shape_does_pt_cross(shapt_pts, i, j, pt) ? !cond : cond, j, j + 1);
 