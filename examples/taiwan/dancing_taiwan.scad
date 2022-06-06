use <trim_shape.scad>
use <bezier_curve.scad>
use <shape_taiwan.scad>
use <path_scaling_sections.scad>
use <sweep.scad>
use <ptf/ptf_rotate.scad>
use <bijection_offset.scad>

x1 = 4; // [-20:4]
x2 = 3; // [-20:4]
x3 = 4; // [-20:4]
y1 = 20; 
y2 = 40;
y3 = 90;
twist = -90;
t_step = 0.1;

module dancing_formosan(x1, x2, x3, y1, y2, y3, twist, t_step) {

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

    taiwan = shape_taiwan(100, 0.6);
    fst_pt = [13, 0, 0];

    edge_path = bezier_curve(t_step, [
        fst_pt,
        fst_pt + [0, 0, 10],
        fst_pt + [x1, 0, y1],
        fst_pt + [x2, 0, 35],
        fst_pt + [x3, 0, y2],
        fst_pt + [0, 0, 55],
        fst_pt + [0, 0, y3]
    ]);


    offseted = bijection_offset(taiwan, -2);

    edge_path2 = [for(p = edge_path) p + [-2, 0, 0]];
    taiwan2 = trim_shape(offseted, 1, len(offseted) - 4);

    sections = cal_sections(taiwan, edge_path, twist);
    sections2 = cal_sections(taiwan2, edge_path2, twist);

    difference() {
        sweep(sections);
        sweep(sections2);
    }

    translate([0, 0, -2]) 
    linear_extrude(2) 
    rotate(twist - twist / len(sections)) 
        polygon(taiwan);

}

dancing_formosan(x1, x2, x3, y1, y2, y3, twist, t_step);
    
