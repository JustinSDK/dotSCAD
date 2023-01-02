use <../__comm__/__in_line.scad>

function _in_any_edges(edges, pt, epsilon) = 
    let( 
        leng = len(edges),
        maybe_last = [for(i = 0; i < leng && !__in_line(edges[i], pt, epsilon); i = i + 1) i][leng - 1] 
    )
    is_undef(maybe_last);

function _does_pt_cross(pi, pj, pt) = 
    ((pi.y - pt.y) * (pj.y - pt.y) < 0) && (pt.x < lookup(pt.y, [[pi.y, pi.x], [pj.y, pj.x]]));
    
function _in_shape_sub(shapt_pts, leng, pt, cond, i = 0) =
    let(j = i + 1)
    j == leng ? cond : _in_shape_sub(shapt_pts, leng, pt, _does_pt_cross(shapt_pts[i], shapt_pts[j], pt) ? !cond : cond, j);
 