use <hollow_out.scad>
use <part/joint_T.scad>
use <triangle2square.scad>

tri_side_leng = 45;
height = 6;
spacing = 0.4;
ring_width = 1.5;  
shaft_r = 1;  
chain_hole = "YES";  // [YES, NO]
chain_hole_width = 2.5;
    
module triangle2square_pendant(tri_side_leng, height, spacing, ring_width, shaft_r) {
	
	half_tri_side_leng = tri_side_leng / 2;
    half_h = height / 2;

    joint_ring_inner = shaft_r + spacing;
	joint_r_outermost = joint_ring_inner + ring_width + spacing;

    offsetd = -spacing / 2;
    tri_sq = triangle2square(tri_side_leng);
    linear_extrude(height) {
        difference() {
            offset(offsetd) polygon(tri_sq[0][0]);
            translate(tri_sq[1][2]) circle(joint_r_outermost);
        }
        difference() {
            offset(offsetd) polygon(tri_sq[0][1]);
            translate(tri_sq[1][0]) circle(joint_ring_inner);
        }
        
        difference() {
            offset(offsetd) polygon(tri_sq[0][2]);
            translate(tri_sq[1][0]) circle(joint_r_outermost);
            translate(tri_sq[1][1]) circle(joint_ring_inner);
        }
        
        difference() {
            offset(offsetd) polygon(tri_sq[0][3]);
            translate(tri_sq[1][2]) circle(joint_ring_inner);
            translate(tri_sq[1][1]) circle(joint_r_outermost);
        }
    }
    
    
    translate(tri_sq[1][0]) rotate(65) joint_T(shaft_r, height, joint_r_outermost, ring_width, spacing);
    translate(tri_sq[1][1]) rotate(170) joint_T(shaft_r, height, joint_r_outermost, ring_width, spacing);
    translate(tri_sq[1][2]) rotate(275) joint_T(shaft_r, height, joint_r_outermost, ring_width, spacing);   
}


$fn = 36;
difference() {
	triangle2square_pendant(tri_side_leng, height, spacing, ring_width, shaft_r);
	if(chain_hole == "YES") {
		translate([spacing * 1.5, spacing, height / 2]) 
        linear_extrude(chain_hole_width, center = true)
        hollow_out(chain_hole_width) 
            circle(shaft_r + spacing + chain_hole_width);
	}
}

