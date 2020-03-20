use <hull_polyline2d.scad>;
use <util/rand.scad>;
use <experimental/pnoise2.scad>;
use <experimental/marching_squares.scad>;

seed = rand(0, 256);
points = [
    for(y = [0:.2:10]) [
        for(x = [0:.2:10]) [x, y, pnoise2(x, y, seed)]
    ]
];

for(row = marching_squares(points, 0.1)) {
    for(line = row) {
        p0 = [line[0][0], line[0][1]];
        p1 = [line[1][0], line[1][1]];
        hull_polyline2d([p0, p1], width = .1);
    }
}    