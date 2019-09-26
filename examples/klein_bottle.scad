include <polysections.scad>;
include <arc_path.scad>;
include <circle_path.scad>;
include <path_extrude.scad>;
include <bezier_curve.scad>;
include <polyline2d.scad>;
include <line2d.scad>;
include <rotate_p.scad>;

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
            translate([radius1 + radius2, 0, 0]) 
                polyline2d(
                     arc_path(radius = radius2, angle = [180, 360])
                     ,thickness
                );
                
            polyline2d(
                bezier_curve(t_step, [
                    [radius1 + radius2 * 2, 0, 0],
                    [radius1 + radius2 * 2, bottom_height * 0.25, 0],
                    [radius1 + radius2 * 0.5, bottom_height * 0.5, 0],
                    [radius1, bottom_height * 0.75, 0],
                    [radius1, bottom_height, 0]            
                ]), 
                thickness
            );      
        }
    }

    module tube() {

        mid_pts = [
            [0, 0, bottom_height + radius1],
            [0, 0, bottom_height + radius1 * 2], 
            [0, radius1, bottom_height + radius1 * 3],
            [0, radius1 * 2, bottom_height + radius1 * 3],
            [0, radius1 * 3, bottom_height + radius1 * 3],
            [0, radius1 * 4, bottom_height + radius1 * 2],  
            [0, radius1 * 4, bottom_height + radius1],
            [0, radius1 * 4, bottom_height], 
            [0, radius1 * 3, bottom_height - radius1], 
            [0, radius1 * 2, bottom_height - radius1 * 2], 
            [0, radius1, bottom_height + half_thickness - radius1 * 3], 
            [0, 0, bottom_height - radius1 * 4],
            [0, 0, bottom_height - radius1 * 5]
        ];

        tube_path = bezier_curve(
            t_step, 
            concat(
                concat([[0, 0, bottom_height]], mid_pts), 
                [[0, 0, 0]]
            )
        );

        tube_path2 = bezier_curve(
            t_step, 
            concat(
                concat([[0, 0, bottom_height - thickness]], mid_pts), 
                [[0, 0, -thickness] ]
            )
        );

        difference() { 
            union() {
                bottom(); 

                path_extrude(
                    circle_path(radius1 + half_thickness),
                    tube_path
                );
            }

            path_extrude(
                circle_path(radius1 - half_thickness),
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
                    rotate([0, 90, 0]) klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn);
                translate([-radius2 - thickness, 0, 0]) 
                    rotate([0, -90, 0]) klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn);

                
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




