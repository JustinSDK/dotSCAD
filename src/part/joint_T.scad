module joint_T(shaft_r, shaft_h, t_leng, ring_thickness, spacing) {
    ring_r = shaft_r + spacing + ring_thickness;
    module joint_ring() {
        hollow_out(ring_thickness)
            circle(ring_r);
    }

    ring_height = shaft_h / 3 - spacing;
    linear_extrude(ring_height) joint_ring();
    translate([0, 0, shaft_h - ring_height]) 
        linear_extrude(ring_height) joint_ring();
        
    translate([0, 0, shaft_h / 2]) 
        linear_extrude(shaft_h / 3, center = true) 
            line2d([0, 0], [t_leng, 0], shaft_r * 2, p1Style = "CAP_BUTT", p2Style = "CAP_BUTT");

    linear_extrude(shaft_h) circle(shaft_r);
}