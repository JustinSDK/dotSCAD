/**
* helix.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-helix.html
*
**/ 

include <__private__/__is_vector.scad>;
include <__private__/__frags.scad>;

function helix(radius, levels, level_dist, vt_dir = "SPI_DOWN", rt_dir = "CT_CLK") = 
    let(
        is_vt = __is_vector(radius),
        r1 = is_vt ? radius[0] : radius,
        r2 = is_vt ? radius[1] : radius,
        init_r = vt_dir == "SPI_DOWN" ? r2 : r1,
        _frags = __frags(init_r),
        h = level_dist * levels,
        vt_d = vt_dir == "SPI_DOWN" ? 1 : -1,
        rt_d = rt_dir == "CT_CLK" ? 1 : -1,
        r_diff = (r1 - r2) * vt_d,
        h_step = level_dist / _frags * vt_d,
        r_step = r_diff / (levels * _frags),
        a_step = 360 / _frags * rt_d,
        begin_r = vt_dir == "SPI_DOWN" ? r2 : r1,
        begin_h = vt_dir == "SPI_DOWN" ? h : 0
    )
    [
        for(i = [0:_frags * levels]) 
            let(r = begin_r + r_step * i, a = a_step * i)
                [r * cos(a), r * sin(a), begin_h - h_step * i]
    ];