use <experimental/nz_worley2.scad>;

size = [100, 50];
cell_w = 10;
dist = "euclidean"; // [euclidean, manhattan, chebyshev, border] 
seed = 51;

points = [
    for(y = [0:size[1] - 1]) 
        for(x = [0:size[0] - 1]) 
            [x, y, nz_worley2(x, y, seed, cell_w, dist)]
];

max_dist = max([for(p = points) p[2]]);
for(p = points) {
    c = p[2] / max_dist;
    color([c, c, c])
    linear_extrude(c * max_dist)
    translate([p[0], p[1]])
        square(1);
}