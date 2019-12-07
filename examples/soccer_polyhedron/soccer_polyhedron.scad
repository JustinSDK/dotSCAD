module soccer_polyhedron(circumradius, spacing, jigsaw_base = false, half = false) {
    tau = 1.618034;
    a = -37.377368;
    scale_f = 0.201774;
    
    s = scale_f * spacing / 2;
    
    module pentagonal_pyramid() {
        pentagon_r = 1.701302;
        pentagon_h = 4.654877;
        
        convex_r = pentagon_r / 5 - s / 2;

        r_off = s / 0.759856;
        h_off = s / 0.343279;

        color("black")
        translate([0, 0, -pentagon_h])
        linear_extrude(pentagon_h - h_off, scale = 0.001) 
        rotate(-36) {
            circle(pentagon_r - r_off, $fn = 5);

            // rewrite here if you want to make different convex parts
            if(jigsaw_base) {
                for(i = [0:4]) {
                    rotate(36 + i * 72)
                    translate([pentagon_r - r_off - convex_r / 2, 0, 0]) 
                        circle(convex_r, $fn = 36);
                }
            }
        }
    }
    
    module hexagonal_pyramid() {
        hexagon_r = 2;
        hexagon_h = 4.534568;
        pentagon_r = 1.701302;
        concave_r = pentagon_r / 5 + s / 2;

        r_off = s / 0.792377;
        h_off = s /  0.403548;

        color("white")
        translate([0, 0, -hexagon_h])
        linear_extrude(hexagon_h - h_off, scale = 0.001) 
        rotate(-30) {
            difference() {
                circle(hexagon_r - r_off, $fn = 6); 

                // rewrite here if you want to make different concave parts
                if(jigsaw_base) {
                    for(i = [0:2]) {
                        rotate(90 + i * 120)
                        translate([hexagon_r - r_off - concave_r, 0, 0]) 
                            circle(concave_r, $fn = 36);
                    }   
                }   
            }
        }
    }

    module one_component_around_pentagonal_pyramid() {
        mirror([1, 0, 0]) 
        rotate([0, -a, 60]) {
            pentagonal_pyramid();
            for(i = [0:1]) {
                rotate([0, a, 72 * i])
                    hexagonal_pyramid(); 
            }    
        }    
    }
    
    module half_soccer_polyhedron() {
        pentagonal_pyramid();
        for(i = [0:4]) {
            rotate([0, a, 72 * i])
                one_component_around_pentagonal_pyramid(); 
        }       
    }

    scale(scale_f * circumradius) {
        half_soccer_polyhedron();
        if(!half) {
            rotate(36)
            mirror([0, 0, 1])
                half_soccer_polyhedron();    
        }
    }
}

soccer_polyhedron(30, 1);
%sphere(30, $fn = 48);