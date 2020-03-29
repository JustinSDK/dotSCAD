use <util/rand.scad>;
use <experimental/_impl/_nz_worley3_impl.scad>;

function nz_worley3s(size, points, seed, dim = 2, dist = "euclidean") =
    let(
        sd = 6 + (is_undef(seed) ? floor(rand(0, 256)) : seed % 256),
        // m*n pixels per grid
        m = size[0] / dim,
        n = size[1] / dim,
        o = size[2] / dim
    )
    [for(p = points) _nz_worley3(p, sd, dim, m, n, o, dist)];