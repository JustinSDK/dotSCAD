use <noise/nz_cell.scad>
use <golden_spiral.scad>
use <surface/sf_thicken.scad>
use <ptf/ptf_rotate.scad>

size = [150, 150];
thickness = 5;
height_factor = 0.7;
pixel_step = 0.75;
spirals = 1;
spiral_from = 5;
spiral_to = 10;
spiral_pt_dist = 10;


half_size = size / 2;
half_pixel_step = pixel_step / 2;
pts_angles = golden_spiral(
    from = spiral_from, 
    to = spiral_pt_dist, 
    point_distance = spiral_pt_dist
);

a_step = 360 / spirals;
cells = [
    for(i = [0:spirals - 1], pt_angle = pts_angles)
        ptf_rotate(pt_angle[0], i * a_step)
];
noised = [
    for(y = [-half_size[1]:pixel_step:half_size[1]]) 
    [
        for(x = [-half_size[0]:pixel_step:half_size[0]]) 
        let(n = nz_cell(cells, [x, y] * height_factor) )
            [x, y, n < half_pixel_step ? half_pixel_step : n]
    ]
];

sf_thicken(noised, thickness);