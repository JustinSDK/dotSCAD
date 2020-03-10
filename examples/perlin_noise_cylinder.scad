use <util/rand.scad>;
use <experimental/pnoise2s.scad>;
use <experimental/sf_solidify.scad>;
use <experimental/ptf_bend.scad>;
use <util/slice.scad>;

radius = 40;
height = 100;
thickness_scale = 1;
step = 4;

module perlin_noise_cylinder(radius, height, thickness_scale, step) {
    size = [2 * PI * radius, height];

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
    leng_row = len(surface_inside[0]);
    surface_outside = [
            for(ri = [0:len(surface_inside) - 1])
                let(
                    row = surface_inside[ri],
                    row_for_noise = concat(slice(row, 0, leng_row - 1), [[0, row[leng_row - 1][1], 0]]),
                    ns = pnoise2s(row_for_noise, seed)
                )
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
                    ptf_bend(size_div_10, p, radius_div_10, 360)
                ]
        ];
    t_surface_inside = [
        for(row = surface_inside)
            [for(p = row)
                ptf_bend(size_div_10, p, radius_div_10, 360)
            ]
    ];
 
    sf_solidify(t_surface_outside, t_surface_inside);
}

perlin_noise_cylinder(radius, height, thickness_scale, step);