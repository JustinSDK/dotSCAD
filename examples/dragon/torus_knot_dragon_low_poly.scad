use <bezier_curve.scad>
use <ellipse_extrude.scad>
use <path_extrude.scad>
use <torus_knot.scad>
use <util/reverse.scad>

use <dragon_head_low_poly.scad>

torus_knot_dragon_low_poly();

module torus_knot_dragon_low_poly() {
    phi_step = 0.04;

    knot = torus_knot(2, 3, phi_step);
    dragon_body_path = reverse([for(i = [9:len(knot) - 3]) knot[i]]);

    body_shape = concat(
        bezier_curve(0.25, 
            [
                [30, -35], [16, 0], [4, 13], 
                [3, -5], [0, 26], [-3, -5],
                [-4, 13],  [-16, 0], [-30, -35]
            ]
        ),
        bezier_curve(0.25, 
            [[-22, -35], [-15, -45], [0, -55], [15, -45], [22, -35]]
        )
    );    

    
    pts = [for(p = body_shape) p * 0.015];
    p = dragon_body_path[0];
    
    path_extrude(pts, [p + [0.00001, 0.0000055, 0.000008], each dragon_body_path], scale = 0.9);

    translate([2.975, -0.75, -0.75])      
    scale(0.01825)
    rotate([-52, -9, -25]) 
    dragon_head_low_poly(); 
    
    translate([1.84, 1.635, -0.885])
    rotate([104.95, -154.35, 66.25])
    ellipse_extrude(1.2, slices = 7, twist = 15)
    scale(0.9 * 0.0150)
        polygon(body_shape);
}