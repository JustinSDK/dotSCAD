use <experimental/_impl/_sf_square_surfaces.scad>;
use <experimental/sf_solidify.scad>;
use <experimental/ptf_ring.scad>;

/*
    levels : A list of numbers (0 ~ 255).
    radius: ring radius.
    thickness: thickness
    depth: the depth of the image    
    angle: arc angle.
    twist: The number of degrees of through which the rectangle is twisted.    
    invert: inverts how the gray levels are translated into height values.
*/

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