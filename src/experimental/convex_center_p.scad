use <experimental/sum.scad>;

function convex_center_p(points) = sum(points) / len(points);