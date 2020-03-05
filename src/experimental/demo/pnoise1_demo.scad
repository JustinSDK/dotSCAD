use <hull_polyline2d.scad>;
use <experimental/zip2.scad>;
use <experimental/pnoise1.scad>;

xs = [for(x = [0:.2:8.3]) x];
ys = pnoise1(xs);

hull_polyline2d(
    zip2(xs, ys), width = .1
);