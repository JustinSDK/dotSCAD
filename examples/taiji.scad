use <arc.scad>

radius = 30;
thickness = 2.5;
spacing = 0.4;
fn = 48;
style = "SOLID"; // [SOLID, HOLLOW]

module half_taiji(radius, thickness, spacing, fn, style) {
    $fn = fn;
    
    half_spacing = spacing / 2;
    big_cone_offset = half_spacing * 1.414213;
    small_cone_offset = spacing / sin(atan(0.25));
        
    module ball() {
        if(style == "HOLLOW") {
            rotate_extrude() 
                arc(
                    radius = radius, 
                    angle = [-90, 90], 
                    width = thickness, 
                    width_mode = "LINE_INWARD"
                );        
        }
        else {
            sphere(radius);
        }
    }
    
    module cone(br, offset) {
        translate([0, 0, -radius - offset])
        linear_extrude(radius, scale = 0)
            circle(br);    
    }
    
    
    module c_shell() {
        intersection() {
            ball();
            
            union() {
                rotate_extrude(angle = 180) 
                polygon([
                    [big_cone_offset, 0],
                    [radius, -radius + big_cone_offset],
                    [radius, radius - big_cone_offset],
                ]);

                rotate([0, 90, 0]) cone(radius, big_cone_offset);
                rotate([0, -90, 0]) cone(radius, big_cone_offset);     
            }
        }    
    }
    
    module dot_df() {
        intersection() {
            ball();
            
            union() {
                rotate([0, 90, 0]) cone(radius / 4, 0);
                rotate([0, -90, 0]) cone(radius / 4, 0);            
            }
        }
    }

    difference() {
        c_shell();
        dot_df();        
    }
    
    intersection() {
        ball();
        union() {
            rotate([0, 90, 0]) cone(radius / 4, small_cone_offset);
            rotate([0, -90, 0]) cone(radius/ 4, small_cone_offset);
        }
    }
} 

rotate([0, 90, 180])
    half_taiji(radius, thickness, spacing, fn, style);

half_taiji(radius, thickness, spacing, fn, style);