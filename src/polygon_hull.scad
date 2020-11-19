use <__comm__/_convex_hull2.scad>;

module polygon_hull(points) {
    polygon(_convex_hull2(points));
}