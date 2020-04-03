use <hull_polyline2d.scad>;
use <util/rand.scad>;
use <experimental/zip.scad>;
use <noise/nz_perlin1.scad>;
use <noise/nz_perlin1s.scad>;

seed = rand();
hull_polyline2d(
    [for(x = [0:.1:10]) [x, nz_perlin1(x, seed)]], width = .1
);

xs = [for(x = [0:.2:8.3]) x];
ys = nz_perlin1s(xs);

translate([0, 2])
    hull_polyline2d(
        zip([xs, ys]), width = .1
    );