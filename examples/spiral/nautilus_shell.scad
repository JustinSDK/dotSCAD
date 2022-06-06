use <ptf/ptf_rotate.scad>
use <polyline_join.scad>
use <bezier_curve.scad>
use <ellipse_extrude.scad>

chambered_section_max_angle = 300;
steps = 25;
thickness = 1;
slices = 5;
semi_minor_axis = 10;
height = 5;

module nautilus_shell(chambered_section_max_angle, steps, thickness) {
    function r(a) = pow(2.71828, 0.0053468 * a);
    
    a_step = chambered_section_max_angle / steps;
    spiral = [
        for(a = [a_step:a_step:chambered_section_max_angle + 450])  
            ptf_rotate([r(a), 0], a)
    ];

    half_thickness = thickness / 2;

    polyline_join(spiral)
        circle(half_thickness);

    for(a = [a_step:a_step * 2:chambered_section_max_angle]) {
        a2 = a + 360;
        a3 = a + 420;
        p1 = ptf_rotate([r(a), 0], a);
        p2 = ptf_rotate((p1 + ptf_rotate([r(a2), 0], a2)) * .6, -5);
        p3 = ptf_rotate([r(a3), 0], a3);
        
        polyline_join(bezier_curve(0.1, [p1, p2, p3]))
            circle(half_thickness);
    }
}

ellipse_extrude(semi_minor_axis, height = height, slices = slices)
    nautilus_shell(chambered_section_max_angle, steps, thickness);

mirror([0, 0, 1])    
ellipse_extrude(semi_minor_axis, height = height, slices = slices)
    nautilus_shell(chambered_section_max_angle, steps, thickness);
