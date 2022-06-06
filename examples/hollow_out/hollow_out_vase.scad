use <polyline_join.scad>
use <bezier_curve.scad>
use <ptf/ptf_rotate.scad>
use <matrix/m_transpose.scad>
use <experimental/hollow_out_sweep.scad>
use <experimental/tri_bisectors.scad>

t_step = 0.1;
line_diameter = 3;
fn = 18;
line_style = "HULL_LINES"; // [LINES, HULL_LINES]

p0 = [30, 0, 0];
p1 = [80, 0, 50];
p2 = [0, 0, 60];
p3 = [25, 0, 120];
p4 = [35, 0, 130];

hollow_out_vase([p0, p1, p2, p3, p4], t_step, line_diameter, fn, line_style);

module hollow_out_vase(ctrl_pts, t_step, line_diameter, fn, line_style) {
    line_r = line_diameter / 2;
    bezier = bezier_curve(t_step, 
        ctrl_pts
    );
    
    fpt = ctrl_pts[len(ctrl_pts) - 1];

    a_step = 360 / fn;
    sects = m_transpose([
        for(a = [0:a_step:360 - a_step])
        [for(p = bezier) ptf_rotate(p, [0, 0, a])]
    ]);
    
    // body
    hollow_out_sweep(sects, diameter = line_diameter, style = line_style, $fn = 4);

    leng_sect = len(sects[0]);

    // bottom
    fst_sect = sects[0];
    fst_tris = [
        each [for(i = [0:leng_sect - 2]) [[0, 0, 0], fst_sect[i], fst_sect[i + 1]]],
        [[0, 0, 0], fst_sect[leng_sect - 1], fst_sect[0]]
    ];

    for(tri = fst_tris) {
        lines = tri_bisectors(tri);
        for(line = lines) {
            polyline_join(line)
			    sphere(line_r, $fn = 4);
        }
		polyline_join([lines[2][1], [0, 0, 0]])
			sphere(line_r, $fn = 4);
    }

    // mouth
    lst_sect = sects[len(sects) - 1];
    lst_tris = [
        each [for(i = [0:leng_sect - 2]) [[0, 0, fpt[2]], lst_sect[i], lst_sect[i + 1]]],
        [[0, 0,  fpt[2]], lst_sect[leng_sect - 1], lst_sect[0]]
    ];
    dangling_pts = [for(tri = lst_tris) tri_bisectors(tri)[1][1]];
    offset_z = [0, 0, line_diameter];
    for(i = [0: leng_sect - 1]) {
	    polyline_join([lst_sect[i] + offset_z, dangling_pts[i]])
			sphere(line_r, $fn = 4);
		
		polyline_join([lst_sect[(i + 1) % leng_sect] + offset_z, dangling_pts[i]])
			sphere(line_r, $fn = 4);
    }
}