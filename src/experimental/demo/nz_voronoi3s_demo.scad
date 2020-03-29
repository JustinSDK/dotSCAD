use <experimental/nz_voronoi3s.scad>;

size = [20, 20, 20];
dim = 2;
seed = 5;

points = [
    for(z = [0:size[2] - 1]) 
        for(y = [0:size[1] - 1]) 
            for(x = [0:size[0] - 1]) 
                [x, y, z]
];
        
noises = nz_voronoi3s(size, points, seed, dim);

max_dist = max(noises);
for(i = [0:len(noises) - 1]) {
    c = noises[i] / max_dist * 2;
    color([c > 1 ? 1 : c , 0, 0])
    translate(points[i])
        square(1);
}