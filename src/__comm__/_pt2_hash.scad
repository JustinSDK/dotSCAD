_pt2_hash = function(p) 
    let(
        x = p.x >= 0 ? 2 * p.x : -2 * p.x - 1,
        y = p.y >= 0 ? 2 * p.y : -2 * p.y - 1
    )
    x >= y ? x ^ 2 + x + y : x + y ^ 2;