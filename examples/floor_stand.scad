include <util/sub_str.scad>;
include <util/split_str.scad>;
include <multi_line_text.scad>;

text = "Coder at Work";
font = "Arial Black";
font_size = 6;
line_spacing = 10;

stand_width = 40;
stand_height = 80;
stand_thickness = 4;
joint_spacing = 1;

module floor_stand(text, font, font_size, width, height, thickness, joint_spacing, line_spacing) {
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
        difference() {
            polygon(points);
            translate([0, -half_h, 0]) 
                scale([0.6, 0.1]) 
                    polygon(points);
        }
    }

    module word() {
        color("black")
        translate([0, 0, half_th]) 
            linear_extrude(half_th / 2) 
                union() {
                    difference() {
                        scale([0.85, 0.7]) 
                            polygon(points);
                        offset(r = -font_size / 4) 
                            scale([0.85, 0.7]) 
                                polygon(points);
                    }
                    multi_line_text(
                        split_str(text, " "),
                        font = font,
                        size = font_size,
                        line_spacing = line_spacing,    
                        valign = "center", 
                        halign = "center"
                    );
                }
    }

    module joint_top() {
        linear_extrude(thickness / 4 + half_sc, scale = 0.1) 
            circle(thickness / 4 + half_sc);
    }

    module stick() {
        linear_extrude(thickness * 0.75) 
            square([width / 12, half_w], center = true);    
    }
    
    module slot_df() {
        translate([0, -half_h - thickness, -half_th]) 
            stick();    
    }

    module board1() {
        difference() {
            union() {
                linear_extrude(thickness, center = true) 
                    difference() {
                        translate([0, -half_h, 0]) 
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
                
            // joint            
            translate([half_w / 1.5 , 0, 0])         
                rotate([0, 90, 0]) 
                    joint_top();

            translate([-half_w / 1.5 , 0, 0])  
                rotate([0, -90, 0]) 
                    joint_top();
                        
            slot_df();        
        }
    }

    module board2() {
        difference() {
            union() {
                linear_extrude(thickness, center = true) 
                    union() {
                        difference() {
                            translate([0, -half_h, 0]) 
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

                // joint
                translate([half_w / 1.5 - half_sc, 0, 0]) 
                    rotate([0, 90, 0]) 
                        joint_top();

                translate([-half_w / 1.5 + half_sc, 0, 0]) 
                    rotate([0, -90, 0]) 
                        joint_top();                
            }
            
            slot_df();
        }
    }

    module ground_df() {
        translate([0, 0, -height - half_th]) 
                linear_extrude(thickness) 
                    square(width, center = true);
    }

    // stick
    translate([width, 0, 0]) 
        stick();

    translate([0, 0, thickness / 2]) 
    rotate([-80, 0, 0]) 
    difference() {
        rotate([80, 0, 0]) union() {
            color("yellow") board1();
            translate([0, -height / 1.8, 0]) word();
        }
        ground_df();
    }

    translate([0, 0, thickness / 2]) 
    rotate([80, 0, 0]) 
    difference() {
        rotate([-80, 0, 0]) rotate(180) union() {
            color("yellow") board2();
            translate([0, -height / 1.8, 0]) word();
        }
        ground_df();
    }
}

floor_stand(text, font, font_size, stand_width, stand_height, stand_thickness, joint_spacing, line_spacing);