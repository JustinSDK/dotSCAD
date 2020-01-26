
function _px_cylinder_px_circle(radius, filled, thickness) = 
    let(range = [-radius: radius - 1])
    filled ? [
        for(y = range)        
           for(x = range)
               let(v = [x, y])
               if(norm(v) < radius) v
    ] :
    let(ishell = radius * radius - 2 * thickness * radius)
    [
        for(y = range)        
           for(x = range)
               let(
                   v = [x, y],
                   leng = norm(v)
               )
               if(leng < radius && (leng * leng) > ishell) v    
    ];

function _px_cylinder_diff_r(r, h, filled, thickness) =
    let(
        r1 = r[0],
        r2 = r[1]
    )
    r1 == r2 ? _px_cylinder_same_r(r1, h, filled, thickness) :
    let(dr = (r2 - r1) / (h - 1))
    [
        for(i = 0; i < h; i = i + 1)
        let(r = round(r1 + dr * i))
        each [
            for(pt = _px_cylinder_px_circle(r, filled, thickness))
            [pt[0], pt[1], i]
        ]
    ]; 

function _px_cylinder_same_r(r, h, filled, thickness) =
    let(c = _px_cylinder_px_circle(r, filled, thickness))
    [
        for(i = 0; i < h; i = i + 1)
        each [
            for(pt = c)
            [pt[0], pt[1], i]
        ]
    ]; 

function _px_cylinder_impl(r, h, filled, thickness) =
    is_num(r) ? 
        _px_cylinder_same_r(r, h, filled, thickness) :
        _px_cylinder_diff_r(r, h, filled, thickness); 