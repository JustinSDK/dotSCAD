use <experimental/nz_voronoi3.scad>;

size = [20, 20, 20];
dim = 2; 
seed = 1;

points = [
    for(z = [0:size[2] - 1]) 
        for(y = [0:size[1] - 1]) 
            for(x = [0:size[0] - 1]) 
                [x, y, z, nz_voronoi3(size, x, y, z, seed, dim)]
];

max_dist = max([for(p = points) p[3]]);

for(p = points) {
    c = p[3] / max_dist * 2;
    color([c > 1 ? 1 : c , 0, 0])
    translate([p[0], p[1], p[2]])
        cube(1);
}