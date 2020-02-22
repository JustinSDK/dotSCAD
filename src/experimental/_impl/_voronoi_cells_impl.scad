
use <rotate_p.scad>;

function _default_region_size(points) = 
    let(
        xs = [for(p = points) p[0]],
        ys = [for(p = points) abs(p[1])]
    )
    max([(max(xs) -  min(xs) / 2), (max(ys) -  min(ys)) / 2]);

function _cells_lt_before_intersection(shape, size, points, pt) =
    let(half_region_size = 0.5 * size)
    [
        for(p = points)
            if(pt != p)
            let(
                v = p - pt,
                offset = (pt + p) / 2 - v / norm(v) * half_region_size,
                a = atan2(v[1], v[0])            
            )
            [
                for(sp = shape)
                     rotate_p(sp, a) + offset
            ]
    ];