/**
* sf_bend.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_bend.html
*
**/ 

use <_impl/_sf_square_surfaces.scad>
use <sf_cylinder.scad>;
use <sf_solidify.scad>
use <../ptf/ptf_bend.scad>

module sf_bend(levels, radius, thickness, depth, angle = 180, invert = false, convexity = 1) {
    if(angle == 360) {
        sf_cylinder(levels, radius, thickness, depth, invert, convexity);
    }
    else {
        dp = is_undef(depth) ? thickness / 2 : depth;
        surface = _sf_square_surfaces(levels, thickness, dp, invert);
        rows = len(levels);
        columns = len(levels[0]);
        size = [columns - 1, rows - 1];

        offset_z = invert ? thickness : 0;
        r = radius + offset_z;
        sf_solidify(
            [
                for(row = surface[0]) 
                [
                    for(p = row) ptf_bend(size, p, r, angle)
                ]
            ],
            [
                for(row = surface[1]) 
                [
                    for(p = row) ptf_bend(size, p, radius, angle)
                ]
            ],
            convexity = convexity
        );
    }
}