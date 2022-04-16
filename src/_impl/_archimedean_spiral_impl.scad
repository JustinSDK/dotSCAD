use <../util/radians.scad>;
use <../util/degrees.scad>;

function _radian_step(b, theta, dist) =
    let(r_square = (b * theta) ^ 2)
    radians(acos(1 - dist ^ 2 / (2 * r_square)));

function _find_radians(b, point_distance, rads, n, count = 1) =
    let(pre_rads = rads[count - 1])
    count == n ? rads : (
        _find_radians(
            b, 
            point_distance, 
            [each rads, pre_rads + _radian_step(b, pre_rads, point_distance)], 
            n,
            count + 1
        ) 
    );

function _archimedean_spiral_impl(arm_distance, init_angle, point_distance, num_of_points, rt_dir) =
    let(b = arm_distance / (2 * PI), init_radian = radians(init_angle), sgn = rt_dir == "CT_CLK" ? 1 : -1)
    [
        for(theta = _find_radians(b, point_distance, [init_radian], num_of_points)) 
        let(r = b * theta, a = degrees(sgn * theta))
        [r * [cos(a), sin(a)], a]
    ];