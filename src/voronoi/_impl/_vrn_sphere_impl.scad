function stereographic_proj_to_plane(point) =
    let(n = 1 - point.z)
    [point.x / n, point.y / n];

function stereographic_proj_to_sphere(point) =
    let(
        pp = point * point,
        n = 1 + pp
    )
    [2 * point.x / n, 2 * point.y / n, (-1 + pp) / n];