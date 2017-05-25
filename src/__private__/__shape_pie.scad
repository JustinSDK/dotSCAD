function __shape_pie(radius, angle) =
    let(
        frags = __frags(radius),
        a_step = 360 / frags,
        leng = radius * cos(a_step / 2),
        angles = __is_vector(angle) ? angle : [0:angle],
        m = floor(angles[0] / a_step) + 1,
        n = floor(angles[1] / a_step),
        edge_r_begin = leng / cos((m - 0.5) * a_step - angles[0]),
        edge_r_end = leng / cos((n + 0.5) * a_step - angles[1]),
        shape_pts = concat(
            [[0, 0], __ra_to_xy(edge_r_begin, angles[0])],
            m > n ? [] : [
                for(i = [m:n]) 
                    let(a = a_step * i) 
                    __ra_to_xy(radius, a)
            ],
            angles[1] == a_step * n ? [] : [__ra_to_xy(edge_r_end, angles[1])]
        )
    ) shape_pts;