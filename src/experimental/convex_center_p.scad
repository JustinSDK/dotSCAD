use <util/sum.scad>;

function convex_center_p(points) = sum(points) / len(points);