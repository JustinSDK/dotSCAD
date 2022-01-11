function stereographic_proj_to_plane(point) =
    let(n = 1 - point.z)
    [point.x / n, point.y / n];

function stereographic_proj_to_sphere(point) =
    let(n = 1 + point.x ^ 2 + point.y ^ 2)
    [2 * point.x / n, 2 * point.y / n, (-1 + point.x ^ 2 + point.y ^ 2) / n];