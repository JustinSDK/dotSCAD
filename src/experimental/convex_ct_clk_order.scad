use <util/sorted.scad>
use <experimental/convex_centroid.scad>

function convex_ct_clk_order(points) =
    let(cpt = convex_centroid(points))
    sorted(points, cmp = function(p1, p2) cross(p2 - cpt, p1 - cpt));