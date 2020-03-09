use <experimental/_impl/_px_surround_impl.scad>;
use <util/sort.scad>;

function px_surround(points) = 
    let(
        // always start from the left-bottom pt
        sortedXY = sort(sort(points, by = "x"), by = "y"),
        fst = sortedXY[0] + [-1, -1]
    )
    _px_surround_travel(sortedXY, fst, fst);