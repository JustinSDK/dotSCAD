use <../in_shape.scad>
use <../util/sorted.scad>
use <vx_polyline.scad>
use <../util/set/hashset.scad>
use <../util/set/hashset_elems.scad>

include <../__comm__/_pt2_hash.scad>

function vx_polygon(points, filled = false) =
    let(contour = vx_polyline([each points, points[0]]))
    !filled ? contour :
    let(
        sortedXY = sorted(contour),
        ys = [for(p = sortedXY) p.y],
        rows = [
            for(y = [min(ys):max(ys)])
            let(idxes = search(y, sortedXY, num_returns_per_match = 0, index_col_num = 1))
            [for(i = idxes) sortedXY[i]]
        ],
        all = concat(
            sortedXY,
            [
                for(row = rows)
                let(to = len(row) - 1, row0 = row[0], y = row0[1], row_to = row[to])
                if(to > 0 && (row0[0] + 1 != row_to[0]))
                    for(i = [row0[0] + 1:row_to[0] - 1])
                    let(p = [i, y])
                    if(in_shape(points, p)) p
            ]
        )
    )
    hashset_elems(
        hashset(all, hash = _pt2_hash)
    );