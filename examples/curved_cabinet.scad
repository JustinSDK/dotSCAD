use <bezier_curve.scad>
use <sweep.scad>
use <matrix/m_transpose.scad>
use <util/sum.scad>

size = [100, 50, 120];
shelf_thickness = 1.5;
draw_thickness = 1.25;
drawer_numbers = 3;
spacing = 0.8;

curved_cabinet(size, shelf_thickness, draw_thickness, drawer_numbers, spacing);

module curved_cabinet(size, shelf_thickness, draw_thickness, drawer_numbers, spacing) {
    p0 = [size.x * 0.5, size.y * 0.5, 0];
    p1 = [size.x * 0.75, size.y * 0.5, size.z * 0.25];
    p2 = [size.x * 0.5, size.y * 0.5, size.z * 0.5];
    p3 = [size.x * 0.25, size.y * 0.5, size.z * 0.75];
    p4 = [size.x * 0.5, size.y * 0.5, size.z];

    control_points = [p0, p1, p2, p3, p4];

    t_step = 1 / (drawer_numbers * 10 + 2);

    path1 = bezier_curve(t_step, control_points);
    path2 = bezier_curve(t_step, [for(p = control_points) p - [size.x, 0, 0]]);
    path3 = bezier_curve(t_step, [for(p = control_points) p - [size.x, size.y, 0]]);
    path4 = bezier_curve(t_step, [for(p = control_points) p - [0, size.y, 0]]);

    path_leng = len(path1);

    step = floor((path_leng - 2) / drawer_numbers);

    drawer_profiles = [
        for(i = [0:drawer_numbers - 1])
        let(start = i * step + 1)
            concat(
            [
                for(j = [start:start+step]) 
                let(p = path1[j])
                [p.x, p.z]
            ],
            [
                for(j = start+step; j >= start; j = j - 1) 
                let(p = path2[j])
                [p.x, p.z]
            ]
        )
    ];

    drawer_profiles2 = [
        for(i = [0:drawer_numbers - 1])
        let(start = i * step + 1)
            concat(
            [
                for(j = [start:start+step + 1]) 
                let(p = path1[j])
                [p.x, p.z]
            ],
            [
                for(j = start+step + 1; j >= start; j = j - 1) 
                let(p = path2[j])
                [p.x, p.z]
            ]
        )
    ];

    color("white")
    difference() {
        sweep(m_transpose([path4, path3, path2, path1]));
        
        translate([0, size.y * 0.5 - shelf_thickness, 0])
        rotate([90, 0, 0])
        linear_extrude(size.y)
        for(profile = drawer_profiles) {
            offset(-shelf_thickness)
                polygon(profile);
        }
    }

    translate([0, size.y * 0.5 - shelf_thickness - spacing * 0.5, 0])
    rotate([90, 0, 0])
    for(i = [0:drawer_numbers - 1]) {
        translate([0, 0, size.y * 0.9 - size.y / drawer_numbers * i]) {
            color(rands(0, 1, 3))
            difference() {
                linear_extrude(size.y - shelf_thickness - spacing * 0.5)
                offset(-shelf_thickness - spacing * 0.5)
                    polygon(drawer_profiles[i]);

                translate([0, 0, draw_thickness])
                linear_extrude(size.y - shelf_thickness - draw_thickness * 2)
                offset(-shelf_thickness - spacing * 0.5 - draw_thickness)
                    polygon(drawer_profiles2[i]);
            }
            
            color(rands(0, 1, 3))
            translate([0, 0, size.y - draw_thickness * 2])
            translate(sum(drawer_profiles[i]) / len(drawer_profiles[i]))
            difference() {
                linear_extrude(draw_thickness * 4)
                offset(1)
                    text("~", 
                        font = "Arial Black", 
                        size = size.z / drawer_numbers / 2,
                        valign = "center", 
                        halign = "center"
                    );
                linear_extrude(draw_thickness * 3)
                    square([size.y / 4, size.z / 5], center = true);
            }
        }
    }
}