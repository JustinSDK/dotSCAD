use <shape_circle.scad>;
use <rotate_p.scad>;
use <polysections.scad>;

r1 = 0.1;
r2 = 50;

a1 = 1;
a2 = 450;

steps = 40;

$fn = 48;

module simple_seashell(r1, r2, a1, a2, steps) {
    rd = (r2 - r1) / steps;
    ad = (a2 - a1) / steps;

    sections = [
        for (i = [0:steps])
        let(
            r = r1 + rd * i,
            a = a1 + i * ad
        )
        [
            for(p = concat(shape_circle(r), shape_circle(r * 0.9))) 
                rotate_p([p[0], p[1], 0] + [r, 0, 0], [0, a, 0])
        ]    
            
    ];

    rotate([90, 0, 0]) polysections(sections, "HOLLOW");
}

simple_seashell(r1, r2, a1, a2, steps);