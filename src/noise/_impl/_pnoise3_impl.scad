use <_pnoise_comm.scad>;
use <../../util/lerp.scad>;

_signs = [[1, 1, 0], [-1, 1, 0], [1, -1, 0], [-1, -1, 0], [1, 0, 1], [-1, 0, 1], [1, 0, -1], [-1, 0, -1], [0, 1, 1], [0, -1, 1], [0, 1, -1], [0, -1, -1], [1, 1, 0], [0, -1, 1], [-1, 1, 0], [0, -1, -1]];
function _pnoise3_grad3(hashvalue, x, y, z) = _signs[hashvalue % 16] * [x, y, z];

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

        aaa = _pnoise_lookup_pnoise_table(
            _pnoise_lookup_pnoise_table(
                    _pnoise_lookup_pnoise_table(seed + xi) + yi
                ) + zi            
        ),
        aba = _pnoise_lookup_pnoise_table(
            _pnoise_lookup_pnoise_table(
                    _pnoise_lookup_pnoise_table(seed + xi) + yi + 1
                ) + zi            
        ),        
        aab = _pnoise_lookup_pnoise_table(
            _pnoise_lookup_pnoise_table(
                    _pnoise_lookup_pnoise_table(seed + xi) + yi
                ) + zi + 1     
        ),
        abb = _pnoise_lookup_pnoise_table(
            _pnoise_lookup_pnoise_table(
                    _pnoise_lookup_pnoise_table(seed + xi) + yi + 1
                ) + zi + 1
        ),
        baa = _pnoise_lookup_pnoise_table(
            _pnoise_lookup_pnoise_table(
                    _pnoise_lookup_pnoise_table(seed + xi + 1) + yi
                ) + zi            
        ),
        bba = _pnoise_lookup_pnoise_table(
            _pnoise_lookup_pnoise_table(
                    _pnoise_lookup_pnoise_table(seed + xi + 1) + yi + 1
                ) + zi            
        ),    
        bab = _pnoise_lookup_pnoise_table(
            _pnoise_lookup_pnoise_table(
                    _pnoise_lookup_pnoise_table(seed + xi + 1) + yi
                ) + zi + 1
        ),
        bbb = _pnoise_lookup_pnoise_table(
            _pnoise_lookup_pnoise_table(
                    _pnoise_lookup_pnoise_table(seed + xi + 1) + yi + 1
                ) + zi + 1
        ),        
        x1 = lerp(
            _pnoise3_grad3(aaa, xf, yf, zf),
            _pnoise3_grad3(baa, xf - 1, yf, zf),
            u
        ),
        x2 = lerp(
            _pnoise3_grad3(aba, xf, yf - 1, zf),
            _pnoise3_grad3(bba, xf - 1, yf - 1, zf),
            u
        ),
        y1 = lerp(x1, x2, v),
        x3 = lerp(
            _pnoise3_grad3(aab, xf, yf, zf - 1),
            _pnoise3_grad3(bab, xf - 1, yf, zf - 1),
            u
        ),
        x4 = lerp(
            _pnoise3_grad3(abb, xf, yf - 1, zf - 1),
            _pnoise3_grad3(bbb, xf - 1, yf - 1, zf - 1),
            u
        ),
        y2 = lerp(x3, x4, v)      
    )
    lerp(y1, y2, w);