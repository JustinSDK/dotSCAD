include <__private__/__to3d.scad>;
include <__private__/__to2d.scad>;
include <__private__/__lines_from.scad>;

function px_polyline(points) =
    let(
        is_2d = len(points[0]) == 2,
        pts = is_2d ? [for(pt = points) __to3d(pt)] : points,
        polyline = [for(line =  __lines_from(pts)) each px_line(line[0], line[1])]
    )
    is_2d ? [for(pt = polyline) __to2d(pt)] : polyline;