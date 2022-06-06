use <util/sum.scad>

function convex_centroid(points) = sum(points) / len(points);