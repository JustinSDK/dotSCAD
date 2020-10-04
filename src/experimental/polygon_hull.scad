use <../__comm__/_convex_hull_impl.scad>;

module polygon_hull(points) {
    polygon(_convex_hull(points));
}