use <../../util/sort.scad>;
use <_convex_centroid.scad>;

function _convex_ct_clk_order(points) =
    let(
        cpt = _convex_centroid(points),
        pts_as = [for(p = points) [p, atan2(p.y - cpt.y, p.x - cpt.x)]],
        sorted = sort(pts_as, by = "idx", idx = 1)
    )
    [for(v = sorted) v[0]];