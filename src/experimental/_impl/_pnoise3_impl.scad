use <experimental/_impl/_pnoise_comm.scad>;

function _pnoise3_grad3(hashvalue, x, y, z) = 
    let(case = hashvalue % 16)
    case ==  0 ? x + y :
    case ==  1 ? -x + y :
    case ==  2 ? x - y:
    case ==  3 ? -x - y:
    case ==  4 ? x + z:
    case ==  5 ? -x + z:
    case ==  6 ? x - z : 
    case ==  7 ? -x - z : 
    case ==  8 ? y + z : 
    case ==  9 ? -y + z : 
    case == 10 ? y - z : 
    case == 11 ? -y - z : 
    case == 12 ? y + x : 
    case == 13 ? -y + z : 
    case == 14 ? y - x : -y - z;

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

        aaa = _pnoise_lookup_poise_table(
            _pnoise_lookup_poise_table(
                    _pnoise_lookup_poise_table(seed + xi) + yi
                ) + zi            
        ),
        aba = _pnoise_lookup_poise_table(
            _pnoise_lookup_poise_table(
                    _pnoise_lookup_poise_table(seed + xi) + yi + 1
                ) + zi            
        ),        
        aab = _pnoise_lookup_poise_table(
            _pnoise_lookup_poise_table(
                    _pnoise_lookup_poise_table(seed + xi) + yi
                ) + zi + 1     
        ),
        abb = _pnoise_lookup_poise_table(
            _pnoise_lookup_poise_table(
                    _pnoise_lookup_poise_table(seed + xi) + yi + 1
                ) + zi + 1
        ),
        baa = _pnoise_lookup_poise_table(
            _pnoise_lookup_poise_table(
                    _pnoise_lookup_poise_table(seed + xi + 1) + yi
                ) + zi            
        ),
        bba = _pnoise_lookup_poise_table(
            _pnoise_lookup_poise_table(
                    _pnoise_lookup_poise_table(seed + xi + 1) + yi + 1
                ) + zi            
        ),    
        bab = _pnoise_lookup_poise_table(
            _pnoise_lookup_poise_table(
                    _pnoise_lookup_poise_table(seed + xi + 1) + yi
                ) + zi + 1
        ),
        bbb = _pnoise_lookup_poise_table(
            _pnoise_lookup_poise_table(
                    _pnoise_lookup_poise_table(seed + xi + 1) + yi + 1
                ) + zi + 1
        ),        
        x1 = _pnoise_lerp(
            _pnoise3_grad3(aaa, xf, yf, zf),
            _pnoise3_grad3(baa, xf - 1, yf, zf),
            u
        ),
        x2 = _pnoise_lerp(
            _pnoise3_grad3(aba, xf, yf - 1, zf),
            _pnoise3_grad3(bba, xf - 1, yf - 1, zf),
            u
        ),
        y1 = _pnoise_lerp(x1, x2, v),
        x3 = _pnoise_lerp(
            _pnoise3_grad3(aab, xf, yf, zf - 1),
            _pnoise3_grad3(bab, xf - 1, yf, zf - 1),
            u
        ),
        x4 = _pnoise_lerp(
            _pnoise3_grad3(abb, xf, yf - 1, zf - 1),
            _pnoise3_grad3(bbb, xf - 1, yf - 1, zf - 1),
            u
        ),
        y2 = _pnoise_lerp(x3, x4, v)      
    )
    _pnoise_lerp(y1, y2, w);