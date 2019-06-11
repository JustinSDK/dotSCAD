/**
* archimedean_spiral.scad
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-archimedean_spiral.html
*
**/ 

function _radian_step(b, theta, l) =
    let(r_square = pow(b * theta, 2))
    acos((2 * r_square - pow(l, 2)) / (2 * r_square)) / 180 * PI;

function _find_radians(b, point_distance, radians, n, count = 1) =
    let(pre_radians = radians[count - 1])
    count == n ? radians : (
        _find_radians(
            b, 
            point_distance, 
            concat(
                radians,
                [pre_radians + _radian_step(b, pre_radians, point_distance)]
            ), 
            n,
        count + 1) 
    );

function archimedean_spiral(arm_distance, init_angle, point_distance, num_of_points, rt_dir = "CT_CLK") =
    let(b = arm_distance / (2 * PI), init_radian = init_angle * PI / 180)
    [
        for(theta = _find_radians(b, point_distance, [init_radian], num_of_points)) 
           let(r = b * theta, a = (rt_dir == "CT_CLK" ? 1 : -1) * theta * 57.2958)
           [[r * cos(a), r * sin(a)], a]
    ];