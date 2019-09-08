include <rounded_cylinder.scad>;
include <cross_sections.scad>;
include <rotate_p.scad>;
include <helix_extrude.scad>;
include <helix.scad>;
include <circle_path.scad>;
include <polysections.scad>;
include <arc.scad>;
include <ellipse_extrude.scad>;
include <shape_ellipse.scad>;
include <shape_glued2circles.scad>;
include <bezier_curve.scad>;
include <shape_pie.scad>;

part = "PREVIEW"; // [FRONT, SPRING, BACK, PREVIEW]

head_radius = 15;
spring_levels = 20;
line_thickness = 4;
line_distance = 1.5;

latch_r1 = 2.5;
latch_r2 = 3;
latch_h = 6;
latch_spacing = 0.4;


module latch_prototype(r1, r2, h) {
    rd = r2 - r1;
    
    linear_extrude(h) 
        circle(r1);
        
    translate([0, 0, h - rd]) 
        rotate_extrude() 
            translate([r2 - rd, 0, 0]) 
                circle(rd, $fn = 4);
}

module latch_convex(r1, r2, h) {
    rd = r2 - r1;
    
    difference() {
        latch_prototype(r1, r2, h);
        
        translate([0, 0, rd * 2])  
            linear_extrude(h - rd * 2) 
                square([rd * 2, r2 * 2], center = true);
    
    }
}

module latch_concave(r1, r2, h, spacing) {
    latch_prototype(r1 + spacing, r2 + spacing, h);
    translate([0, 0, h]) 
        linear_extrude(spacing) 
            circle(r2);
}


module toy_spring(radius, levels, sides, line_thickness, line_distance) {
    $fn = 4;
    
    spring = circle_path(radius = line_thickness / 2);

    helix_extrude(spring, 
        radius = radius, 
        levels = levels, 
        level_dist = line_thickness + line_distance,
        $fn = sides
    );
    
    if(line_distance != 0) {
        spring_gap = circle_path(radius = line_distance / 2);
        
        #translate([0, 0, line_thickness / 2 + line_distance / 2])
            helix_extrude(spring_gap, 
                radius = radius, 
                levels = levels, 
                level_dist = line_thickness + line_distance,
                $fn = sides
            );        
    }
}


module dog_back(head_r, latch_r1, latch_r2, latch_h) {
    $fn = 36;    

    module foot() {
        translate([head_r, 0, 0]) union() {
            color("PapayaWhip") ellipse_extrude(head_r / 3) polygon(
                shape_ellipse([head_r / 3, head_r / 2])
            );
            
            color("Maroon")  linear_extrude(head_r) circle(head_r / 8);
            
            color("Goldenrod") translate([head_r / 45, 0, head_r / 2]) rotate([0, -15, 0]) rounded_cylinder(
                radius = [head_r / 5, head_r / 3.5], 
                h = head_r * 1.25, 
                round_r = 2
            );            
        }    
    }


    module feet() {
        foot();
        mirror([1, 0, 0]) foot();
    }

    module body_feet() {
        translate([0, -head_r / 5, -head_r * 1.65]) 
            feet();

        union() {
            color("Goldenrod") scale([1, 1.25, 1]) difference() {
                sphere(head_r);
                
                translate([-head_r, head_r / 6, -head_r]) 
                    cube(head_r * 2);
            }
        }
    }

    module back() {
        mirror([0, 1, 0]) 
            body_feet();
        rotate([-36.5, 0, 0]) 
            color("Goldenrod") 
                linear_extrude(head_r * 2, scale = 0.5) 
                    circle(head_r / 6);
    }

    back();
        
    color("Goldenrod")  translate([0, -head_r * 0.2, 0]) 
        rotate([90, 0, 0]) 
            latch_convex(latch_r1, latch_r2, latch_h);
}

module spring_dog_spring(head_r, spring_levels, line_thickness, line_distance, latch_r1, latch_r2, latch_h, latch_spacing) {
    spring_sides = 36;
    h = spring_levels * line_thickness;

    module latch_plate_back() {
        difference() {
            linear_extrude(latch_h + latch_spacing) 
                circle(head_r);  
            
            latch_concave(latch_r1, latch_r2, latch_h, latch_spacing, $fn = spring_sides);
        }         
    }

    module latch_plate_front() {
        linear_extrude(latch_h + latch_spacing) 
            circle(head_r);  
        
        translate([0, 0, latch_h + latch_spacing]) 
            latch_convex(latch_r1, latch_r2, latch_h, $fn = spring_sides);      
    }    
    
    color("yellow") union() {
        latch_plate_back();
        
        translate([0, 0, line_thickness / 2])  toy_spring(
            head_r - line_thickness / 1.5, 
            spring_levels, 
            spring_sides, 
            line_thickness,
            line_distance
        );
        
        translate([0, 0, h + line_distance * spring_levels]) 
            latch_plate_front();
    }
}

module dog_front(head_r, latch_r1, latch_r2, latch_h, latch_spacing) {
    $fn = 36;
    
    module head() {

        module head_nose() {
            color("Goldenrod") 
                rotate([-15, 0, 0]) 
                    scale([1, 0.9, 0.9]) 
                        sphere(head_r);

