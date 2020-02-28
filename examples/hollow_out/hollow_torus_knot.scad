use <torus_knot.scad>;
use <cross_sections.scad>;
use <util/rand.scad>;
use <circle_path.scad>;
use <shape_pentagram.scad>;
use <hull_polyline3d.scad>;
use <experimental/tri_bisectors.scad>;

p = 2;
q = 3;
phi_step = 0.075;
thickness = .1;
shape = shape_pentagram(.5); // circle_path(radius = .5, $fn = 12);

hollow_out_torus_knot(shape, p, q, phi_step, thickness, $fn = 4);

module hollow_out_torus_knot(shape, p, q, phi_step, thickness) {
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

    function rects(sects) = 
        let(
            sects_leng = len(sects),
            shape_pt_leng = len(sects[0])
        )
        [
            for(i = [0:sects_leng - 1])
                let(
                    sect1 = sects[i],
                    sect2 = sects[(i + 1) % sects_leng]
                )
                for(j = [0:shape_pt_leng - 1])
                    let(k = (j + 1) % shape_pt_leng)
                    [sect1[j], sect1[k], sect2[k], sect2[j]]
        ];
        
    function rand_tris(rect) =
        let(
            i = ceil(rand() * 10) % 2
        )
        i == 0 ?
            [[rect[0], rect[1], rect[2]], [rect[0], rect[2], rect[3]]] :
            [[rect[1], rect[2], rect[3]], [rect[1], rect[3], rect[0]]];        
    
    
    pts = torus_knot(p, q, phi_step);
    sects = sects_by_path(shape, pts);

    for(rect = rects(sects)) {
        for(tri = rand_tris(rect)) {
            for(line = tri_bisectors(tri)) {
                hull_polyline3d(line, thickness = thickness);
            }
        }
    }
}