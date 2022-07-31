use <__comm__/__frags.scad>
use <ptf/ptf_rotate.scad>

function great_circle_arc(p1, p2) =
    let(
        radius = norm(p1),
        normal_vt = cross(p2, p1),
        a = asin(norm(normal_vt) / (p1 * p1)),
        steps = round(a / (360 / __frags(radius)))
    )
    steps == 0 ? [p1, p2] :
    let(a_step = a / steps)
    [for(i = [0:steps]) ptf_rotate(p1, a_step * i, normal_vt)];

/*
use <experimental/great_circle_arc.scad>
use <voronoi/vrn_sphere.scad>
use <fibonacci_lattice.scad>
use <polyline_join.scad>

use <util/dedup.scad>
use <util/sorted.scad>

include <__comm__/_str_hash.scad>

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

deduped = dedup(edges, function(e1, e2) sorted(e1) == sorted(e2), function(e) _str_hash(str(sorted(e))));

for(edge = deduped) {
    p1 = edge[0];
    p2 = edge[1];
    
    color("green") {
        translate(p1, $fn = 36)
            sphere(3);
        
        translate(p2)
            sphere(3, $fn = 36);
    }
        
    polyline_join(great_circle_arc(p1, p2, $fn = 96))
        sphere(2, $fn = 4);
}
*/

/*
use <experimental/great_circle_arc.scad>
use <voronoi/vrn_sphere.scad>
use <fibonacci_lattice.scad>

use <shape_star.scad>
use <path_extrude.scad>

use <util/dedup.scad>
use <util/sorted.scad>

include <__comm__/_str_hash.scad>

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

deduped = dedup(edges, function(e1, e2) sorted(e1) == sorted(e2), function(e) _str_hash(str(sorted(e))));

for(edge = deduped) {
        p1 = edge[0];
        p2 = edge[1];
        
        color("green") {
            translate(p1, $fn = 36)
                sphere(3);
            
            translate(p2)
                sphere(3, $fn = 36);
        }
            
        path_extrude(shape, great_circle_arc(p1, p2, $fn = 96));
}
*/