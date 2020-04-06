use <noise/nz_worley3s.scad>;
use <util/dedup.scad>;

size = [20, 20, 20];
tile_w = 10;
dist = "euclidean"; // [euclidean, manhattan, chebyshev, border] 
seed = 51;

points = [
    for(z = [0:size[2] - 1]) 
        for(y = [0:size[1] - 1]) 
            for(x = [0:size[0] - 1]) 
                [x, y, z]
];

cells = nz_worley3s(points, seed, tile_w, dist);

max_dist = max([for(c = cells) c[3]]);
for(i = [0:len(cells) - 1]) {
    c = cells[i][3] / max_dist;
    color([c, c, c, c])
    translate(points[i])
        cube(1);
}