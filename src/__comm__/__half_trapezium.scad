use <__frags.scad>
use <__pie_for_rounding.scad>

function __tr__corner_t_leng_lt_zero(frags, t_sector_angle, L, h, round_r) = 
    let(off = [0, tan(t_sector_angle) * L - round_r / sin(90 - t_sector_angle) - h / 2])
    [ 
        for(pt = __pie_for_rounding(round_r, 90 - t_sector_angle, 90, frags * t_sector_angle / 180))
        pt + off
    ];

function __tr_corner_t_leng_gt_or_eq_zero(frags, t_sector_angle, t_leng, h, round_r) = 
    let(off = [t_leng, h / 2 - round_r])
    [
        for(pt = __pie_for_rounding(round_r, 90 - t_sector_angle, 90, frags * t_sector_angle / 360))
        pt + off
    ];    

function __tr_corner(frags, b_ang, L01, h, round_r) = 
    let(t_leng = L01[1] - round_r * tan(b_ang / 2))
    t_leng >= 0 ? 
        __tr_corner_t_leng_gt_or_eq_zero(frags, b_ang, t_leng, h, round_r) : 
        __tr__corner_t_leng_lt_zero(frags, b_ang, L01[0], h, round_r);

function __tr__corner_b_leng_lt_zero(frags, b_sector_a, L, h, round_r) = 
    let(reversed = __tr__corner_t_leng_lt_zero(frags, b_sector_a, L, h, round_r))
    [
        for(i = len(reversed) - 1; i > -1; i = i - 1)
        let(pt = reversed[i])
        [pt.x, -pt.y]
    ];

function __br_corner_b_leng_gt_or_eq_zero(frags, b_sector_a, b_leng, h, round_r) = 
    let(off = [b_leng, round_r - h / 2]) 
    [
        for(pt = __pie_for_rounding(round_r, -90, -90 + b_sector_a, frags * b_sector_a / 360))
        pt + off
    ];

function __br_corner(frags, b_ang, L01, h, round_r) = 
    let(b_leng = L01[0] - round_r / tan(b_ang / 2), b_sector_a = 180 - b_ang) 
    b_leng >= 0 ? 
    __br_corner_b_leng_gt_or_eq_zero(frags, b_sector_a, b_leng, h, round_r) :
    __tr__corner_b_leng_lt_zero(frags, b_sector_a, L01[1], h, round_r);

function __half_trapezium(length, h, round_r) =
    let(
        L01 = is_num(length) ? [length, length] : length,
        frags = __frags(round_r),
        b_ang = atan2(h, L01[0] - L01[1])
    )    
    concat(
        __br_corner(frags, b_ang, L01, h, round_r),
        __tr_corner(frags, b_ang, L01, h, round_r)
    );