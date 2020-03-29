use <experimental/nz_voronoi2s.scad>;

size = [100, 50];
dim = 5;
seed = 5;

points = [
    for(y = [0:size[1] - 1]) 
        for(x = [0:size[0] - 1]) 
            [x, y]
];
        
noises = nz_voronoi2s(size, points, seed, dim);

max_dist = max(noises);
for(i = [0:len(noises) - 1]) {
    c = noises[i] / max_dist;
    color([c, c, c])
    translate(points[i])
        square(1);
}