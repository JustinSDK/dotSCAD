use <../in_shape.scad>;
use <../util/sort.scad>;
use <../util/dedup.scad>;
use <vx_polyline.scad>;

function vx_polygon(points, filled = false) =
    let(contour = vx_polyline([each points, points[0]]))
    !filled ? contour :
    let(
        sortedXY = sort(contour, by = "vt"),
        ys = [for(p = sortedXY) p.y],
        rows = [
            for(y = [min(ys):max(ys)])
            let(
                idxes = search(y, sortedXY, num_returns_per_match = 0, index_col_num = 1)
            )
            [for(i = idxes) sortedXY[i]]
        ],
        all = concat(
            sortedXY,
            [
                for(row = rows)
                let(to = len(row) - 1, row0 = row[0], y = row0[1])
                if(to > 0 && (row0[0] + 1 != row[to][0]))
                    for(i = [row0[0] + 1:row[to][0] - 1])
                    let(p = [i, y])
                    if(in_shape(points, p)) p
            ]
        )
    )
    dedup(all);