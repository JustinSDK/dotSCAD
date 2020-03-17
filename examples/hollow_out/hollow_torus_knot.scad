use <torus_knot.scad>;
use <cross_sections.scad>;
use <shape_circle.scad>;
use <shape_pentagram.scad>;
use <experimental/tri_bisectors.scad>;
use <experimental/hollow_out_sweep.scad>;

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
    function angy_angz(p1, p2) = 
        let(
            dx = p2[0] - p1[0],
            dy = p2[1] - p1[1],
            dz = p2[2] - p1[2],
            ya = atan2(dz, sqrt(dx * dx + dy * dy)),
            za = atan2(dy, dx)
        ) [ya, za];

    function sects_by_path(shape, path) =
        let(
            lines = [
                for(i = [0:len(path) - 2])
                [path[i], path[i + 1]]
            ],
            angles = [
                for(line = lines)
                let(a = angy_angz(line[0], line[1]))
                [0, 90 - a[0], a[1]]
            ]
        )
       cross_sections(shape, path, concat([angles[0]], angles));
    
    pts = torus_knot(p, q, phi_step);
    sects = sects_by_path(shape, pts);

    hollow_out_sweep(sects, thickness, closed = true, style = line_style);
}