            // nose
            color("PapayaWhip") 
                translate([0, -head_r * 0.45, -head_r / 5]) 
                    rotate([85, 0, 0]) 
                        scale([1.25, 0.8, 1]) 
                            rounded_cylinder(
                                radius = [head_r / 2, head_r / 6], 
                                h = head_r * 1.25, 
                                round_r = 4
                            );    

            color("black") 
                translate([0, -head_r * 1.6, 0]) 
                    rotate([15, 0, 0]) 
                        scale([1.25, 1, 1]) 
                            sphere(head_r / 7);    
        }
        
        module eye() {
            translate([head_r / 2, -head_r / 1.75, head_r / 3]) 
                rotate([-20, 5, 30]) 
                    scale([1.2, 0.5, 1]) union() {
                        color("Goldenrod") 
                            sphere(head_r / 3);

                         color("white") 
                             translate([0, 0, -head_r / 15]) 
                                 rotate([-25, -10, 0]) 
                                     scale([1.1, 1.25, 1.2]) 
                                         sphere(head_r / 3.5);
                     
                        color("black") 
                            translate([-head_r / 15, -head_r / 4, -head_r / 12]) 
                                sphere(head_r / 7);
                }    
        }
        
        module eyes() {
            eye();
            mirror([1, 0, 0]) 
                eye();
        }
        
        module eyebrow() {
            color("black") 
                translate([head_r / 2.5, -head_r / 2.5, head_r / 3]) 
                    rotate([60, 15, 30]) 
                        linear_extrude(head_r / 2, center = true) scale([1.5, 1, 1]) 
                            arc(radius = head_r / 3, angle = 120, width = head_r / 20);
            
        }
        
        module eyebrows() {
            eyebrow();
            mirror([1, 0, 0]) eyebrow();
        }
        
        shape_pts = shape_glued2circles(head_r / 2, head_r * 2.5, tangent_angle = 35);

        module ear() {
            color("Maroon") 
                rotate([-15, 0, -10]) 
                    translate([-head_r / 2.75, head_r / 15, -head_r / 2.75]) 
                        rotate([0, -60, 0]) 
                            scale([1.25, 1, 1]) intersection() {
                                translate([head_r, 0, 0]) 
                                    linear_extrude(head_r) 
                                        polygon(shape_pts); 

                                difference() {
                                    sphere(head_r);
                                    sphere(head_r - head_r / 10);
                                }
                            }    
        }   

        module ears() {
            ear();
            mirror([1, 0, 0]) ear();
        }    

        head_nose();
        eyes();
        eyebrows();
        ears();

    }


    module foot() {
        translate([head_r, -head_r / 11, 0]) union() {
            color("PapayaWhip") ellipse_extrude(head_r / 3) polygon(
                shape_ellipse([head_r / 3, head_r / 2])
            );
            
            color("Maroon")  linear_extrude(head_r) circle(head_r / 8);
            
            color("Goldenrod") translate([head_r / 45, 0, head_r / 2]) rotate([0, -15, 0]) rounded_cylinder(
                radius = [head_r / 5, head_r / 3.5], 
                h = head_r * 1.25, 
                round_r = 2
            );            
        }    
    }


    module feet() {
        foot();
        mirror([1, 0, 0]) foot();
    }

    module body_feet() {
        translate([0, -head_r / 5, -head_r * 1.65]) 
            feet();

        union() {
            color("Goldenrod") scale([1, 1.25, 1]) difference() {
                sphere(head_r);
                
                translate([-head_r, head_r / 6, -head_r]) 
                    cube(head_r * 2);
            }
        }
    }

    module front() {
        body_feet();

        // neck
        rotate([60, 0, 0]) 
            union() {
                color("Goldenrod") 
                    linear_extrude(head_r * 2) 
                        circle(head_r / 4);
                
                color("green") 
                    translate([0, 0, head_r * 1.1]) 
                        rotate([-10, 0, 0]) 
                            rotate_extrude() 
                                translate([head_r / 4, 0, 0]) 
                                    circle(head_r / 10);
            }
    }
    
        
    
    translate([0, -head_r * 1.75 , head_r * 1.3]) 
        head();
        
    difference() {
        front();
        
        translate([0, head_r * 0.209, 0]) rotate([90, 0, 0]) latch_concave(latch_r1, latch_r2, latch_h, latch_spacing, $fn = 36);    
    }
}

if(part == "FRONT") {
    dog_front(head_radius, latch_r1, latch_r2, latch_h, latch_spacing);
} else if(part == "SPRING") {
    spring_dog_spring(head_radius, spring_levels, line_thickness, line_distance, latch_r1, latch_r2, latch_h, latch_spacing);

} else if(part == "BACK") {
    dog_back(head_radius, latch_r1, latch_r2, latch_h);
}
else {
    dog_front(head_radius, latch_r1, latch_r2, latch_h, latch_spacing);
    translate([0, spring_levels * (line_thickness + line_distance) + latch_h + latch_spacing, 0]) {
        rotate([90, 0, 0]) spring_dog_spring(head_radius, spring_levels, line_thickness, line_distance, latch_r1, latch_r2, latch_h, latch_spacing);
            
        translate([0, 3.25, 0]) dog_back(head_radius, latch_r1, latch_r2, latch_h);
    }
}


