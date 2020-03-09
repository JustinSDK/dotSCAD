use <util/rand.scad>;
use <experimental/_impl/_pnoise3_impl.scad>;

function pnoise3s(points, seed) = 
    let(sd = is_undef(seed) ? floor(rand(0, 256)) : seed % 256)
    [for(p = points) _pnoise3(p[0], p[1], p[2], sd)];    