use <experimental/_impl/_pnoise_comm.scad>;

function _pnoise1_grad1(hashvalue, x) = (hashvalue % 2 == 0) ? x : -x; 

function _pnoise1_impl(x, seed) =
    let(
        xi = floor(x),
        xf = x - xi,
        u = _pnoise_fade(xf),
        a = _pnoise_lookup_poise_table(seed + xi),
        b = _pnoise_lookup_poise_table(seed + xi + 1)
    )
    _pnoise_lerp(
        _pnoise1_grad1(a, xf),
        _pnoise1_grad1(b, xf - 1),
        u
    );