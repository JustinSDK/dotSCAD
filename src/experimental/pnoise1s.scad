use <util/rand.scad>;
use <experimental/_impl/_pnoise1_impl.scad>;

function pnoise1s(xs, seed) = 
    let(sd = is_undef(seed) ? floor(rand(0, 256)) : seed % 256)
    [for(x = xs) _pnoise1_impl(x, sd)];