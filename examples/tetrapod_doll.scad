use <rounded_cylinder.scad>
use <polyhedra/geom_tetrahedron.scad>
use <util/rand.scad>
use <pp/pp_poisson2.scad>

radius = 20;
$fn = 6; // multiples of 6
model = "DOLL"; // [DOLL, EYES]

if($preview) {
    points = pp_poisson2([150, 150], radius * 2.25);
    for(p = points) {
        translate(p)
        rotate(rand(-25, 25))
            tetrapod_doll();
    }
}
else {
    tetrapod_doll();
}

module tetrapod_doll() {
    function __angy_angz(p1, p2) = 
        let(v = p2 - p1) 
        [
            atan2(v.z, norm([v.x, v.y])), 
            atan2(v.y, v.x)
        ];
        
    module doll() {
        vertices = geom_tetrahedron(radius = radius)[0];

        ayz = __angy_angz(vertices[0], [0, 0, 0]);

        color(rands(0, 1, 3))
        difference() {
            rotate([0, 90 - ayz[0], 0])
            rotate(ayz[1])
            for(p = vertices) {
                ayz = __angy_angz(p, [0, 0, 0]);

                rotate([0, 90 + ayz[0], ayz[1]])
                translate([0, 0, 2 / 4.158])
                rounded_cylinder(
                    radius = [radius * .4, radius * .275], 
                    h = radius, 
                    round_r = 2
                );    
            }

            rotate(40)
            translate([radius * .2, 0, radius * .6])
            scale(1.05)
                eye();

            rotate(-40)
            translate([radius * .2, 0, radius * .6])
            scale(1.05)
                eye();
        }
    }

    module eye() {
        color("white")
        difference() {
            translate([radius / 5.75 / 2, 0, 0])
                sphere(radius / 5.75, $fn = 48);
            translate([-radius / 2, 0, 0])
                cube(radius, center = true);
        }
    }

    if($preview) {
        doll();

        rotate(40)
        translate([radius * .2, 0, radius * .6])
            eye();

        rotate(-40)
        translate([radius * .2, 0, radius * .6])
            eye();
        
        color("black")
        rotate([rand(-3, 3), rand(-3, 3), 30 + rand(-3, 3)])
        translate([radius * .2, 0, radius * .6])
        translate([radius / 5, 0, 0])
            sphere(radius / 5.75 / 2, $fn = 48);
            
        color("black")
        rotate([rand(-3, 3), rand(-3, 3), -30 + rand(-3, 3)])
        translate([radius * .2, 0, radius * .6])
        translate([radius / 5, 0, 0])
            sphere(radius / 5.75 / 2, $fn = 48);
    }
    else {
        if(model == "DOLL") {
            doll();
        }
        else {
            translate([radius, 0, 0])
            rotate([0, -90, 0])
                eye();
                
            translate([radius * 1.5, 0, 0])
            rotate([0, -90, 0])
                eye();
        }
    }
}
