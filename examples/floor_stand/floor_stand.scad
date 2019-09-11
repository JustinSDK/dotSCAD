module floor_stand(width, height, thickness, joint_spacing) {
    half_w = width / 2;
    half_h = height / 2;
    half_th = thickness / 2;
    half_sc = joint_spacing / 2;

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

    module joint_tops(dist) {
        module joint_top() {
            linear_extrude(thickness / 4 + half_sc, scale = 0.1) 
                circle(thickness / 4 + half_sc);
        }

        half_d = dist / 2;
        translate([-half_d, 0, 0]) 
            rotate([0, -90, 0]) 
                joint_top();     

        translate([half_d, 0, 0]) 
            rotate([0, 90, 0]) 
                joint_top();
    } 

    module board1() {
        difference() {
            union() {
                linear_extrude(thickness, center = true) 
                    difference() {
                        board_base();
                        square([width / 1.5, height / 3], center = true);
                    } 
                rotate([0, 90, 0]) 
                    linear_extrude(width / 2.25 * 2, center = true) 
                        circle(thickness / 2);
            }

            rotate([0, 90, 0]) 
                linear_extrude(width / 1.5, center = true) 
                    circle(thickness, $fn = 24);
                   
            joint_tops(half_w / 1.5 * 2);          
        }
    }

    module board2() {
        linear_extrude(thickness, center = true) 
            union() {
                difference() {
                    board_base();
                    square([width, height / 3], center = true);
                }
                translate([0, -height / 12 - joint_spacing / 4, 0]) 
                    difference() {
                        square([width / 1.5 - joint_spacing, height / 6 + joint_spacing / 2], center = true);
                        square([width / 1.5 - thickness * 2, height / 6], center = true);
                    }
            }

        rotate([0, 90, 0]) 
            linear_extrude(width / 1.5 - joint_spacing, center = true) 
                circle(half_th, $fn = 24);

        joint_tops(half_w / 1.5 * 2 - joint_spacing);              
    }

    module border() {
        translate([0, 0, half_th]) 
            color("black") linear_extrude(half_th / 2) 
                hollow_out(shell_thickness = font_size / 4) 
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
                            translate([0, -height / 1.8, 0]) 
                                 border();
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
        decorate() board1();

    translate([0, 0, half_th]) 
        rotate(180)
            decorate() board2();
    
    children();
    rotate(180) 
        children();    
}