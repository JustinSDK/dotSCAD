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
        n1p = n1 * n1
    )
    cross(a, s) * (b2 - a1) != 0 ||   // they aren't coplanar
    n1p < epsilon ^ 2 ? [] :          // they are parallel or conincident edges
    let(n2 = cross(s, b), v = a * sqrt(n2 * n2 / n1p))
    n1 * n2 >= 0 ? a1 + v : a1 - v;