use <../../util/sort.scad>;
use <_convex_center_p.scad>;

function _convex_ct_clk_order(points) =
    let(
        cpt = _convex_center_p(points),
        pts_as = [for(p = points) [p, atan2(p[1] - cpt[1], p[0] - cpt[0])]],
        sorted = sort(pts_as, by = "idx", idx = 1)
    )
    [for(v = sorted) v[0]];