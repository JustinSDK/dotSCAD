use <shape_liquid_splitting.scad>
use <ring_extrude.scad>

$fn = 48;
r = 100;

module mobius_twins() {
    a_step = 20;
    half_a_step = 10;
    sr = 0.14 * r;
    half_r = r / 2;
    
    module mobius() {
        difference() {
            rotate(-a_step)
            ring_extrude(
                shape_liquid_splitting(5, half_r, 35), radius = r, twist = 180
            );
            union() {
                for(angle = [0: a_step: 360 - a_step]) {
                    rotate([0, 0, angle])
                    translate([r, 0, 0])
                    sphere(sr);
                }
            }
        }
    }
    
    mobius();
    rotate(90) mobius();
}

mobius_twins();

