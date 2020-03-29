use <experimental/nz_voronoi2.scad>;

size = [100, 50];
dim = 5;
seed = 5;

points = [
    for(y = [0:size[1] - 1]) 
        for(x = [0:size[0] - 1]) 
            [x, y, nz_voronoi2(size, x, y, seed, dim)]
];

max_dist = max([for(p = points) p[2]]);
for(p = points) {
    c = p[2] / max_dist;
    color([c, c, c])
    translate([p[0], p[1]])
        square(1);
}