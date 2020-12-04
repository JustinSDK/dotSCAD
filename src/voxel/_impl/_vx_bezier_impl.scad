function _vx_bezier_pt(p1, p2, p3, p4, pts) = 
    let(
        a1 = (p1 + p2) * 0.5,
        a2 = (p2 + p3) * 0.5,
        a3 = (p3 + p4) * 0.5,
        b1 = (a1 + a2) * 0.5,
        b2 = (a2 + a3) * 0.5,
        c = (b1 + b2) * 0.5
    )
    _vx_bezier(c, b2, a3, p4, _vx_bezier(p1, a1, b1, c, concat(pts, [[round(c[0]), round(c[1])]])));

function _vx_bezier(p1, p2, p3, p4, pts) =
    (abs(p1[0] - p4[0]) < 1 && abs(p1[1] - p4[1]) < 1) ? 
        pts : 
        _vx_bezier_pt(p1, p2, p3, p4, pts);