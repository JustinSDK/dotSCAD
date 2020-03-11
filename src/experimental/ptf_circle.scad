function ptf_circle(point, offset) =
    let(
        p = [point[0] + offset[1], point[1] + offset[0]],
        n = max(abs(p[0]), abs(p[1])),
        r = n * 1.414,
        a = atan2(p[0], p[1])
    )
    [r * cos(a), r * sin(a)];