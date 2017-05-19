function __length_between(p1, p2) =
    let(
        dx = p2[0] - p1[0],
        dy = p2[1] - p1[1],
        dz = p2[2] - p1[2]
    ) sqrt(pow(dx, 2) + pow(dy, 2) + pow(dz, 2));