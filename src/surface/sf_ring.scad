/**
* sf_ring.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_ring.html
*
**/ 

use <_impl/_sf_square_surfaces.scad>;
use <sf_solidify.scad>;
use <../ptf/ptf_ring.scad>;

module sf_ring(levels, radius, thickness, depth, angle = 360, twist = 0, invert = false) {
    dp = is_undef(depth) ? thickness / 2 : depth;
    surface = _sf_square_surfaces(levels, thickness, dp, invert);
    rows = len(levels);
    columns = len(levels[0]);
    size = [columns - 1, rows - 1];
    
    offset_z = invert ? thickness : 0;
    centered = invert ? [0, 0, thickness] : [0, 0, thickness / 2];
    if(invert) {
        mirror([0, 0, 1]) 
            sf_solidify(
                [
                    for(row = surface[1]) 
                    [
                        for(p = row) 
                            ptf_ring(size, p + centered, radius, angle, twist)
                    ]
                ],            
                [
                    for(row = surface[0]) 
                    [
                        for(p = row) 
                            ptf_ring(size, [p[0], p[1], -p[2]], radius, angle, twist)
                    ]
                ]
                
            );   
    } else {
        sf_solidify(
            [
                for(row = surface[0]) 
                [
                    for(p = row) 
                        ptf_ring(size, p - centered, radius, angle, twist) + [0, 0, offset_z]
                ]
            ],
            [
                for(row = surface[1]) 
                [
                    for(p = row) 
                        ptf_ring(size, p - centered, radius, angle, twist)
                ]
            ]
        );     
    }
}