use <../sweep.scad>;

module sf_cylinder(levels, radius, thickness, depth, invert = false, convexity = 1) {
    row_leng = len(levels[0]);
    a_step = 360 / row_leng;
    d_scale = (invert ? -depth : depth) / 255;
    or = thickness + (invert ? radius + depth : radius - depth);
    ir = radius;
    row_range = [0:row_leng - 1];

    sections = [
        for(z = [0:len(levels) - 1]) 
            concat(
                [for(xi = row_range)
                    let(
                        r = or + levels[z][xi] * d_scale,
                        a = xi * a_step
                    )
                    [r * cos(a), r * sin(a), -z + row_leng]
                ],
                [for(xi = row_range)
                    let(a = xi * a_step)
                    [ir * cos(a), ir * sin(a), -z + row_leng]
                ]
            )
            
    ];

    sweep(sections,  "HOLLOW");
}