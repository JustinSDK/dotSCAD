use <experimental/convex_center_p.scad>;

function tri_bisectors(points) = 
    let(
        orthocentre = convex_center_p(points),
        m1 = (points[0] + points[1]) / 2,
        m2 = (points[1] + points[2]) / 2,
        m3 = (points[2] + points[0]) / 2
    )
    [[orthocentre, m1], [orthocentre, m2], [orthocentre, m3]];