use <polyline_join.scad>

length = 100;
width = 50;
depth = 40;
thickness = 3;
hole_r = 8;

$fn = 24;

wormhole(length, width, depth, thickness, hole_r);

module wormhole(length, width, depth, thickness, hole_r) {
    a_step = 360 / $fn;
    r1 = depth / 2;
    r2 = width / 4;
    half_thickness = thickness / 2;

    plane = [
        [length - r1, r1], 
        each [for(a = [90:a_step:270]) r1 * [cos(a), sin(a)]], 
        [length - r1, -r1]
    ];

    difference() {
        rotate([90, 0, 0])
        linear_extrude(width, center = true)
        polyline_join(plane)
                square(thickness, center = true);
            
        translate([(length - r1) / 2, 0])
        linear_extrude(depth + thickness * 2, center = true)
            circle(r2 + hole_r);
    }


    hole_profile = concat(
        [for(a = [90:a_step:180]) r2 * [cos(a), sin(a)]], 
        [[-r2, -(r1 - r2) + half_thickness]]
    );
    
    module hole() {
        translate([(length - r1) / 2, 0, r1 - r2])
        rotate_extrude()
        translate([r2 + half_thickness + hole_r, 0])
        polyline_join(hole_profile)
            square(thickness, center = true);
    }

    hole();

    mirror([0, 0, 1])
        hole() ;
}