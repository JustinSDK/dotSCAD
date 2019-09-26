module joint_T(shaft_r, shaft_h, t_leng, ring_thickness, spacing = 0.5, center = false) {
    ring_r = shaft_r + spacing + ring_thickness;
    module joint_ring() {
        hollow_out(ring_thickness)
            circle(ring_r);
    }

    ring_height = shaft_h / 3 - spacing;
    half_h = shaft_h / 2;
    translate(center ? [0, 0, -half_h] : [0, 0, 0]) {
        linear_extrude(ring_height) 
            joint_ring();

        translate([0, 0, shaft_h - ring_height]) 
        linear_extrude(ring_height) 
            joint_ring();
            
        translate([t_leng / 2, 0, half_h]) 
        linear_extrude(shaft_h / 3, center = true)
            square([t_leng, shaft_r * 2], center = true);

        linear_extrude(shaft_h) 
            circle(shaft_r);        
    }
}