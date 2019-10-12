module soccer_polyhedron(circumradius, r_offset = 0) {
    tau = 1.618034;
    a = -37.377368;
    scale_f = 0.201774;
    r_off = scale_f * r_offset;
    
    module pentagonal_pyramid() {
        pentagon_r = 1.701302;
        pentagon_h = 4.654877;

        translate([0, 0, -pentagon_h - r_off])
        linear_extrude(pentagon_h, scale = 0.01) 
        rotate(-36)
            circle(pentagon_r, $fn = 5);    
    }
    
    module hexagonal_pyramid() {
        hexagon_r = 2;
        hexagon_h = 4.534568;
        translate([0, 0, -hexagon_h - r_off])
                linear_extrude(hexagon_h, scale = 0.001) 
                rotate(-30)
                    circle(hexagon_r, $fn = 6);  
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
        rotate(36)
        mirror([0, 0, 1])
            half_soccer_polyhedron();    
    }
}

soccer_polyhedron(10);
%sphere(10, $fn = 48);
  