use <arc_path.scad>;
use <shape_circle.scad>;
use <path_extrude.scad>;
use <bezier_curve.scad>;
use <hull_polyline2d.scad>;
use <bspline_curve.scad>;

radius1 = 10;
radius2 = 20;
bottom_height = 60;
thickness = 1.5;
t_step = 0.025;
fn = 24;
cut = false; // [true,false]

module klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn) {
    $fn = fn;
    half_thickness = thickness / 2;

    module bottom() { 
        rotate(180) 
        rotate_extrude() {
            ph1 = arc_path(radius = radius2, angle = [180, 360]);
            ph2 = bezier_curve(t_step, [
                        [radius1 + radius2 * 2, 0, 0],
                        [radius1 + radius2 * 2, bottom_height * 0.25, 0],
                        [radius1 + radius2 * 0.5, bottom_height * 0.5, 0],
                        [radius1, bottom_height * 0.75, 0],
                        [radius1, bottom_height, 0]            
                    ]);
                
            path = concat([for(p = ph1) p + [radius1 + radius2, 0, 0]], ph2);
                
            hull_polyline2d(
                path, 
                thickness
            );      
        }
    }

    module tube() {
        mid_pts = [
            [0, 0, bottom_height + radius1 / 2],
            [0, 0, bottom_height + radius1],
            [0, 0, bottom_height + radius1 * 2], 
            [0, radius1, bottom_height + radius1 * 3.5],
            [0, radius1 * 2.5, bottom_height + radius1 * 3.75],
            [0, radius1 * 3.5, bottom_height + radius1 * 3.5],
            [0, radius1 * 4.5, bottom_height + radius1 * 2.5],  
            [0, radius1 * 4.5, bottom_height + radius1],
            [0, radius1 * 4.5, bottom_height], 
            [0, radius1 * 3.5, bottom_height - radius1], 
            [0, radius1 * 1, bottom_height - radius1 * 2], 
            [0, radius1 * 0.15, bottom_height + half_thickness - radius1 * 3], 
            [0, 0, bottom_height - radius1 * 4],
            [0, 0, bottom_height - radius1 * 5],
            [0, 0, bottom_height - radius1 * 6]
        ];
        
        degree = 2;
        bs_curve = bspline_curve(t_step, degree, mid_pts);

        tube_path = concat(
            [[0, 0, bottom_height]],
            bs_curve,
            [[0, 0, 0]]
        );

        tube_path2 = concat(
            [[0, 0, bottom_height - thickness]],
            bs_curve,
            [[0, 0, -thickness]]
        );

    difference() { 
            union() {
                bottom(); 

                rotate(-90) 
                path_extrude(
                    shape_circle(radius1 + half_thickness),
                    tube_path
                );
            }

            rotate(-90) 
            path_extrude(
                shape_circle(radius1 - half_thickness),
                tube_path2
            );
        }
    }

    tube();
}

module cutted_klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn) {
    difference() {
            union() {
                translate([radius2 + thickness, 0, 0]) 
                rotate([0, 90, 0]) 
                    klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn);
                translate([-radius2 - thickness, 0, 0]) 
                rotate([0, -90, 0]) 
                    klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn);

                
            }
            
            h = (radius1 + radius2) * 2;
            w = 2 * h;
            l = bottom_height * 4;
            translate([0, 0, h / 2]) 
                cube([l, w, h], center = true);
        }
}

if(cut) {
    cutted_klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn);
} else {
    klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn);
}