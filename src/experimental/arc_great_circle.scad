use <__comm__/__frags.scad>
use <ptf/ptf_rotate.scad>

function arc_great_circle(p1, p2, center = [0, 0, 0]) =
    let(
        radius = norm(p1 - center),
        normal_vt = cross(p2, p1),
        a = acos(p2 * p1 / pow(radius, 2)),
        steps = round(a / (360 / __frags(radius)))
    )
    steps == 0 ? [p1, p2] :
    let(a_step = a / steps)
    [for(i = [0:steps]) ptf_rotate(p1, a_step * i, normal_vt)];

/*
use <experimental/arc_great_circle.scad>
use <voronoi/vrn_sphere.scad>
use <fibonacci_lattice.scad>
use <polyline_join.scad>

n = 10;
radius = 10;

points = fibonacci_lattice(n, radius);
#for(p = points) {
    translate(p)
        sphere(.5);
}

%sphere(radius);

for(cell = vrn_sphere(points)) {
    pts = concat(cell, [cell[0]]);

    for(i = [0:len(pts) - 2]) {
        p1 = pts[i];
        p2 = pts[i + 1];
        arc = arc_great_circle(pts[i], pts[i + 1], $fn = 36);
        polyline_join(arc)
            sphere(.5, $fn = 4);
    }
}
*/