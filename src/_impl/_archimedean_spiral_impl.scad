function _radian_step(b, theta, l) =
    let(
        r_square = (b * theta) ^ 2,
        double_r_square = 2 * r_square
    )
    acos((double_r_square - l ^ 2) / double_r_square) / 180 * PI;

function _find_radians(b, point_distance, radians, n, count = 1) =
    let(pre_radians = radians[count - 1])
    count == n ? radians : (
        _find_radians(
            b, 
            point_distance, 
            [each radians, pre_radians + _radian_step(b, pre_radians, point_distance)], 
            n,
        count + 1) 
    );

function _archimedean_spiral_impl(arm_distance, init_angle, point_distance, num_of_points, rt_dir) =
    let(b = arm_distance / (2 * PI), init_radian = init_angle * PI / 180, sgn = rt_dir == "CT_CLK" ? 1 : -1)
    [
        for(theta = _find_radians(b, point_distance, [init_radian], num_of_points)) 
           let(r = b * theta, a = sgn * theta * 57.2958)
           [r * [cos(a), sin(a)], a]
    ];