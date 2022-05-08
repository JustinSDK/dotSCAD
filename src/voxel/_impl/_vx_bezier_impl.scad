function _pt3(p1, p2, p3, p4, pts) = 
    let(
        a1 = (p1 + p2) * 0.5,
        a2 = (p2 + p3) * 0.5,
        a3 = (p3 + p4) * 0.5,
        b1 = (a1 + a2) * 0.5,
        b2 = (a2 + a3) * 0.5,
        c = (b1 + b2) * 0.5,
        p = [round(c[0]), round(c[1]), round(c[2])]
    )
    _vx_bezier3(c, b2, a3, p4, _vx_bezier3(p1, a1, b1, c, [each pts, p]));

function _vx_bezier3(p1, p2, p3, p4, pts) =
    let(v = p1 - p4)
    abs(v.x) < 0.5 && abs(v.y) < 0.5 && abs(v.z) < 0.5 ? 
        pts : _pt3(p1, p2, p3, p4, pts);

function _pt2(p1, p2, p3, p4, pts) = 
    let(
        a1 = (p1 + p2) * 0.5,
        a2 = (p2 + p3) * 0.5,
        a3 = (p3 + p4) * 0.5,
        b1 = (a1 + a2) * 0.5,
        b2 = (a2 + a3) * 0.5,
        c = (b1 + b2) * 0.5,
        p = [round(c[0]), round(c[1])]
    )
    _vx_bezier2(c, b2, a3, p4, _vx_bezier2(p1, a1, b1, c, [each pts, p]));

function _vx_bezier2(p1, p2, p3, p4, pts) =
    let(v = p1 - p4)
    abs(v.x) < 0.5 && abs(v.y) < 0.5 ? 
        pts : _pt2(p1, p2, p3, p4, pts);