function __in_line(line_pts, pt) =
    let(
        v1 = line_pts[0] - pt, 
        v2 = line_pts[1] - pt
    )
    (cross(v1, v2) == 0) && ((v1 * v2) <= 0);