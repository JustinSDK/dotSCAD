/**
* sf_torus.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_torus.html
*
**/ 

use <_impl/_sf_square_surfaces.scad>
use <sf_solidify.scad>
use <../ptf/ptf_torus.scad>

module sf_torus(levels, radius, thickness, depth, angle = [360, 360], twist = 0, invert = false, convexity = 1) {
    dp = is_undef(depth) ? thickness / 2 : depth;
    surface = _sf_square_surfaces(levels, thickness, dp, invert);
    rows = len(levels);
    columns = len(levels[0]);
    size = [columns - 1, rows - 1];

    R = radius[0];
    r = radius[1];

    offset_z = invert ? thickness : 0;

    tr1 = [R, r + offset_z];
    tr2 = [R + thickness, r];

    sf_solidify(
        [
            for(row = surface[0]) 
            [
                for(p = row) ptf_torus(size, p, tr1, angle, twist)
            ]
        ],
        [
            for(row = surface[1]) 
            [
                for(p = row) ptf_torus(size, p, tr2, angle, twist)
            ]
        ],
        convexity = convexity
    );
}