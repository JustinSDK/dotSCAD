use <../../util/sorted.scad>
use <_convex_centroid.scad>

function _convex_ct_clk_order(points) =
    let(cpt = _convex_centroid(points))
    sorted(points, cmp = function(p1, p2) cross(p2 - cpt, p1 - cpt));