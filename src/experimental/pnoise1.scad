use <util/rand.scad>;
use <experimental/_impl/_pnoise1.scad>;

function pnoise1(xs, seed) = 
    let(sd = is_undef(seed) ? floor(rand(0, 256)) : seed % 256)
    [for(x = xs) _pnoise1(x, sd)];