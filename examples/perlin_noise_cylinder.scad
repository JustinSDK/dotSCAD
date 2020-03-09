use <util/rand.scad>;
use <experimental/pnoise2.scad>;
use <experimental/sf_solidify.scad>;
use <experimental/ptf_bend.scad>;

radius = 40;
height = 100;
thickness_scale = 1;
step = 4;

module perlin_noise_cylinder(radius, height, thickness_scale, step) {
    size = [PI * radius, height];
    
    surface_inside = [
        for(y = [0:step:size[1]])
            concat(
                [
                    for(x = [0:step:size[0] - 1])
                    [x / 10, y / 10, 0] 
                ],
                [[size[0] / 10, y / 10, 0]]
            )
    ];
    
    seed = rand(0, 256);
    surface_outside = [
            for(ri = [0:len(surface_inside) - 1])
                let(ns = pnoise2(surface_inside[ri], seed))
                    [
                        for(ci = [0:len(ns) - 1])
                            [surface_inside[ri][ci][0], surface_inside[ri][ci][1], thickness_scale * (ns[ci] + 1)]
                    ]
        ];

    size_div_10 = size / 10;
    radius_div_10 = radius / 10;
    t_surface_outside = [
            for(row = surface_outside)
                [for(p = row)
                    ptf_bend(size_div_10, p, radius_div_10, 180)
                ]
        ];
    t_surface_insde = [
        for(row = surface_inside)
            [for(p = row)
                ptf_bend(size_div_10, p, radius_div_10, 180)
            ]
    ];
 
    scale(10) {
       sf_solidify(t_surface_outside, t_surface_insde);
       mirror([0, 1, 0]) 
           sf_solidify(t_surface_outside, t_surface_insde);
    }
}

perlin_noise_cylinder(radius, height, thickness_scale, step);