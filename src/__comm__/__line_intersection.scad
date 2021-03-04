function __line_intersection2(line_pts1, line_pts2, epsilon = 0.0001) = 
    let(
        a1 = line_pts1[0],
        a2 = line_pts1[1],
        b1 = line_pts2[0],
        b2 = line_pts2[1],
        a = a2 - a1, 
        b = b2 - b1, 
        s = b1 - a1,
        c = cross(a, b)
    )
    abs(c) < epsilon ? [] :  // they are parallel or conincident edges
        a1 + a * cross(s, b) / c;

function __line_intersection3(line_pts1, line_pts2, epsilon = 0.0001) = 
    let(
        a1 = line_pts1[0],
        a2 = line_pts1[1],
        b1 = line_pts2[0],
        b2 = line_pts2[1],
        a = a2 - a1, 
        b = b2 - b1, 
        s = b1 - a1,
        n1 = cross(a, b),
        norm_n1 = norm(n1)
    )
    cross(a, s) * (b2 - a1) != 0 ||   // they aren't coplanar
    norm_n1 < epsilon ? [] :          // they are parallel or conincident edges
        let(n2 = cross(s, b))
        a1 + a * (norm(n2) / norm_n1 * (n1 * n2 >= 0 ? 1 : -1));