use <util/rand.scad>;
use <experimental/_impl/_pnoise1.scad>;

function pnoise1(xs, seed) = 
    let(
        from = floor(min(xs)),
        to = ceil(max(xs)),
        n = to - from + 1,
        sd = is_undef(seed) ? floor(rand(0, 256)) : seed
    )
    [
        for(x = xs) 
        _pnoise1(x, n, sd)
    ];