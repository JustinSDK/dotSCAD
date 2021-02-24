/**
* connector_peg.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-connector_peg.html
*
**/ 

module connector_peg(radius, height, spacing = 0.5, void = false, ends = false) {
    lip_r = radius * 1.2;
    r_diff = lip_r - radius;

    h = radius * 2.6; 
    h_unit = h / 7; 
    h_head = h_unit * 2;
    half_h_unit = h_unit / 2;

    total_height = is_undef(height) ? radius * 2.5 : height;
    
    module base(radius, lip_r) {   
        rotate_extrude() {
            translate([0, total_height - h_head]) 
            hull() {
                square([lip_r - r_diff, h_head]); 
                translate([0, half_h_unit]) square([lip_r, half_h_unit]);
            }
            square([radius, total_height - h_head]);                        
        }
    }

    module peg() {
        difference() {
            base(radius, lip_r);
            
            translate([0, 0, h_head])  
            linear_extrude(total_height) 
                square([r_diff * 2, lip_r * 2], center = true);
        }
    }

    module peg_void() {
        base(radius + spacing, lip_r + spacing);
        translate([0, 0, total_height]) 
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

    if(ends) {
        translate([0, 0, h]) {
            head();
            mirror([0, 0, 1]) head();
        }
    }
    else {
        head();
    }    
}    