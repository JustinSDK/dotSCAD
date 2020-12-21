function __line_intersection(line_pts1, line_pts2, epsilon = 0.0001) = 
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