function px_polygon(points, filled = true) =
    filled ?
    let(
        xs = [for(pt = points) pt[0]],
        ys = [for(pt = points) pt[1]],
        max_x = max(xs),
        min_x = min(xs),
        max_y = max(ys),
        min_y = min(ys)
    )
    [
        for(x = min_x; x <= max_x; x = x + 1)
            for(y = min_y; y <= max_y; y = y + 1)
                let(pt = [x, y])
                if(in_shape(points, pt, true)) pt
    ]
    : 
    px_polyline(
        concat(points, [points[len(points) - 1], points[0]])
    );
    