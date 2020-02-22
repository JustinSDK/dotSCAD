use <util/sort.scad>;
use <experimental/convex_center_p.scad>;

function convex_ct_clk_order(points) =
    let(
        cpt = convex_center_p(points),
        pts_as = [for(p = points) [p, atan2(p[1] - cpt[1], p[0] - cpt[0])]],
        sorted = sort(pts_as, by = "idx", idx = 1)
    )
    [for(v = sorted) v[0]];