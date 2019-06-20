function _px_cylinder_diff_r(r, h, center, filled) =
    let(
        r1 = r[0],
        r2 = r[1],
        dr = (r2 - r1) / (h - 1)
    )
    [
        for(i = 0; i < h; i = i + 1)
        let(r = round(r1 + dr * i))
        each [
            for(pt = px_circle(r, center, filled))
            [pt[0], pt[1], i]
        ]
    ]; 

function _px_cylinder_same_r(r, h, center, filled) =
    let(c = px_circle(r, center, filled))
    [
        for(i = 0; i < h; i = i + 1)
        each [
            for(pt = c)
            [pt[0], pt[1], i]
        ]
    ]; 

function px_cylinder(r, h, center, filled = false) =
    is_num(r) ? 
        _px_cylinder_same_r(r, h, center, filled) :
        _px_cylinder_diff_r(r, h, center, filled); 