function __in_line(line_pts, pt, epsilon = 0.0001) =
    let(
        pts = len(line_pts[0]) == 2 ? [for(p = line_pts) [each p, 0]] : line_pts,
        pt3d = len(pt) == 2 ? [each pt, 0] : pt,
        v1 = pts[0] - pt3d, 
        v2 = pts[1] - pt3d
    )
    v1 * v2 <= epsilon && (
        let(v = cross(v1, v2)) 
        v * v < (epsilon ^ 2)
    );