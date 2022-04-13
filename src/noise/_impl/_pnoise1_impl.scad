use <_pnoise_comm.scad>;
use <../../util/lerp.scad>;

_signs = [1, -1];
function _pnoise1_grad1(hashvalue, x) = _signs[hashvalue % 2] * x; 

function _pnoise1_impl(x, seed) =
    let(
        xi = floor(x),
        xf = x - xi
    )
    lerp(
        _pnoise1_grad1(_pnoise_lookup_pnoise_table(seed + xi), xf),
        _pnoise1_grad1(_pnoise_lookup_pnoise_table(seed + xi + 1), xf - 1),
        _pnoise_fade(xf)
    );