use <../../ptf/ptf_rotate.scad>;

function _default_region_size(points) = 
    let(
        xs = [for(p = points) p[0]],
        ys = [for(p = points) abs(p[1])]
    )
    max([(max(xs) -  min(xs) / 2), (max(ys) -  min(ys)) / 2]);

function _cells_lt_before_intersection(shape, size, points, pt, half_region_size) =
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
                     ptf_rotate(sp, a) + offset
            ]
    ];