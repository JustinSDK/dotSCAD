use <__comm__/__in_line.scad>;

function _in_shape_in_any_edges(edges, pt, epsilon) = 
    let(
        leng = len(edges),
        maybe_last = [for(i = 0; i < leng && !__in_line(edges[i], pt, epsilon); i = i + 1) i][leng - 1] 
    )
    is_undef(maybe_last);

function _in_shape_interpolate_x(y, p1, p2) = 
    lookup(y, [[p1.y, p1.x], [p2.y, p2.x]]);
    
function _in_shape_does_pt_cross(pi, pj, pt) = 
    ((pi.y - pt.y) * (pj.y - pt.y) < 0) && (pt.x < _in_shape_interpolate_x(pt.y, pi, pj));
    
function _in_shape_sub(shapt_pts, leng, pt, cond, i) =
    let(j = i + 1)
    j == leng ? cond : _in_shape_sub(shapt_pts, leng, pt, _in_shape_does_pt_cross(shapt_pts[i], shapt_pts[j], pt) ? !cond : cond, j);
 