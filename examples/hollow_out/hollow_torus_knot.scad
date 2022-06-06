use <torus_knot.scad>
use <cross_sections.scad>
use <shape_circle.scad>
use <shape_pentagram.scad>
use <experimental/tri_bisectors.scad>
use <experimental/hollow_out_sweep.scad>

p = 2;
q = 3;
phi_step = 0.075;
thickness = .1;
section_style = "STAR";    // [STAR, CIRCLE]
line_style = "HULL_LINES"; // [LINES, HULL_LINES]

if(section_style == "STAR") {
    hollow_out_torus_knot(shape_pentagram(.5), p, q, phi_step, thickness, line_style);
}
else {
    hollow_out_torus_knot(shape_circle(radius = .5, $fn = 12), p, q, phi_step, thickness, line_style);
}

module hollow_out_torus_knot(shape, p, q, phi_step, thickness, line_style) {
    function __angy_angz(p1, p2) = 
        let(v = p2 - p1) 
        [
            atan2(v.z, norm([v.x, v.y])), 
            atan2(v.y, v.x)
        ];

    function sects_by_path(shape, path) =
        let(
            lines = [
                for(i = [0:len(path) - 2])
                [path[i], path[i + 1]]
            ],
            angles = [
                for(line = lines)
                let(a = __angy_angz(line[0], line[1]))
                [0, 90 - a[0], a[1]]
            ]
        )
       cross_sections(shape, path, [angles[0], each angles]);
    
    pts = torus_knot(p, q, phi_step);
    sects = sects_by_path(shape, pts);

    hollow_out_sweep(sects, thickness, closed = true, style = line_style);
}