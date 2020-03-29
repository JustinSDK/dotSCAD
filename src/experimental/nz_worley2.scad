use <util/rand.scad>;
use <experimental/_impl/_nz_worley2_impl.scad>;

function nz_worley2(size, x, y, seed, dim = 3, dist = "euclidean") =
    let(
        sd = 6 + (is_undef(seed) ? floor(rand(0, 256)) : seed % 256),
        // m*n pixels per grid
        m = size[0] / dim,
        n = size[1] / dim
    )
    _nz_worley2([x, y], sd, dim, m, n, dist);