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
    [for(i = [0:steps]) ptf_rotate(p1, a_step * i, normal_vt) + center];

/*
use <experimental/arc_great_circle.scad>
use <voronoi/vrn_sphere.scad>
use <fibonacci_lattice.scad>
use <polyline_join.scad>

use <util/dedup.scad>
use <util/reverse.scad>

n = 8;
radius = 20;

points = fibonacci_lattice(n, radius);
#for(p = points) {
    translate(p)
        sphere(1);
}

%sphere(radius);

edges = [
    for(cell = vrn_sphere(points))
    for(i = [0:len(cell) - 2])
    [cell[i], cell[i + 1]]    
];

deduped = dedup(edges, function(e1, e2) e1 == e2 || reverse(e1) == e2, function(e) 0, number_of_buckets = 1);

for(edge = deduped) {
        p1 = edge[0];
        p2 = edge[1];
        
        color("green") {
            translate(p1, $fn = 36)
                sphere(3);
            
            translate(p2)
                sphere(3, $fn = 36);
        }
            
        polyline_join(arc_great_circle(p1, p2, $fn = 96))
            sphere(2, $fn = 4);
}
*/

/*
use <experimental/arc_great_circle.scad>
use <voronoi/vrn_sphere.scad>
use <fibonacci_lattice.scad>

use <shape_star.scad>
use <path_extrude.scad>

use <util/dedup.scad>
use <util/reverse.scad>

n = 8;
radius = 20;

points = fibonacci_lattice(n, radius);
#for(p = points) {
    translate(p)
        sphere(1);
}

%sphere(radius);

shape = shape_star(inner_radius = .5) * 2;

edges = [
    for(cell = vrn_sphere(points))
    for(i = [0:len(cell) - 2])
    [cell[i], cell[i + 1]]    
];

deduped = dedup(edges, function(e1, e2) e1 == e2 || reverse(e1) == e2, function(e) 0, number_of_buckets = 1);

for(edge = deduped) {
        p1 = edge[0];
        p2 = edge[1];
        
        color("green") {
            translate(p1, $fn = 36)
                sphere(3);
            
            translate(p2)
                sphere(3, $fn = 36);
        }
            
        path_extrude(shape, arc_great_circle(p1, p2, $fn = 96));
}
*/