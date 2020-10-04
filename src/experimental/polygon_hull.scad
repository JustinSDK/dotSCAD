use <experimental/convex_hull.scad>;

module polygon_hull(points) {
    hull() polygon(convex_hull(points));
}