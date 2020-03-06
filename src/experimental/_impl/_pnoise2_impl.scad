use <experimental/_impl/_pnoise_comm.scad>;

function _pnoise2_grad2(hashvalue, x, y) = 
    let(case = hashvalue % 8)
    case == 0 ? y :
    case == 1 ? x + y :
    case == 2 ? x:
    case == 3 ? x - y:
    case == 4 ? -y:
    case == 5 ? -x - y:
    case == 6 ? -x : -x + y;

function _pnoise2(x, y, seed) =
    let(
        xi = floor(x),
        yi = floor(y),
        xf = x - xi,
        yf = y - yi,
        u = _pnoise_fade(xf),
        v = _pnoise_fade(yf),
        aa = _pnoise_lookup_poise_table(_pnoise_lookup_poise_table(seed + xi) + yi),
        ba = _pnoise_lookup_poise_table(_pnoise_lookup_poise_table(seed + xi + 1) + yi),
        ab = _pnoise_lookup_poise_table(_pnoise_lookup_poise_table(seed + xi) + yi + 1),
        bb = _pnoise_lookup_poise_table(_pnoise_lookup_poise_table(seed + xi + 1) + yi + 1),
        y1 = _pnoise_lerp(
            _pnoise2_grad2(aa, xf, yf),
            _pnoise2_grad2(ba, xf - 1, yf),
            u
        ),
        y2 = _pnoise_lerp(
            _pnoise2_grad2(ab, xf, yf - 1),
            _pnoise2_grad2(bb, xf - 1, yf - 1),
            u
        )             
    )
    _pnoise_lerp(y1, y2, v);