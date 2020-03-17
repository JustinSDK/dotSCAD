use <shape_circle.scad>;
use <ring_extrude.scad>;

ball_radius = 10;
mobius_radius = 30;
ring_radius = 60; 
spacing = 0.5;
with_ball = "YES";
fn = 96;

module bearing_captured_in_mobius_cut(ball_radius, mobius_radius, ring_radius, spacing, with_ball, fn) {
    $fn = fn;

    ball_track_radius = ball_radius + spacing;
    trans_pt = [mobius_radius - ball_track_radius + ball_track_radius / 3, 0, 0];

    circle_points = [for(p = shape_circle(ball_track_radius)) p + trans_pt];

    difference() {
        rotate_extrude() 
        translate([ring_radius, 0, 0]) 
            circle(mobius_radius);
            
        ring_extrude(circle_points, radius = ring_radius, twist = 180);
        
        rotate([180, 0, 0]) 
            ring_extrude(circle_points, radius = ring_radius, twist = 180);        
    }
    
    if(with_ball == "YES") {
        translate([ring_radius, 0, 0] + trans_pt) sphere(ball_radius);
    }
}

bearing_captured_in_mobius_cut(ball_radius, mobius_radius, ring_radius, spacing, with_ball, fn);