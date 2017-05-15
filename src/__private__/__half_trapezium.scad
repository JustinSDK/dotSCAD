function __tr_corner(frags, l1, l2, h, round_r) = 
    let(
        t_sector_angle = atan2(h, l1 - l2),
        t_leng = l2 - round_r * tan(t_sector_angle / 2),
        t_round_frags = frags * t_sector_angle / 360,
        half_h = h / 2
    )
    [
        for(pt = __pie_for_rounding(round_r, 90 - t_sector_angle, 90, t_round_frags))
            [pt[0] + t_leng, pt[1] + h - round_r - half_h]
    ];

function __br_corner(frags, l1, l2, h, round_r) = 
    let(
        b_ang = atan2(h, l1 - l2),
        b_sector_angle = 180 - b_ang,
        b_leng = l1 - round_r / tan(b_ang / 2),
        b_round_frags = frags * b_sector_angle / 360,
        b_end_angle = -90 + b_sector_angle,
        half_h = h / 2
    ) 
    [
        for(pt = __pie_for_rounding(round_r, -90, b_end_angle, b_round_frags))
            [pt[0] + b_leng, pt[1] + round_r - half_h]
    ];

function __half_trapezium(length, h, round_r) =
    let(
        is_vt = __is_vector(length),
        l1 = is_vt ? length[0] : length,
        l2 = is_vt ? length[1] : length,
        frags = __frags(round_r),
        br_corner = __br_corner(frags, l1, l2, h, round_r),
        tr_corner = __tr_corner(frags, l1, l2, h, round_r)
    )    
    concat(
        br_corner,
        tr_corner
    );