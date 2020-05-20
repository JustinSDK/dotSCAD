use <../util/sort.scad>;
use <../util/dedup.scad>;

function vx_union(points1, points2) =
    dedup(
        sort(concat(points1, points2), by = "vt"), 
        sorted = true
    );