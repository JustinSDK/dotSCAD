use <experimental/nz_worley3.scad>;

size = [30, 30, 30];
dim = 5;
dist = "euclidean"; // [euclidean, manhattan, chebyshev] 
seed = 5;

points = [
    for(z = [0:size[2] - 1]) 
        for(y = [0:size[1] - 1]) 
            for(x = [0:size[0] - 1]) 
                [x, y, z, nz_worley3(size, x, y, z, seed, dim, dist)]
];

max_dist = max([for(p = points) p[3]]);
for(p = points) {
    c = p[3] / max_dist;
    color([c, c, c, c])
    translate([p[0], p[1], p[2]])
        cube(1);
}