use <experimental/_impl/_vx_contour_impl.scad>;
use <util/sort.scad>;

function vx_contour(points) = 
    let(
        // always start from the left-bottom pt
        sortedXY = sort(points, by = "vt"),
        fst = sortedXY[0] + [-1, -1]
    )
    _vx_contour_travel(sortedXY, fst, fst);