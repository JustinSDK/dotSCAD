use <../../util/sum.scad>

function _convex_centroid(points) = sum(points) / len(points);