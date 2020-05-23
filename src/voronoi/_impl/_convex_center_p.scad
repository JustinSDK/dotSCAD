use <../../util/sum.scad>;

function _convex_center_p(points) = sum(points) / len(points);