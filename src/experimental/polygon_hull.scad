use <../__comm__/_convex_hull.scad>;

module polygon_hull(points) {
    polygon(_convex_hull(points));
}