use <experimental/convex_hull.scad>;

module polygon_hull(points) {
    polygon(convex_hull(points);
}