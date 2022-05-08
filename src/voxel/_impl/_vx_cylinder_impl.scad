function _vx_circle(radius, filled, thickness) = 
    let(range = [-radius: radius - 1], powr = radius ^ 2)
    filled ? [
        for(y = range, x = range)    
        let(v = [x, y])
        if(v * v < powr) v
    ] :
    let(ishell = powr - 2 * thickness * radius)
    [
        for(y = range, x = range)        
        let(
            v = [x, y],
            pow_leng = v * v
        )
        if(pow_leng < powr && pow_leng > ishell) v    
    ];

function _diff_r(r, h, filled, thickness) =
    let(
        r1 = r[0],
        r2 = r[1]
    )
    r1 == r2 ? _same_r(r1, h, filled, thickness) :
    let(dr = (r2 - r1) / (h - 1))
    [
        for(i = 0; i < h; i = i + 1)
        let(r = round(r1 + dr * i))
            for(pt = _vx_circle(r, filled, thickness))
            [each pt, i]
    ]; 

function _same_r(r, h, filled, thickness) =
    let(c = _vx_circle(r, filled, thickness))
    [
        for(i = 0; i < h; i = i + 1)
            for(pt = c) [each pt, i]
    ]; 

function _vx_cylinder_impl(r, h, filled, thickness) =
    is_num(r) ? 
        _same_r(r, h, filled, thickness) :
        _diff_r(r, h, filled, thickness); 