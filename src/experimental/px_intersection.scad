use <util/sort.scad>;
use <util/has.scad>;

function px_intersection(points1, points2) =
    let(
        leng1 = len(points1),
        leng2 = len(points2),
        pts_pair = leng1 > leng2 ? [points1, points2] : [points2, points1],
        sorted = sort(pts_pair[1], by = "vt")
    )
    [for(p = pts_pair[0]) if(has(sorted, p, sorted = true)) p];