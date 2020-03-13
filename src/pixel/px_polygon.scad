use <in_shape.scad>;
use <util/sort.scad>;
use <util/dedup.scad>;
use <pixel/px_polyline.scad>;

function px_polygon(points, filled = false) =
    let(contour = px_polyline(concat(points, [points[0]])))
    !filled ? contour :
    let(
        sortedXY = sort(contour, by = "vt"),
        ys = [for(p = sortedXY) p[1]],
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
                let(to = len(row) - 1, y = row[0][1])
                if(to > 0 && (row[0][0] + 1 != row[to][0]))
                    for(i = [row[0][0] + 1:row[to][0] - 1])
                    let(p = [i, y])
                    if(in_shape(points, p)) p
            ]
        )
    )
    dedup(sort(all, by = "vt"), sorted = true);