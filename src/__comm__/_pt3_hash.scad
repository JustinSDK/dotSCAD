_pt3_hash = function(p)
    let(
        x = p.x >= 0 ? 2 * p.x : -2 * p.x - 1,
        y = p.y >= 0 ? 2 * p.y : -2 * p.y - 1,
        z = p.z >= 0 ? 2 * p.z : -2 * p.z - 1,
        mx = max(x, y, z),
        hash = mx ^ 3 + (2 * mx * z) + z
    )
    mx == z ? hash + max(x, y) ^ 2 :
    y >= x  ? hash + x + y :
              hash + y;