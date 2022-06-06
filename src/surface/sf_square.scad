/**
* sf_square.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_square.html
*
**/ 

use <../ptf/ptf_x_twist.scad>
use <../ptf/ptf_y_twist.scad>
use <_impl/_sf_square_surfaces.scad>
use <sf_solidify.scad>

module sf_square(levels, thickness, depth, x_twist = 0, y_twist = 0, invert = false, convexity = 1) {
    size = [len(levels[0]), len(levels)];
    dp = is_undef(depth) ? thickness / 2 : depth;
    surface = _sf_square_surfaces(levels, thickness, dp, invert);

    off = [0, 0, invert ? thickness : 0];
    xt = x_twist != 0;
    yt = y_twist != 0;
    sf_solidify(
        [
            for(row = surface[0]) [
                for(p = row) 
                let(p_off = p + off, p_xt = xt ? ptf_x_twist(size, p_off, x_twist) : p_off)
                yt ? ptf_y_twist(size, p_xt, y_twist) : p_xt
            ]
        ],
        [
            for(row = surface[1]) [
                for(p = row) 
                let(p_xt = xt ? ptf_x_twist(size, p, x_twist) : p)
                yt ? ptf_y_twist(size, p_xt, y_twist) : p_xt
            ]
        ],
        convexity = convexity
    );
}