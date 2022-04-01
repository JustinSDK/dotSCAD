width = 70;
joint_h = 2;
level = 4;
reducing_scale = 0.575; // [0:0.707107]
$fn = 8;

module drilled_cube(width, reducing_scale, joint_h, level) {
    module drills(width, reducing_scale, joint_h, level) {
        w = width * reducing_scale;
        r = 1.41421 * w / 2;
        if(level > 0) {
            z_offset = w / 2 + joint_h;    
            for(i = [0:3]) {
                rotate([i * 90, 0, 0])
                translate([0, 0, z_offset])
                linear_extrude(width)
                    circle(r);
            }
            
            for(ay = [90, -90]) {
                rotate([0, ay, 0])
                translate([0, 0, z_offset])
                linear_extrude(width)
                    circle(r);
            }  
            
            drills(z_offset * 2, reducing_scale, joint_h, level - 1);
        }
        else {
            for(i = [0:3]) {
                rotate([i * 90, 0, 0])
                linear_extrude(width)
                    circle(r);
            }
            
            for(ay = [90, -90]) {
                rotate([0, ay, 0])
                linear_extrude(width)
                    circle(r);
            }      
        }
    }

    difference() {
        cube(width, center = true);
        drills(width, reducing_scale, joint_h, level - 1);
    }
}


drilled_cube(width, reducing_scale, joint_h, level);