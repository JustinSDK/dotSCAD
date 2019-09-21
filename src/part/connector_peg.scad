module connector_peg(radius, spacing = 0.5, height = radius * 2.6, void = false, heads = false) {
    lip_r = radius * 1.2;
    r_diff = lip_r - radius;
    h_unit = height / 7;
    d_h_unit = h_unit * 2;
    half_h_unit = h_unit / 2;
    
    module base(radius, lip_r) {   
        rotate_extrude() {
            translate([0, -d_h_unit + height]) hull() {
                square([lip_r - r_diff, d_h_unit]); 
                translate([0, half_h_unit]) 
                    square([lip_r, half_h_unit]);
            }
            square([radius, height - d_h_unit]);                        
        }
    }

    module peg() {
        difference() {
            base(radius, lip_r);
            
            translate([0, 0, d_h_unit])  
                linear_extrude(height - r_diff * 2) 
                    square([r_diff * 2, lip_r * 2], center = true);
        }
    }

    module peg_void() {
        base(radius + spacing, lip_r + spacing);
        translate([0, 0, height]) 
            linear_extrude(spacing) 
                circle(lip_r);
    }
 
    module head() {
        if(void) {
            peg_void();
        }
        else {
            peg();
        }
    } 

    if(heads) {
        translate([0, 0, height]) {
            head();
            mirror([0, 0, 1]) head();
        }
    }
    else {
        head();
    }    
}    