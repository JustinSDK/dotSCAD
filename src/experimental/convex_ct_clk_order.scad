use <util/sort.scad>;
use <experimental/convex_centroid.scad>;

function convex_ct_clk_order(points) =
    let(
        cpt = convex_centroid(points),
        pts_as = [for(p = points) [p, atan2(p[1] - cpt[1], p[0] - cpt[0])]],
        sorted = sort(pts_as, by = "idx", idx = 1)
    )
    [for(v = sorted) v[0]];