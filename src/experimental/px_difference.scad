use <util/sort.scad>;
use <util/has.scad>;

function px_difference(points1, points2) =
    let(sorted = sort(points2, by = "vt"))
    [for(p = points1) if(!has(sorted, p, sorted = true)) p];