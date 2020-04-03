use <util/rand.scad>;
use <noise/_impl/_nz_worley3_impl.scad>;

function nz_worley3(x, y, z, seed, cell_w = 10, dist = "euclidean") =
    let(sd = is_undef(seed) ? floor(rand(0, 256)) : seed % 256)
    _nz_worley3([x, y, z], sd, cell_w, dist);