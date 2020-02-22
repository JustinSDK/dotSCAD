use <experimental/_impl/_convex_center_p_impl.scad>;

function convex_center_p(points) =
    let(leng = len(points))
    _sum(points, leng) / leng;