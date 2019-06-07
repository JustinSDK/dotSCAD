function __in_line2d(line_pts, pt, epsilon = 0.0001) =
    let(
        v1 = line_pts[0] - pt, 
        v2 = line_pts[1] - pt
    )
    (norm(cross(v1, v2)) < epsilon) && ((v1 * v2) <= epsilon);