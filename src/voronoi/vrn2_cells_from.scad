/**
* vrn2_cells_from.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-vrn2_cells_from.html
*
**/


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