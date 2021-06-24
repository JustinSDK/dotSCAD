use <crystal_ball.scad>;

leng = 30;
leng_diff = 3;
min_leng = 2;
model = "Cube"; // [Cube, Base, Both]

module spiral_cube(leng, leng_diff, min_leng) {
    thickness = leng_diff / 3;
    starting_leng = leng + leng_diff * 2 + thickness * 2.5;
    half_leng = leng / 2;
    pow_leng_diff = pow(leng_diff, 2);
    module spiral_stack(current_leng, pre_height = 0, i = 0) {
        factor = current_leng / starting_leng;
        
        if(current_leng > min_leng && current_leng > leng_diff && half_leng > pre_height) {
            translate([0, 0, pre_height]) 
            scale([factor, factor, 1]) 
                children();
           
            rotate(atan2(leng_diff, current_leng - leng_diff))
            spiral_stack(
                sqrt(pow_leng_diff + pow(current_leng - leng_diff, 2)),           
                thickness + pre_height,
                i + 1
            ) children();
        }
        else if(half_leng > pre_height) {
            translate([0, 0, pre_height]) 
            scale([factor, factor, (half_leng - pre_height) / thickness]) 
                children();
        }
    }
    
    module spiral_squares() {
        difference() {
            translate([0, 0, -half_leng]) 
            spiral_stack(leng)
            translate([0, 0, thickness / 2]) 
                cube([leng , leng, thickness * 1.01], center = true);
        }
    }

    module pair_spiral_squares() {
        spiral_squares();
       // mirror([0, 0, 1])
        rotate([180, 0, 0])
            spiral_squares();
    }

    difference() {
        cube(leng * 0.99, center = true);
        
        union() {
            pair_spiral_squares();
            rotate([90, 0, 0]) pair_spiral_squares();
            rotate([0, 90, 0]) pair_spiral_squares();
        }
    }
}

module base(leng) {
    $fn = 96;
    r = leng / 3;
    difference() {
        crystal_ball(
            radius = r, 
            theta = 360,
            phi = 90
        ); 
        translate([0, 0, leng * sqrt(3) / 2 + leng / 15]) 
        rotate([45, atan2(1, sqrt(2)), 0]) 
            cube(leng * 0.99, center = true);
    }
}

if(model == "Cube") {
    spiral_cube(leng, leng_diff, min_leng);
} else if(model == "Base") {
    base(leng);
} else {    
    translate([0, 0, leng * sqrt(3) / 2 + leng / 15]) 
    rotate([45, atan2(1, sqrt(2)), 0]) 
        spiral_cube(leng, leng_diff, min_leng);
    base(leng);
}

