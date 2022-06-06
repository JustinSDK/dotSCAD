use <hollow_out.scad>
use <part/cone.scad>

module floor_stand(width, height, thickness, spacing) {
    half_w = width / 2;
    half_h = height / 2;
    half_th = thickness / 2;

    double_spacing = spacing * 2;

    $fn = 24;

    points = [
        [half_w, -half_h], [width / 2.25, half_h], 
        [-width / 2.25, half_h], [-half_w, -half_h]
    ];

    module board_base() {
        translate([0, -half_h, 0]) 
        difference() {
            polygon(points);

            translate([0, -half_h, 0]) 
            scale([0.6, 0.1]) 
                polygon(points);
        }
    }

    module board_U() {
        angles = [0, 90, 0];
        difference() {
            union() {
                linear_extrude(thickness, center = true) 
                difference() {
                    board_base();
                    square([width / 1.5, height / 3], center = true);
                } 
                rotate(angles) 
                linear_extrude(width / 2.25 * 2, center = true) 
                    circle(half_th);
            }

            rotate(angles) {
                linear_extrude(width / 1.5, center = true) 
                    circle(thickness, $fn = 24);

                cone(half_th - spacing, length = half_w / 1.5 - spacing, spacing = spacing, ends = true, void = true);
            }      
        }
    }

    module board_T() {
        linear_extrude(thickness, center = true) { 
            difference() {
                board_base();
                square([width, height / 3], center = true);
            }
            
            translate([0, -height / 12 - spacing / 2, 0]) 
            difference() {
                square([width / 1.5 - double_spacing, height / 6 + spacing], center = true);
                square([width / 1.5 - thickness * 2, height / 6], center = true);
            }
        }

        rotate([0, 90, 0]) {
            linear_extrude(width / 1.5 - double_spacing, center = true) 
                circle(half_th, $fn = 24);
            cone(half_th - spacing, length = half_w / 1.5 - spacing, spacing = spacing, ends = true);           
        }
    }

    module border() {
        translate([0, 0, half_th]) 
        color("black") 
        linear_extrude(half_th / 2) 
        hollow_out(shell_thickness = thickness / 2) 
        offset(half_w / 10) 
        scale([0.75, 0.675]) 
            polygon(points);
    }  

    module stick() {
        linear_extrude(thickness * 0.75) 
            square([width / 12, half_w], center = true);    
    }

    module decorate() {
        rotate([-80, 0, 0]) 
        difference() {
            rotate([80, 0, 0]) 
            difference() {
                union() {
                    color("yellow") children();
                    translate([0, -height / 1.8, 0]) border();
                }
                // slot
                translate([0, -half_h - thickness, -half_th]) 
                    stick();    
            }

            translate([0, 0, -height - half_th]) 
            linear_extrude(thickness) 
                square(width, center = true);
        }
    }
    // stick
    translate([width, 0, 0]) 
        stick();

    translate([0, 0, half_th]) 
    decorate() 
        board_U();

    translate([0, 0, half_th]) 
    rotate(180)
    decorate() 
        board_T();

    children(0);
    if($children == 1) {
        rotate(180) 
            children(0);    
    }
    else {
        children(1);
    }
}