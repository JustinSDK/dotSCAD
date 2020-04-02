use <experimental/_impl/_voronoi2d_cells_impl.scad>;
use <experimental/convex_intersection_for.scad>;
use <shape_square.scad>;

function voronoi_cells(points) = 
    let(
        size = _default_region_size(points),
        shape = shape_square(size),
        regions_lt = [
            for(p = points) 
                _cells_lt_before_intersection(shape, size, points, p)
        ]        
    )
    [
        for(regions = regions_lt)
            convex_intersection_for(regions)
    ];