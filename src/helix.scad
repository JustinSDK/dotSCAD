/**
* helix.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-helix.html
*
**/ 

use <__comm__/__frags.scad>

function helix(radius, levels, level_dist, vt_dir = "SPI_DOWN", rt_dir = "CT_CLK") = 
    let(
        is_SPI_DOWN = vt_dir == "SPI_DOWN",
        is_flt = is_num(radius),
        r1 = is_flt ? radius : radius[0],
        r2 = is_flt ? radius : radius[1],
        h = level_dist * levels,
        begin_r = is_SPI_DOWN ? r2 : r1,
        begin_h = is_SPI_DOWN ? h : 0,
        _frags = __frags(begin_r),        
        vt_d = is_SPI_DOWN ? 1 : -1,
        rt_d = rt_dir == "CT_CLK" ? 1 : -1,
        r_diff = (r1 - r2) * vt_d,
        h_step = level_dist / _frags * vt_d,
        r_step = r_diff / (levels * _frags),
        a_step = 360 / _frags * rt_d,
        end_i = _frags * levels
    )
    [
        for(i = 0; i <= end_i; i = i + 1) 
        let(r = begin_r + r_step * i, a = a_step * i)
        [r * cos(a), r * sin(a), begin_h - h_step * i]
    ];