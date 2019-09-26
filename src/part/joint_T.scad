module joint_T(shaft_r, shaft_h, t_leng, ring_thickness, spacing = 0.5, center = false) {
    ring_r = shaft_r + spacing + ring_thickness;
    module joint_ring() {
        difference() {
            circle(ring_r);
            circle(ring_r - ring_thickness);
        }
    }

    half_h = shaft_h / 2;
    one_third_h = shaft_h / 3;

    ring_height = one_third_h - spacing;

    translate(center ? [0, 0, -half_h] : [0, 0, 0]) {
        linear_extrude(ring_height) 
            joint_ring();

        translate([0, 0, shaft_h - ring_height]) 
        linear_extrude(ring_height) 
            joint_ring();
            
        translate([t_leng / 2, 0, half_h]) 
        linear_extrude(one_third_h, center = true)
            square([t_leng, shaft_r * 2], center = true);

        linear_extrude(shaft_h) 
            circle(shaft_r);        
    }
}