function cell_pt(fcord, grid_w, seed, x, y, gw, gh) = 
    let(
        nx = fcord.x + x,
        ny = fcord.y + y,
        sd_x = (nx + gw) % gw,
        sd_y = (ny + gh) % gh,                 
        sd_base = abs(sd_x + sd_y * grid_w)
    )
    ([nx, ny] + rands(0.1, 0.9, 2, seed_value = seed + sd_base)) * grid_w;

// 9-nearest-neighbor 
function _neighbors(fcord, seed, grid_w, gw, gh) = 
    let(range = [-1:1])
    [for(y = range, x = range) cell_pt(fcord, grid_w, seed, x, y, gw, gh)];

function _cells_lt_before_intersection(shape, size, points, pt, half_region_size) =
    [
        for(p = points)
            let(
                v = p - pt,
                offset = (pt + p) / 2 - v / norm(v) * half_region_size,
                a = atan2(v.y, v.x),
                cosa = cos(a),
                sina = sin(a),
                m = [
                        [1, 0, offset.x],
                        [0, 1, offset.y],
                        [0, 0, 1]
                    ] 
                    * 
                    [
                        [cosa, -sina, 0],
                        [sina, cosa, 0],
                        [0, 0, 1]    
                    ]   
            )
            [
                for(sp = shape)
                let(transformed = m * [each sp, 1])
                [transformed.x, transformed.y]
            ]
    ];
