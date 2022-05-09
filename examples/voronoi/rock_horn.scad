use <golden_spiral.scad>;
use <sweep.scad>;
use <noise/nz_worley3.scad>;
use <shape_circle.scad>;
use <ptf/ptf_rotate.scad>;

detail = 4;
seed = 5;

rock_horn(detail, seed);

module rock_horn(detail, seed) {
    $fn = 64 * detail;
    point_distance = 1 / detail;

    scale = 4;
    radius = 6;
    thickness = 1.5;
    
    c = shape_circle(radius = radius);

    pts_angles = golden_spiral(
        from = 8, 
        to = 8, 
        point_distance = point_distance,
        rt_dir = "CT_CLK"
    );

    leng = len(pts_angles);
    scale_step = scale / leng;
    h_step = 2 * scale * radius / leng;
    sections = [
        for(i = [0:leng - 1])
        let(
            pts = [
                for(p = c) 
                let(
                    s = 1 + scale_step * i,
                    nzp = [p.x * s, p.y * s, h_step * i],
                    nz = nz_worley3(nzp.x, nzp.y, nzp.z, seed, radius, "border")
                )
                [nzp.x, nzp.y, 0] + [sign(p.x), sign(p.y), 0] * nz[3] / scale
            ]
        )
        [
            each pts,
            each [
                for(p = pts) 
                p - [sign(p.x), sign(p.y), 0] * thickness
            ]
        ]
    ] / scale;
   
    rx = [90, 0, 0];
    sweep(
        [
            for(i = [0:leng - 1])
            let(
                section = sections[i],
                pt_angle = pts_angles[i],
                off = [pt_angle[0].x, pt_angle[0].y, 0],
                a = pt_angle[1]
            )
            [
                for(p = section)
                off + ptf_rotate(ptf_rotate(p, rx), a)
            ]
        ], 
        "HOLLOW"
    );
}