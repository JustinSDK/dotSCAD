use <hull_polyline2d.scad>;
use <util/rand.scad>;
use <experimental/zip.scad>;
use <experimental/pnoise1.scad>;
use <experimental/pnoise1s.scad>;

seed = rand();
hull_polyline2d(
    [for(x = [0:.1:10]) [x, pnoise1(x, seed)]], width = .1
);

xs = [for(x = [0:.2:8.3]) x];
ys = pnoise1s(xs);

translate([0, 2])
    hull_polyline2d(
        zip([xs, ys]), width = .1
    );