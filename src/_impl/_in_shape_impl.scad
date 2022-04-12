use <__comm__/__in_line.scad>;

function _in_shape_in_line_equation(edge, pt) = 
    let(
        v = edge[1] - edge[0],
        a = v.y / v.x,
        b = edge[0].y - a * edge[0].x
    )
    (pt.y == a * pt.x + b);

function _in_shape_in_any_edges(edges, pt, epsilon) = 
    let(
        leng = len(edges),
        maybe_last = [for(i = 0; i < leng && !__in_line(edges[i], pt, epsilon); i = i + 1) i][leng - 1] 
    )
    is_undef(maybe_last);

function _in_shape_interpolate_x(y, p1, p2) = 
    p1.y == p2.y ? p1.x : (
        p1.x + (p2.x - p1.x) * (y - p1.y) / (p2.y - p1.y)
    );
    
function _in_shape_does_pt_cross(pts, i, j, pt) = 
    ((pts[i].y > pt.y) != (pts[j].y > pt.y)) &&
    (pt.x < _in_shape_interpolate_x(pt.y, pts[i], pts[j]));
    

function _in_shape_sub(shapt_pts, leng, pt, cond, i, j) =
    j == leng ? cond : _in_shape_sub(shapt_pts, leng, pt,  _in_shape_does_pt_cross(shapt_pts, i, j, pt) ? !cond : cond, j, j + 1);
 