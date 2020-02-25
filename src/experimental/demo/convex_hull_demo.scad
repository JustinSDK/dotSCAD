use <hull_polyline2d.scad>;
use <experimental/tri_bisectors.scad>;
use <experimental/convex_hull.scad>;
use <shape_starburst.scad>;

xs = rands(-20, 20, 150);
ys = rands(-20, 20, 150);
points = [for(i = [0:len(xs) - 1]) [xs[i], ys[i]]];

for(p = points) {
    translate(p)
        sphere(.5);
}
hull_shape = convex_hull(points);
#hull_polyline2d(concat(hull_shape, [hull_shape[0]]), width = 1);