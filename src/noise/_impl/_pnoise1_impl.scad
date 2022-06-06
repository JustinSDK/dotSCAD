use <_pnoise_comm.scad>
use <../../util/lerp.scad>

_signs = [1, -1];
function _grad1(hashvalue, x) = _signs[hashvalue % 2] * x; 

function _pnoise1_impl(x, seed) =
    let(
        xi = floor(x),
        xf = x - xi
    )
    lerp(
        _grad1(rands(0, 256, 1, seed + xi)[0], xf),
        _grad1(rands(0, 256, 1, seed + xi + 1)[0], xf - 1),
        _pnoise_fade(xf)
    );