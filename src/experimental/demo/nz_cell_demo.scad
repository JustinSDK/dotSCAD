use <noise/nz_cell.scad>;
use <golden_spiral.scad>;

size = [100, 50];
half_size = size / 2;

pts_angles = golden_spiral(
    from = 3, 
    to = 10, 
    point_distance = 3
);

feature_points = [for(pt_angle = pts_angles) pt_angle[0] + half_size];
noised = [
    for(y = [0:size[1] - 1]) 
        for(x = [0:size[0] - 1]) 
            [x, y, nz_cell(feature_points, [x, y])]
];

max_dist = max([for(n = noised) n[2]]);

for(n = noised) {
    c = abs(n[2] / max_dist);
    color([c, c, c])
    linear_extrude(n[2] + 0.1)
    translate([n[0], n[1]])
        square(1);
}