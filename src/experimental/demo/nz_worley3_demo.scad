use <experimental/nz_worley3.scad>;

size = [20, 20, 20];
cell_w = 10;
dist = "euclidean"; // [euclidean, manhattan, chebyshev, border] 
seed = 51;

points = [
    for(z = [0:size[2] - 1]) 
        for(y = [0:size[1] - 1]) 
            for(x = [0:size[0] - 1]) 
                [x, y, z]
];

cells = [for(p = points) nz_worley3(p[0], p[1], p[2], seed, cell_w, dist)];

max_dist = max([for(c = cells) c[3]]);
for(i = [0:len(cells) - 1]) {
    c = cells[i][3] / max_dist;
    color([c, c, c, c])
    translate(points[i])
        cube(1);
}