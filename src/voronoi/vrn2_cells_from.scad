use <_impl/_vrn2_cells_from_impl.scad>;
use <_impl/_convex_intersection_for.scad>;
use <../shape_square.scad>;

function vrn2_cells_from(points) = 
    let(
        size = _default_region_size(points),
        half_size = size * 0.5,
        shape = shape_square(size),
        regions_lt = [
            for(p = points) 
                _cells_lt_before_intersection(shape, size, points, p, half_size)
        ]        
    )
    [
        for(regions = regions_lt)
            _convex_intersection_for(regions)
    ];