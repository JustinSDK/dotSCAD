use <experimental/_impl/_px_contour_impl.scad>;
use <util/sort.scad>;

function px_contour(points) = 
    let(
        // always start from the left-bottom pt
        sortedXY = sort(points, by = "vt"),
        fst = sortedXY[0] + [-1, -1]
    )
    _px_contour_travel(sortedXY, fst, fst);