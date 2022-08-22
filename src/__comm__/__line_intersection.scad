function __line_intersection2(line_pts1, line_pts2, ext, epsilon = 0.0001) = 
    let(
        a1 = line_pts1[0],
        a2 = line_pts1[1],
        b1 = line_pts2[0],
        b2 = line_pts2[1],
        a = a2 - a1, 
        b = b2 - b1,
        c = cross(a, b)
    ) 
    abs(c) < epsilon ? [] :  // they are parallel or conincident edges
    let(
         t = cross(b1 - a1, b) /  c,
         p = a1 + a * t
    )
    ext ? p :
    let(u = -cross(a1 - b1, a) / c)
    t >= 0 && t <= 1 && u >= 0 && u <= 1 ? p : [];

function v_scalar(v1, v2) = 
    let(s = norm(v1) / norm(v2))
    s * v2 == v1 ? s : -s;

function __line_intersection3(line_pts1, line_pts2, ext, epsilon = 0.0001) = 
    let(
        a1 = line_pts1[0],
        a2 = line_pts1[1],
        b1 = line_pts2[0],
        b2 = line_pts2[1],
        a = a2 - a1, 
        b = b2 - b1,
        c = cross(a, b)
    ) 
    cross(a, b1 - a1) * (b2 - a1) != 0 ||   // they aren't coplanar
    norm(c) < epsilon ? [] :                // they are parallel or conincident edges
    let(
         t = v_scalar(cross(b1 - a1, b), c), 
         p = a1 + a * t
    )
    ext ? p :
    let(u = v_scalar(cross(a1 - b1, a), -c))
    t >= 0 && t <= 1 && u >= 0 && u <= 1 ? p : [];