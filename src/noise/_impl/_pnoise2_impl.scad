use <_pnoise_comm.scad>
use <../../util/lerp.scad>

_signs = [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]];
function _grad2(hashvalue, x, y) = _signs[hashvalue % 8] * [x, y];

function _pnoise2(x, y, seed) =
    let(
        xi = floor(x),
        yi = floor(y),
        xf = x - xi,
        yf = y - yi,
        u = _pnoise_fade(xf),
        v = _pnoise_fade(yf),
        rnd1 = rands(0, 256, 1, seed + xi)[0] + yi,
        rnd2 = rands(0, 256, 1, seed + xi + 1)[0] + yi, 
        aa = rands(0, 256, 1, rnd1)[0],
        ba = rands(0, 256, 1, rnd2)[0],
        ab = rands(0, 256, 1, rnd1 + 1)[0],
        bb = rands(0, 256, 1, rnd2 + 1)[0],
        y1 = lerp(
            _grad2(aa, xf, yf),
            _grad2(ba, xf - 1, yf),
            u
        ),
        y2 = lerp(
            _grad2(ab, xf, yf - 1),
            _grad2(bb, xf - 1, yf - 1),
            u
        )             
    )
    lerp(y1, y2, v);