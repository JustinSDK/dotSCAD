/**
* sf_sphere.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_sphere.html
*
**/ 

use <surface/_impl/_sf_square_surfaces.scad>;
use <surface/sf_solidify.scad>;
use <ptf/ptf_sphere.scad>;

module sf_sphere(levels, radius, thickness, depth, angle = [180, 360], invert = false) {
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
                for(p = row) ptf_sphere(size, p, r, angle)
            ]
        ]
        ,
        [
            for(row = surface[1]) 
            [
                for(p = row) ptf_sphere(size, p, radius, angle)
            ]
        ]
    );
}