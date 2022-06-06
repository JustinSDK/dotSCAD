use <../util/radians.scad>
use <../util/degrees.scad>

function _radian_step(r, pow2_dist) =
    radians(acos(1 - pow2_dist / (2 * r ^ 2)));

function _find_radians(b, pow2_dist, init_radian, n) = 
    [
        for(
            count = 0, radian = init_radian; 
            count < n; 
            count = count + 1, radian = radian + _radian_step(b * radian, pow2_dist)
        )
        radian
    ];

function _archimedean_spiral_impl(arm_distance, init_angle, point_distance, num_of_points, rt_dir) =
    let(b = arm_distance / (2 * PI), init_radian = radians(init_angle), sgn = rt_dir == "CT_CLK" ? 1 : -1)
    [
        for(radian = _find_radians(b, point_distance ^ 2, init_radian, num_of_points)) 
        let(r = b * radian, a = degrees(sgn * radian))
        [r * [cos(a), sin(a)], a]
    ];