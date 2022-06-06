use <hollow_out.scad>
use <archimedean_spiral.scad>

head_size = 26;
segments = 99; 
thickness = 3; 
spacing = 0.65;

module joint_Y(leng, width, height, ring_offset, thickness) {
    half_h = height / 2;
    half_thickness = thickness / 2;
    
    inner_leng = leng - thickness * 2;
    inner_width = width - thickness * 2;
    
	// U 
	linear_extrude(height, center = true) 
    difference() {
        hollow_out(thickness)
        offset(delta = thickness, chamfer = true) 
            square([inner_leng, inner_width], center = true);
		
        translate([-half_thickness - inner_leng / 2, 0, 0]) 
	        square([thickness, inner_width], center = true);
	}
    
	// ring
	r = half_h; 
    offset_x = ring_offset - r / 4;
    translate([half_h + inner_leng / 2 + half_thickness, 0, 0]) 
	rotate([90, 0, 0])
	linear_extrude(thickness, center = true) 
    difference() {
	    hull() {
			translate([offset_x, 0]) 
                circle(r);
			translate([-r / 2, 0, 0]) 
                square([r, height], center = true);
		}
		translate([offset_x, 0]) 
            circle(r - thickness);
	}
}

module moving_fish(head_size, segments, thickness, spacing) {
    joint_leng = thickness * 2;
    joint_height = thickness * 2 + spacing * 2;
    joint_thickness = joint_leng / 3;	
    joint_width = joint_thickness + (spacing + joint_thickness) * 2;
    ring_offset = joint_thickness / 2;

    module tri_bone(tri_side_leng) {
        double_spacing = spacing * 2;

        tri_r = tri_side_leng * 0.5773502;
        tri_r_m1 = tri_r - 1;
        half_tri_r_m1 = tri_r_m1 / 2;
        
        slot_leng = joint_thickness + double_spacing;
        
        translate([0, 0, half_tri_r_m1 + 1]) {
            translate([slot_leng, 0, joint_height / 2 - half_tri_r_m1 - 1])
            rotate([90, 0, 0]) 
                joint_Y(
                    joint_leng, 
                    joint_width, 
                    joint_height, 
                    joint_thickness/ 2 , 
                    joint_thickness
                );
            

            offset_x = (-tri_r - 1 + joint_width) / 2;
            rotate([0, -90, 0]) {
                // triangle
                linear_extrude(thickness, center = true)   
                difference() {
                    offset(r = 1) 
                        circle(tri_r_m1, $fn = 3);
                    
                    // slot
                    translate([offset_x, 0, 0]) 
                        square(
                            [
                                slot_leng, 
                                joint_height + double_spacing
                            ], 
                            center = true
                        );
                }
                
                // stick
                translate([offset_x, 0, 0]) 
                rotate([90, 0, 0]) 
                rotate([0, 90, 0]) 
                linear_extrude(slot_leng, center = true) 
                    circle(joint_height / 2 - joint_thickness - spacing);
            }
        }
    }

    module head(tri_leng) {
        tri_leng_d2 = tri_leng / 2;
        tri_leng_d4 = tri_leng / 4;
        tri_leng_d5 = tri_leng / 5;

        module eye() {
            translate([tri_leng_d4, tri_leng_d5, tri_leng_d5]) 
                sphere(tri_leng / 10);    
        }
               
        tri_r_m1 = tri_leng * 0.5773502 - 1;
        mr = tri_leng_d4 * 0.8660254;
        
        translate([0, 0, tri_r_m1 / 2 + 1]) 
        rotate([0, -90, 0]) {
            difference() {
                hull() {
                    linear_extrude(thickness, center = true) 
                    offset(r = 1) 
                        circle(tri_r_m1, $fn = 3);
                                
                    translate([tri_leng / 14 * 3, 0, tri_leng_d2]) 
                        sphere(mr);
                        
                    translate([-tri_leng_d4, 0, tri_leng_d2]) 
                        sphere(mr);
                }
                
                linear_extrude(tri_leng * 1.5, center = true) 
                translate([-tri_leng / 2 - tri_r_m1 / 2 - 1, 0, 0]) 
                    square([tri_leng, tri_leng], center = true);
                
                translate([0, 0, tri_leng / 1.25]) 
                rotate([90, 0, 0]) 
                scale([0.75, 1, 1]) 
                linear_extrude(tri_leng, center = true) 
                    circle(tri_leng / 1.5, $fn = 3);
            }
            
            // eyes
            eye();
            mirror([0, 1, 0]) eye();
        }
    }
    
    point_distance = joint_leng + ring_offset + spacing * 3;
	arm_distance = head_size; 
	init_angle = 540;
	num_of_points = segments + 2;	
    
    points_angles = archimedean_spiral(
        arm_distance = arm_distance,
        init_angle = init_angle,
        point_distance = point_distance,
        num_of_points = num_of_points
    ); 
     
    side_leng_step = 0.45 * head_size / segments;	

    // head
    rotate(init_angle) 
        translate(-points_angles[0][0]) 
        rotate(90) {
			tri_bone(head_size); 
			head(head_size);
		}
    
    // body
    leng_pts = len(points_angles);
    for(i = [1: leng_pts - 2]) {
        translate(points_angles[i][0])
        rotate(points_angles[i][1] + 90)
            tri_bone(head_size - side_leng_step * i);
    }
    
    tail_r = head_size / 3;
    // tail
    translate(points_angles[leng_pts - 1][0])
    linear_extrude(joint_height) 
    rotate(90 + points_angles[leng_pts - 2][1]) 
    translate([tail_r / 2, 0, 0]) {
        difference() {
            circle(tail_r);
            translate([tail_r * 0.75, 0, 0]) 
                circle(tail_r);
        }
        hollow_out(thickness / 2.4)
            circle(3 * thickness / 2.4);
    }
}

moving_fish(head_size, segments, thickness, spacing, $fn = 24);