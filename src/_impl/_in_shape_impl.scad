use <__comm__/__in_line.scad>;

function _in_shape_in_line_equation(edge, pt) = 
    let(
        x1 = edge[0].x,
        y1 = edge[0].y,
        x2 = edge[1].x,
        y2 = edge[1].y,
        a = (y2 - y1) / (x2 - x1),
        b = y1 - a * x1
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
    j == leng ? cond : (
        _in_shape_does_pt_cross(shapt_pts, i, j, pt) ? 
            _in_shape_sub(shapt_pts, leng, pt, !cond, j, j + 1) :
            _in_shape_sub(shapt_pts, leng, pt, cond, j, j + 1)
    );
 