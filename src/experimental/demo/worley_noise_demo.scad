use <experimental/zip.scad>;
use <experimental/worley_noise.scad>;

size = [50, 50];
n = 50;
xs = rands(0, size[0] - 1, n);
ys = rands(0, size[1] - 1, n);
points = zip([xs, ys]);

noised = [
    for(y = [0:size[1] - 1]) 
        for(x = [0:size[0] - 1]) 
            [x, y, worley_noise([x, y], points)]
];

max_dist = max([for(n = noised) n[2]]);

for(n = noised) {
    c = n[2] / max_dist;
    color([c, c, c])
    linear_extrude(c * max_dist)
    translate([n[0], n[1]])
        square(1);
}