use <trim_shape.scad>
use <bezier_curve.scad>
use <path_scaling_sections.scad>
use <sweep.scad>
use <ptf/ptf_rotate.scad>
use <bijection_offset.scad>
use <shape_superformula.scad>

/* [Superformula] */
phi_step = 0.025;
m = 8;
n = 5;
n3 = 8;

/* [Offset] */
d = 0.1;

/* [Curve] */
r1 = 1;
r2 = 2;
h1 = 5;
h2 = 8;
t_step = 0.025;
twist = 90;

module superformula_vase(phi_step, m, n, n3, d, r1, r2, h1, h2, t_step, twist) {

    function cal_sections(shapt_pts, edge_path, twist) =
        let(
            sects = path_scaling_sections(shapt_pts, edge_path),
            leng = len(sects),
            twist_step = twist / leng
        )
        [
            for(i = [0:leng - 1]) 
            [
                for(p = sects[i]) 
                    ptf_rotate(p, twist_step * i)        
            ]
        ];

    superformula = shape_superformula(phi_step, m, m, n, n, n3);

    edge_path = bezier_curve(t_step, [
        [1, 0, 0],
        [4, 0, 3],
        [2, 0, 4],
        [r1, 0, h1],
        [1, 0, 6],
        [r2, 0, h2],
    ]);

    offseted = bijection_offset(superformula, d, epsilon = 0.0000001);

    edge_path2 = [for(p = edge_path) p + [d, 0, 0]];
    superformula2 = trim_shape(offseted, 3, len(offseted) - 1, epsilon = 0.0001);

    sections = cal_sections(superformula, edge_path, twist);
    outer_sections = cal_sections(superformula2, edge_path2, twist);

    difference() {
        sweep(outer_sections);
        sweep(sections);
    }

    linear_extrude(d) 
    rotate(twist - twist / len(sections)) 
        polygon(superformula2);    
}

superformula_vase(phi_step, m, n, n3, d, r1, r2, h1, h2, t_step, twist);
    