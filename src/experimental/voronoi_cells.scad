use <experimental/_impl/_voronoi_cells_impl.scad>;
use <experimental/convex_intersection_for.scad>;

function voronoi_cells(points, region_shape) = 
    let(
        size = _default_region_size(points),
        shape = is_undef(region_shape) ? shape_square(size) : region_shape,
        regions_lt = [
            for(p = points) 
                _cells_lt_before_intersection(shape, size, points, p)
        ]        
    )
    [
        for(regions = regions_lt)
            convex_intersection_for(regions)
    ];