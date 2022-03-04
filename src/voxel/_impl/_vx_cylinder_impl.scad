function _vx_cylinder_vx_circle(radius, filled, thickness) = 
    let(range = [-radius: radius - 1])
    filled ? [
        for(y = range, x = range)    
        let(v = [x, y])
        if(norm(v) < radius) v
    ] :
    let(ishell = radius ^ 2 - 2 * thickness * radius)
    [
        for(y = range, x = range)        
        let(
            v = [x, y],
            leng = norm(v)
        )
        if(leng < radius && (leng ^ 2) > ishell) v    
    ];

function _vx_cylinder_diff_r(r, h, filled, thickness) =
    let(
        r1 = r[0],
        r2 = r[1]
    )
    r1 == r2 ? _vx_cylinder_same_r(r1, h, filled, thickness) :
    let(dr = (r2 - r1) / (h - 1))
    [
        for(i = 0; i < h; i = i + 1)
        let(r = round(r1 + dr * i))
        each [
            for(pt = _vx_cylinder_vx_circle(r, filled, thickness))
            [each pt, i]
        ]
    ]; 

function _vx_cylinder_same_r(r, h, filled, thickness) =
    let(c = _vx_cylinder_vx_circle(r, filled, thickness))
    [
        for(i = 0; i < h; i = i + 1)
        each [
            for(pt = c) [each pt, i]
        ]
    ]; 

function _vx_cylinder_impl(r, h, filled, thickness) =
    is_num(r) ? 
        _vx_cylinder_same_r(r, h, filled, thickness) :
        _vx_cylinder_diff_r(r, h, filled, thickness); 