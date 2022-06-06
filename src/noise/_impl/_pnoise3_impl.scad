use <_pnoise_comm.scad>
use <../../util/lerp.scad>

_signs = [[1, 1, 0], [-1, 1, 0], [1, -1, 0], [-1, -1, 0], [1, 0, 1], [-1, 0, 1], [1, 0, -1], [-1, 0, -1], [0, 1, 1], [0, -1, 1], [0, 1, -1], [0, -1, -1], [1, 1, 0], [0, -1, 1], [-1, 1, 0], [0, -1, -1]];
function _grad3(hashvalue, x, y, z) = _signs[hashvalue % 16] * [x, y, z];

function _pnoise3(x, y, z, seed) =
    let(
        xi = floor(x),
        yi = floor(y),
        zi = floor(z),        
        xf = x - xi,
        yf = y - yi,
        zf = z - zi,
        u = _pnoise_fade(xf),
        v = _pnoise_fade(yf),
        w = _pnoise_fade(zf),

        rnd1 = rands(0, 256, 1, seed + xi)[0] + yi,
        rnd2 = rands(0, 256, 1, seed + xi + 1)[0] + yi,

        rnd3 = rands(0, 256, 1, rnd1)[0] + zi,
        rnd4 = rands(0, 256, 1, rnd1 + 1)[0] + zi,
        rnd5 = rands(0, 256, 1, rnd2)[0] + zi,
        rnd6 = rands(0, 256, 1, rnd2 + 1)[0] + zi,

        aaa = rands(0, 256, 1, rnd3)[0],
        aba = rands(0, 256, 1, rnd4)[0],       
        aab = rands(0, 256, 1, rnd3 + 1)[0],
        abb = rands(0, 256, 1, rnd4 + 1)[0],
        baa = rands(0, 256, 1, rnd5)[0],
        bab = rands(0, 256, 1, rnd5 + 1)[0],
        bba = rands(0, 256, 1, rnd6)[0],
        bbb = rands(0, 256, 1, rnd6 + 1)[0],

        x1 = lerp(
            _grad3(aaa, xf, yf, zf),
            _grad3(baa, xf - 1, yf, zf),
            u
        ),
        x2 = lerp(
            _grad3(aba, xf, yf - 1, zf),
            _grad3(bba, xf - 1, yf - 1, zf),
            u
        ),
        y1 = lerp(x1, x2, v),
        x3 = lerp(
            _grad3(aab, xf, yf, zf - 1),
            _grad3(bab, xf - 1, yf, zf - 1),
            u
        ),
        x4 = lerp(
            _grad3(abb, xf, yf - 1, zf - 1),
            _grad3(bbb, xf - 1, yf - 1, zf - 1),
            u
        ),
        y2 = lerp(x3, x4, v)      
    )
    lerp(y1, y2, w);