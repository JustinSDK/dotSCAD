use <_pnoise_comm.scad>;
use <../../util/lerp.scad>;

_signs = [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]];
function _pnoise2_grad2(hashvalue, x, y) = _signs[hashvalue % 8] * [x, y];

function _pnoise2(x, y, seed) =
    let(
        xi = floor(x),
        yi = floor(y),
        xf = x - xi,
        yf = y - yi,
        u = _pnoise_fade(xf),
        v = _pnoise_fade(yf),
        aa = _pnoise_lookup_pnoise_table(_pnoise_lookup_pnoise_table(seed + xi) + yi),
        ba = _pnoise_lookup_pnoise_table(_pnoise_lookup_pnoise_table(seed + xi + 1) + yi),
        ab = _pnoise_lookup_pnoise_table(_pnoise_lookup_pnoise_table(seed + xi) + yi + 1),
        bb = _pnoise_lookup_pnoise_table(_pnoise_lookup_pnoise_table(seed + xi + 1) + yi + 1),
        y1 = lerp(
            _pnoise2_grad2(aa, xf, yf),
            _pnoise2_grad2(ba, xf - 1, yf),
            u
        ),
        y2 = lerp(
            _pnoise2_grad2(ab, xf, yf - 1),
            _pnoise2_grad2(bb, xf - 1, yf - 1),
            u
        )             
    )
    lerp(y1, y2, v);