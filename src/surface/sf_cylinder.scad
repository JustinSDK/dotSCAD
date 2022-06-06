use <../sweep.scad>

module sf_cylinder(levels, radius, thickness, depth, invert = false, convexity = 1) {
    row_leng = len(levels[0]);
    a_step = 360 / row_leng;
    d_scale = (invert ? -depth : depth) / 255;
    or = thickness + (invert ? radius + depth : radius - depth);
    ir = radius;
    row_range = [0:row_leng - 1];

    sections = [
        for(z = [0:len(levels) - 1]) 
        let(level_z = levels[z], zz = -z + row_leng)
            concat(
                [for(xi = row_range)
                    let(
                        r = or + level_z[xi] * d_scale,
                        a = xi * a_step
                    )
                    [r * cos(a), r * sin(a), zz]
                ],
                [for(xi = row_range)
                    let(a = xi * a_step)
                    [ir * cos(a), ir * sin(a), zz]
                ]
            )
            
    ];

    sweep(sections,  "HOLLOW");
}