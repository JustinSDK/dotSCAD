function __pie_for_rounding(r, begin_a, end_a, frags) =
    let(
        sector_angle = end_a - begin_a,
        step_a = sector_angle / frags,
        is_integer = frags % 1 == 0,
        pie = [
            for(ang = begin_a; ang <= end_a; ang = ang + step_a)
                [r * cos(ang), r * sin(ang)]
        ]
    )
    r < 0.00005 ? [[0, 0]] : 
    is_integer ? pie : [each pie, [r * cos(end_a), r * sin(end_a)]];