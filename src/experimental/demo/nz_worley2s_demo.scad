use <experimental/nz_worley2s.scad>;

size = [100, 50];
cell_w = 10;
dist = "euclidean"; // [euclidean, manhattan, chebyshev, border] 
seed = 5;

points = [
    for(y = [0:size[1] - 1]) 
        for(x = [0:size[0] - 1]) 
            [x, y]
];
        
noises = nz_worley2s(points, seed, cell_w, dist);

max_dist = max(noises);
for(i = [0:len(noises) - 1]) {
    c = noises[i] / max_dist;
    color([c, c, c])
    linear_extrude(c * max_dist)
    translate(points[i])
        square(1);
}