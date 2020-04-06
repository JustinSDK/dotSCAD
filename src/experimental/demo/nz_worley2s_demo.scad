use <noise/nz_worley2s.scad>;
use <util/dedup.scad>;

size = [100, 50];
tile_w = 10;
dist = "euclidean"; // [euclidean, manhattan, chebyshev, border] 
seed = 51;

points = [
    for(y = [0:size[1] - 1]) 
        for(x = [0:size[0] - 1]) 
            [x, y]
];

cells = nz_worley2s(points, seed, tile_w, dist);

max_dist = max([for(c = cells) c[2]]);
for(i = [0:len(cells) - 1]) {
    c = cells[i][2] / max_dist;
    color([c, c, c])
    linear_extrude(cells[i][2])
    translate(points[i])
        square(1);
}

cells_pts = dedup([for(c = cells) [c[0], c[1]]]);
for(p = cells_pts) {
    translate(p)
    linear_extrude(max_dist)
        square(1);
}