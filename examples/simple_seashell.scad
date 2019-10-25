include <circle_path.scad>;
include <rotate_p.scad>;
include <polysections.scad>;

r1 = 15;
r2 = 50;

a1 = 1;
a2 = 450;

steps = 40;

module simple_seashell(r1, r2, a1, a2, steps) {
    rd = (r2 - r1) / steps;
    ad = (a2 - a1) / steps;

    sections = [
        for (i = [0:steps])
        let(
            r = r1 + rd * i,
            a = a1 + i * ad
        )
            [for(p = concat(circle_path(r), circle_path(r * 0.9))) 
                rotate_p([p[0], p[1], 0] + [r, 0, 0], [0, a, 0])]    
            
    ];

    rotate([90, 0, 0]) polysections(sections, "HOLLOW");
}

simple_seashell(r1, r2, a1, a2, steps);