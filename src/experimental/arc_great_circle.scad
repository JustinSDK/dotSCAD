use <__comm__/__frags.scad>
use <ptf/ptf_rotate.scad>

function arc_great_circle(p1, p2, center = [0, 0, 0]) =
    let(
        radius = norm(p1 - center),
        normal_vt = cross(p2, p1),
        a = acos(p2 * p1 / pow(radius, 2)),
        steps = round(a / (360 / __frags(radius))),
        a_step = a / steps
    )
    [for(i = [0:steps]) ptf_rotate(p1, a_step * i, normal_vt)];