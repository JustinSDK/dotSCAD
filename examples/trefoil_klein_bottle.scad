use <arc_path.scad>;
use <shape_circle.scad>;
use <path_extrude.scad>;
use <bezier_curve.scad>;
use <bspline_curve.scad>;
use <hull_polyline2d.scad>;

thickness = 4.5;
t_step = 0.05;
fn = 24;
cut = true; // [true,false]

module dis_connected_klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn) {
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
                        [radius1, bottom_height * 1.015, 0]            
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
            [0, radius1 * 8, bottom_height + radius1 * 1.7225],
            [0, radius1 * 5, bottom_height], 
            [0, radius1 * 3.5, bottom_height - radius1], 
            [0, radius1 * 1, bottom_height - radius1 * 2], 
            [0, radius1 * 0.15, bottom_height + half_thickness - radius1 * 3], 
            [0, 0, bottom_height - radius1 * 4],
            [0, 0, bottom_height - radius1 * 5],
            [0, 0, bottom_height - radius1 * 6]
        ];

        mid_pts2 = [ 
            [0, radius1 * 8.0001, bottom_height + radius1 * 1.7226],
            [0, radius1 * 5, bottom_height], 
            [0, radius1 * 3.5, bottom_height - radius1], 
            [0, radius1 * 1, bottom_height - radius1 * 2], 
            [0, radius1 * 0.15, bottom_height + half_thickness - radius1 * 3], 
            [0, 0, bottom_height - radius1 * 4],
            [0, 0, bottom_height - radius1 * 5],
            [0, 0, bottom_height - radius1 * 6]
        ];        
        
        degree = 2;
        bs_curve = bspline_curve(t_step, degree, mid_pts);
        bs_curve2 = bspline_curve(t_step, degree, mid_pts2);

        tube_path = concat(
            bs_curve,
            [[0, 0, 0]]
        );

        tube_path2 = concat(
            bs_curve2,
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

module trefoil_klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn) {
    rotate(90)
    dis_connected_klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn);
    
    translate([0, -26.9, 151.35]) // try-and-error
    rotate([-120, 0, 0])
    rotate(90)
    dis_connected_klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn);
    
    translate([0, 117.59, 98.975])  // try-and-error
    rotate([120, 0, 0])
    rotate(90)
    dis_connected_klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn);  
}

module trefoil_cutted_klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn) {
    difference() {
            union() {
                translate([radius2 + thickness, 0, 0]) 
                rotate([0, 90, 0]) 
                    trefoil_klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn);
                translate([-radius2 - thickness, 0, 0]) 
                rotate([0, -90, 0]) 
                    trefoil_klein_bottle(radius1, radius2, bottom_height, thickness, t_step, fn);

                
            }
            
            h = (radius1 + radius2) * 2;
            w = 6 * h;
            l = bottom_height * 8;
            translate([0, 0, h / 2]) 
                cube([l, w, h], center = true);
        }
}

{
    // Fixed. Don't change it!
    RADIUS1 = 10;
    RADIUS2 = 20;
    BOTTOM_HEIGHT = 60;

    if(cut) {
        trefoil_cutted_klein_bottle(RADIUS1, RADIUS2, BOTTOM_HEIGHT, thickness, t_step, fn);
    } else {
        trefoil_klein_bottle(RADIUS1, RADIUS2, BOTTOM_HEIGHT, thickness, t_step, fn);
    }    
}
