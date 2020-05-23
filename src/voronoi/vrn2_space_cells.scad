use <_impl/_vrn2_space_cells_impl.scad>;
use <_impl/_convex_intersection_for.scad>;
use <../shape_square.scad>;

function vrn2_space_cells(size, grid_w, seed) = 
    let(
        sd = is_undef(seed) ? rands(0, 255, 1)[0] : seed,
        region_size = grid_w * 3,
        half_region_size = region_size * 0.5,
        shape = shape_square(grid_w * 3),
        gw = size[0] / grid_w,
        gh = size[1] / grid_w,
        cell_nbrs_lt = [for(cy = [-grid_w:grid_w:size[1]]) 
            for(cx = [-grid_w:grid_w:size[0]])
            let(
                nbrs = _neighbors(
                    [floor(cx / grid_w), floor(cy / grid_w)],
                    sd, 
                    grid_w,
                    gw, 
                    gh
                ),
                p = nbrs[4],
                points = concat(
                    [for(i = [0:3]) nbrs[i]], 
                    [for(i = [5:len(nbrs) - 1]) nbrs[i]]
                )
            )
            [p, points] 
        ],
        regions_lt = [
            for(cell_nbrs = cell_nbrs_lt) 
                [cell_nbrs[0], _cells_lt_before_intersection(shape, size, cell_nbrs[1], cell_nbrs[0], half_region_size)]
        ]        
    )
    [
        for(regions = regions_lt)
            [regions[0], _convex_intersection_for(regions[1])]
    ];