use <util/rand.scad>;
use <experimental/_impl/_pnoise2_impl.scad>;

function pnoise2s(points, seed) = 
    let(sd = is_undef(seed) ? floor(rand(0, 256)) : seed % 256)
    [for(p = points) _pnoise2(p[0], p[1], sd)];    