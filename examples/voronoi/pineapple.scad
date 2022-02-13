use <fibonacci_lattice.scad>;
use <shape_superformula.scad>;   
use <ring_extrude.scad>;
use <polyhedron_hull.scad>;
use <voronoi/vrn_sphere.scad>;
use <util/rand.scad>;

eye_number = 150;
leaf_number = 7;
leaf_step = 0.5;
leaf_fn = 36;

pineapple(eye_number, leaf_step, leaf_number, leaf_fn);

module pineapple(eye_number, leaf_step, leaf_number, leaf_fn) {
    real_eye_number = eye_number + rand(0, 10);   
    pts = fibonacci_lattice(real_eye_number, 1);
    regions = vrn_sphere(pts);
    
    scale(50) {
        mirror([0, 0, 1])
        scale([1, 1, 1.3])
        union() {
            for(i = [0:real_eye_number - 1]) {
                polyhedron_hull(concat(regions[i], [pts[i] * 1.075]));
            }
            sphere(1.0015, $fn = 96);
        }

        // leaves
        shape = [
            for(p = shape_superformula(leaf_step, 3, 3, 4.5, 10, 10)) 
                p.x > 0 ? 
                    [p.x * abs(p.y / 1.75) / 10, p.y / 10] : 
                    [p.x * 0.03, p.y / 10]
        ];

        color("Olive")
        translate([0, 0, 1.2])
        scale([1.75, 1.75, 1]) {
            $fn = leaf_fn;
            a_step = 360 / leaf_number;
            
            scale([1.2, 1.1, 4])
            translate([-.475, 0, 0])
            rotate([90, 0, 0])
                ring_extrude(shape, radius = .5, angle = 60, scale = .025, twist = rand(5, 45));
            
            rand_angles = rands(0, 90, 3);

            range = [0:leaf_number - 1];
            for(i = range) {
                rotate(i * a_step + rand_angles[0])
                scale([1, 1, 3])
                translate([-.6, 0, 0])
                rotate([90, 0, 0])
                    ring_extrude(shape, radius = .5, angle = rand(60, 65), scale = .025, twist = rand(5, 45));
            }

            for(i = range) {
                rotate(i * a_step + rand_angles[1])
                scale([1, 1, 2])
                translate([-.65, 0, 0])
                rotate([90, 0, 0])
                    ring_extrude(shape, radius = .5, angle = rand(80, 85), scale = .025, twist = rand(5, 45));
            }

            for(i = range) {
                rotate(i * a_step + rand_angles[2])
                translate([-.675, 0, 0])
                rotate([90, 0, 0])
                    ring_extrude(shape, radius = .5, angle = rand(90, 95), scale = .025, twist = rand(5, 45));
            }
        }
    }
}