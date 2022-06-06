use <along_with.scad>
use <box_extrude.scad>

platform = "YES"; // [YES, NO]
cube_only = "NO";   // [YES, NO]

cargo_container_landmark();

module cargo_container_landmark() {
    cargo_width = 15;
    cargo_height = 16;
    cargo40ft_len = 75;
    cargo20ft_len = cargo40ft_len / 2;

    module cargo20ft() {
        if(cube_only == "NO") {
            cargo_container(cargo20ft_len, cargo_width, cargo_height);
        }
        else {
            cube([cargo20ft_len, cargo_width, cargo_height]);
        }
    }

    module cargo40ft() {
        if(cube_only == "NO") {
            cargo_container(cargo40ft_len, cargo_width, cargo_height);
        }
        else {
            cube([cargo40ft_len, cargo_width, cargo_height]);
        }
    }
    
    module cargoL1() {        
        translate([cargo_height, 0, -cargo20ft_len]) 
        rotate([0, -90, 0]) 
            cargo20ft();

        cargo40ft();
    }

    color("red") 
    translate([-40, -10, 38.75]) 
    rotate([18.315, 17.75, 0]) {
        translate([cargo40ft_len + cargo_width, cargo_width - cargo20ft_len, 0]) 
        rotate(90) 
            cargo20ft();

        translate([cargo20ft_len + cargo_width, -cargo20ft_len, 0]) 
            cargo20ft();

        translate([cargo_width + cargo20ft_len, -cargo40ft_len + cargo20ft_len, cargo40ft_len - cargo20ft_len])  
        rotate(90) 
            cargoL1();
    
        translate([cargo_width, cargo20ft_len, -cargo20ft_len]) {
            translate([cargo20ft_len, 0, cargo_height]) 
            rotate([0, -90, 0]) 
                cargo40ft();

            cargo20ft();
        }    
    
        cargoL1();
        translate([cargo_width, cargo_width, -cargo20ft_len]) 
        rotate([0, 0, 90]) 
            cargo20ft();
    }
    
    if(platform == "YES") {
        color("black") 
        box_extrude(height = 2, shell_thickness = 1)  
            circle(75, $fn = 96);
    }    
}

module cargo_container(leng, width, height) {
    d_offset = height / 400;
    half_leng = leng / 2;
    half_h = height / 2;
    half_w = width / 2;
    edge = height / 40;

    y = width * 0.425;
    z = -height / 400;
    h = height / 30;
    size = [height * 0.045, y * 0.8];
    
    module railing(nums, leng, thickness) {
        step_x = leng / nums;
        half_step_x = step_x * 0.5;
        points = [for(i = [0:nums - 1]) [-half_leng + i * step_x + half_step_x, 0]];

        along_with(points) 
        rotate([-90, 90, 0]) 
        linear_extrude(thickness, scale = [0.7, 0.9], center = true) 
            square([half_step_x, height - edge], center = true);
    }         
    
    module door() {
        difference() {
            linear_extrude(height / 40, scale = 0.95) 
                square([height * 0.9, y], center = true);
            
            for(i = [-1:1]) {
                translate([-height / 4.25 * i, 0, z]) 
                linear_extrude(h, scale = 0.95) 
                    square(size, center = true);
            }
        }
    }    

    rail_w = width / 8;
    rails = leng / rail_w;
    thickness = height / 40;
    half_thickness = thickness / 2;

    module side() {
        translate([half_leng, half_w - half_thickness + d_offset, half_h]) 
        rotate([90, 0, 0]) 
            railing(rails, leng, thickness);  
                        
    }   
    
    translate([0, half_w, 0]) {
        difference() {
            translate([0, -half_w, 0]) 
                cube([leng, width, height]);
                   
            union() {
                // front
                translate([-d_offset, 0, half_h]) 
                rotate([0, 90, 0]) 
                linear_extrude(thickness, scale = 0.95) 
                    square([height * 0.95, width * 0.95], center = true);
                          
                // back
                translate([leng - half_thickness + d_offset, 0, half_h]) 
                rotate([90, 0, -90]) 
                    railing(8, width, thickness);

                // top
                translate([half_leng, 0, height - half_thickness + d_offset]) 
                rotate([180, 0, 0]) 
                scale([1, (width - edge) / height, 1]) 
                    railing(rails, leng, thickness);
                            
                side();
                mirror([0, 1, 0]) 
                    side();             
            }    

            // bottom
            translate([half_leng, half_w, -height / 400]) 
            linear_extrude(height / 80, scale = 0.95) 
                square([leng * 0.975, width  * 0.9], center = true);
        }
        
        translate([0, 0, half_h]) 
            rotate([0, 90, 0]) {
                translate([0, width / 4.45, 0])
                    door();
                translate([0, -width / 4.45, 0]) 
                    door();
            }
    }
}